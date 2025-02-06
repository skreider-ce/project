#' fill_registry_qc_doc
#' @description Function that fills in the Registry QC document for monthly and quarterly reports
#'
#'
#' @param sp_qc_doc_path path to the registry QC document file
#' @param results_folder local results or reports folder to save the filled in QC document
#' @param final_name the final QC document file name
#' @param analyst_initials Initials of the analyst
#'
#' @return returns a list with the raw filled in result table and the flextable as well as the saved QC document
#' @export
#'
#' @importFrom docxtractr read_docx docx_extract_tbl
#' @importFrom huxtable as_huxtable as_flextable
#' @importFrom dplyr %>% mutate left_join case_when filter select
#' @importFrom  utils select.list
#' @importFrom officer prop_section page_mar page_size fp_border
#' @importFrom glue glue
#' @importFrom flextable add_body_row merge_at rotate valign align border add_footer_lines width line_spacing save_as_docx bg
fill_registry_qc_doc <- function(sp_qc_doc_path, results_folder, final_name, analyst_initials){
  ## Copy QC check document from sharepoint -----------------------------------------------------------
  file.copy(from = glue("{sp_qc_doc_path}"),
            to = glue("{results_folder}/Report QC checklist.docx"))

  ## Read in QC document -----
  qc_doc <-  docxtractr::read_docx(glue("{results_folder}/Report QC checklist.docx"))
  qc_doc_header <- c("", "Task", "Analyst", "Initials", "Biostat Lead", "Initials - BL")
  qc_doc_tbl <- docx_extract_tbl(qc_doc, tbl_number = 1, header = TRUE, preserve = FALSE, trim = TRUE)
  colnames(qc_doc_tbl)[c(5:6)] <- c("Biostat Lead", "Initials - BL")

  ## Respond to questions in QC document -----
  questions <- qc_doc_tbl %>%
    filter(Analyst %in% c("X", "S"))

  filled_in_initials <- c()
  for ( i in 1:length(questions$Task)){
    curr_title_question <- questions$Task[i]
    print(curr_title_question)

    curr_question_response <- select.list(c("Yes", "No"), multiple = F, title = curr_title_question)

    if (curr_question_response== "Yes"){
      curr_filled_in_initials = analyst_initials
    } else {
      curr_filled_in_initials = NA
    }

    filled_in_initials <- c(filled_in_initials, curr_filled_in_initials)
  }

  filled_in_results <- data.frame(Task = questions$Task, filled_in_initials)

  ## Fill in QC document -----
  qc_doc_tbl_flex <- qc_doc_tbl %>%
    left_join(., filled_in_results, by="Task") %>%
    as_huxtable(add_colnames = F) %>%
    mutate(Initials = case_when(Analyst %in% c("X", "S")    ~ filled_in_initials,
                                TRUE                        ~ Initials)) %>%
    select(- filled_in_initials) %>%
    huxtable::as_flextable() %>%
    flextable::add_body_row(values = c("", "Task", "Analyst", "Initials", "Biostat Lead", "Initials - BL")) %>%
    flextable::merge_at(j=1, i=2:nrow(.$body$dataset))  %>%
    rotate(j=1, i=2:nrow(.$body$dataset), align = "bottom", rotation = "btlr") %>%
    flextable::valign(j=1, i=2:nrow(.$body$dataset), valign="center") %>%
    flextable::align(j=2:ncol(.$body$dataset), align = "center") %>%
    bg(i = 1, bg = "grey65") %>%
    flextable::border(border= fp_border(width = .75, color = "#000000")) %>%
    flextable::add_footer_lines("*Note: 'X' means primary responsibility; 'S' means secondary responsibility.") %>%
    flextable::width(j = 1:6, width = c(.5, 7, .8, .8, .8, .8)) %>%
    # Set Line Spacing
    flextable::line_spacing(space=0.8, part="body")

  sect_properties <- prop_section(
    page_size = page_size(
      orient = "landscape",
      width = 11.7, height = 8.3),
    type = "continuous",
    page_margins = page_mar(bottom = .5, top = .5, right = .25, left = .25))

  print(glue("Saving Local QC Checklist to {results_folder}/{final_name}.docx"))
  save_as_docx(`Table 3: Registry Monthly and Quarterly Report QC Checklist` = qc_doc_tbl_flex,
               path = glue("{results_folder}/{final_name}.docx"),
               pr_section = sect_properties)

  file.remove(glue("{results_folder}/Report QC checklist.docx"))

  return(list(filled_in_results, qc_doc_tbl_flex))
}
