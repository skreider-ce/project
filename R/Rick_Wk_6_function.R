#' Misspell generator
#'
#' @param word A word to misspell
#' @param start_pos The position of the first letter you'd like swapped
#' @param split_num The distance between the next the first and second letter you'd like swapped
#'
#' @return A misspelled word
#' @export
#'
#' @examples misspell_swap2("test", 1,2)



#Random Character Swap:  Swap two adjacent characters

misspell_swap2 <- function(word, start_pos, split_num) {
  word_length <- nchar(word)
  
  # Check for errors
  if (start_pos > word_length || split_num > word_length || (start_pos + split_num) > word_length) {
    return("Word length cannot accomodate your parameters")
  }
  
  # Ensure the position to swap is valid
  pos <- start_pos
  chars <- strsplit(word, NULL)[[1]]
  
  # Swap characters
  temp <- chars[pos]
  chars[pos] <- chars[pos + split_num]
  chars[pos + split_num] <- temp
  
  return(paste(chars, collapse = ""))
}


