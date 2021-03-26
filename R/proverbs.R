get_proverb_dataset <- function(){

  test <- xml2::read_html("https://nightvale.fandom.com/wiki/List_of_Proverbs")

  t <- test %>%
    rvest::html_nodes("tr") %>%
    rvest::html_text()

  meta <- t[-1] %>%
    data.frame(number = ., stringsAsFactors = FALSE) %>%
    # Extract every odd row
    dplyr::slice(which(dplyr::row_number() %% 2 == 1)) %>%
    # Remove live shows
    dplyr::slice(1:which(.$number == "Show No.\n\nTitle\n\nRelease Date\n")-1) %>%
    # Split into component parts
    tidyr::separate(number,
             c("number","title", "airdate"),
             sep = '\n\n') %>%
    # Remove quotes
    dplyr::mutate(title = stringr::str_replace_all(title,'\"',""),
           number = stringr::str_replace_all(number,'\"',""),
           airdate = stringr::str_replace_all(airdate,'\"',"")) %>%
    # Remove trailing newline character from airdate/
    dplyr::mutate(airdate = stringr::str_replace(airdate,"\n",""))

  proverb <- t[-1] %>%
    data.frame(proverb = ., stringsAsFactors = FALSE) %>%
    # Extract every even row
    dplyr::slice(which(dplyr::row_number() %% 2 == 0)) %>%
    # Remove proverbs from live shows
    dplyr::slice(1:which(.$proverb == "1\n\n\"Condos\"\n\n25 September 2013\n")-1) %>%
    # Generate two new variables describing the nchar and nwords
    dplyr::mutate(proverb_len_char = nchar(proverb),
           proverb_len_word = stringr::str_count(proverb, '\\w+')) %>%
    # Adjust random newlines at start and end of proverbs
    dplyr::mutate(proverb = stringr::str_replace(proverb,"\n\n$",""),
           proverb = stringr::str_replace(proverb,"\n$",""),
           proverb = stringr::str_replace(proverb,"^\n","")) %>%
    # Add unique id
    dplyr::mutate(id = seq_along(1:dplyr::n())) %>%
    # Bind to metadata and reorder
    cbind(meta, .) %>%
    dplyr::select(id, dplyr::everything()) %>%
    tidyr::tibble()

}

#' Title
#'
#' @param id
#'
#' @return
#' @export
proverb <- function(id) {

  n_row <- seq_along(1:nrow(proverb_data))

  if (!hasArg(id)) {
    id <- sample(n_row,1)
  }

  cat(paste0(proverb_data$proverb[id],
        "\n    -- \"",
        proverb_data$title[id],
        "\", ",
        proverb_data$airdate[id]))

}
