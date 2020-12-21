#'@title Add endpoint path to base URL
#'
#'@description Add endpoint path to base URL
#'
#'@param path character. Endpoint path
#'
#'@return None.
#'
#'@export

add_endpoint <- function(path) {
  paste0("/api/v2.1/", path)
}


#'@title Api keys checker function
#'
#'@description Function to check whether the API key has been set.
#'
#'@param x character. API key
#'@export

is_key_null <- function(x = NULL) {
  if (is.null(x)) {
    stop("\nPlease provide an API key.\nYou can request it here\nhttps://developers.zomato.com/api")
  }
}

#'@title Error handler function
#'
#'@description Functions to handle errors if the api request is unsuccessful.
#'
#'@param x list. List generated from API request
#'@param msg Character. The message to be displayed if the request is unsuccessful
#'
#'@importFrom httr http_error status_code
#'@export

handle_error <- function(x, msg) {
  if (httr::http_error(x)) {
    stop(
      sprintf(
        "Zomato API request failed [%s]\n%s",
        httr::status_code(x),
        msg
      ),
      call. = FALSE
    )
  }
}

#'@title Get the data from API
#'
#'@description A function for requesting and parsing data from the API
#'
#'@param api_key Character. User API key
#'@param path Character. Endpoint path.
#'@param ... Further arguments passed to
#'
#'@importFrom httr modify_url GET add_headers content
#'@importFrom jsonlite fromJSON
#'@export

get_data <- function(api_key = NULL, path, ...){

  # Check api key ----
  is_key_null(api_key)

  # Specify base url ----
  base_url <- "https://developers.zomato.com"

  # Modify base url ----
  url <- httr::modify_url(base_url, path = add_endpoint(path))

  # Send a request
  resp <- httr::GET(
    url = url,
    config = httr::add_headers("user-key" = api_key),
    ...
  )

  # Parse the JSON File
  parsed <- jsonlite::fromJSON(
    httr::content(
      resp, as = "text", type = "application/json", encoding = "UTF-8"
    ),
    flatten = TRUE
  )

  return(list(resp = resp, parsed = parsed))
}
