#' Claims study buddy status for two people.
#'
#' @param buddy.1 A name for a buddy.
#' @param buddy.2 A name for a different buddy.
#' @returns A statement of buddy status.
#' @examples
#' study_buddy("Jason", "Rick", "2025-01-31")

study_buddy <- function(buddy.1, buddy.2, date) {
  print(glue::glue("{buddy.1} and {buddy.2} became study buddies on {date}."))
}
