#' Extract proverbs from webpage
#'
#' @keywords internal
#'
#' @importFrom magrittr "%>%"
#' @importFrom rlang .data
get_proverb_dataset <- function(){

  t <- xml2::read_html("https://nightvale.fandom.com/wiki/List_of_Proverbs") %>%
    rvest::html_nodes("tr") %>%
    rvest::html_text()

  meta <- data.frame(number = t[-1], stringsAsFactors = FALSE) %>%
    # Extract every odd row
    dplyr::slice(which(dplyr::row_number() %% 2 == 1)) %>%
    # Remove live shows
    dplyr::slice(1:which(.data$number == "Show No.\n\nTitle\n\nRelease Date\n")-1) %>%
    # Split into component parts
    tidyr::separate(.data$number,
             c("number","title", "airdate"),
             sep = '\n\n') %>%
    # Remove quotes
    dplyr::mutate(title = stringr::str_replace_all(.data$title,'\"',""),
           number = stringr::str_replace_all(.data$number,'\"',""),
           airdate = stringr::str_replace_all(.data$airdate,'\"',"")) %>%
    # Remove trailing newline character from airdate/
    dplyr::mutate(airdate = stringr::str_replace(.data$airdate,"\n",""),
                  title = stringr::str_replace(.data$title,"\nTelly version"," (Telly Version)"))

  proverbs <- data.frame(proverb = t[-1], stringsAsFactors = FALSE) %>%
    # Extract every even row
    dplyr::slice(which(dplyr::row_number() %% 2 == 0)) %>%
    # Remove proverbs from live shows
    dplyr::slice(1:which(.data$proverb == "1\n\n\"Condos\"\n\n25 September 2013\n")-1) %>%
    # Adjust random newlines at start and end of proverbs
    dplyr::mutate(proverb = stringr::str_replace(.data$proverb,"\n\n$",""),
                  proverb = stringr::str_replace(.data$proverb,"\n$",""),
                  proverb = stringr::str_replace(.data$proverb,"^\n","")) %>%
    # Add unique id
    dplyr::mutate(id = seq_along(1:dplyr::n()))



  # Bind to metadata and reorder
  proverb_data <- cbind(meta, proverbs) %>%
    dplyr::select(.data$id, dplyr::everything()) %>%
    tidyr::tibble()

  return(proverb_data)

}

#' Print a Welcome to Night Vale (WTNV) proverb to the console
#'
#' @param id If no ID is specified, then a random WTNV proverb is returned.
#' @param show_meta Whether to display the metadata (episode title and airdate)
#'   for the proverb. Default is TRUE.
#' @param show_id Whether to display the ID of the proverb. Default is FALSE.
#' @param as_string If FALSE (default), print proverb to the console. If TRUE,
#'   return proverb as string (useful if, for example, you want to pass the
#'   proverb to the cowsay package).
#'
#' @export
#' @importFrom magrittr "%>%"

proverb <- function(id,
                    show_meta = TRUE,
                    show_id = FALSE,
                    as_string = FALSE) {

  proverbs_df <- nightvale::proverb_data

  n_row <- seq_along(1:nrow(proverbs_df))

  if (!methods::hasArg(id)) {
    id <- sample(n_row, 1)
  }

  proverb_text <- proverbs_df$proverb[id]

  if (show_meta == TRUE) {
    proverb_text <- paste0(proverb_text,
                           "\n    -- \"",
                           proverbs_df$title[id],
                           "\", ",
                           proverbs_df$airdate[id])
  }

  if (show_id == TRUE) {
    proverb_text <- paste0(proverb_text,
                           " (#",
                           id
                           ,")")
  }

  if (as_string == FALSE) {
    cat(proverb_text)
  } else {
    return(proverb_text)
  }
}
