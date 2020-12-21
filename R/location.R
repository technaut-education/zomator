#'@title Get Zomato location details
#'
#'@description Get Foodie Index, Nightlife Index, Top Cuisines and Best rated restaurants in a given location.
#'
#'
#'
#'@param entity_id Integer. location id obtained from \code{get_locations}.
#'@param entity_type Character. location type obtained from \code{get_locations}.
#'@param api_key Character. Api key.
#'
#'@return A list
#'
#'@examples
#'\dontrun{
#'get_location_details(entity_id = 114178, entity_type = subzone,
#'                     api_key = Sys.getenv("ZOMATO_API_KEY"))
#'}
#'@importFrom tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>%
#'@importFrom purrr map_lgl
#'@export


get_location_details <- function(entity_id        = NULL,
                                 entity_type      = NULL,
                                 api_key          = Sys.getenv("ZOMATO_API_KEY")){

  restaurant.apikey <- NULL

  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(entity_id, entity_type), is.null))){
    stop(paste("Please provide entity_id and entity_type"))
  }

  query_list <- list(entity_id        = entity_id,
                entity_type      = entity_type
  )

  data <- get_data(api_key = api_key,
                   path = "location_details",
                   query = query_list)

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  data[["parsed"]][["best_rated_restaurant"]] <- tibble::as_tibble(data[["parsed"]][["best_rated_restaurant"]]) %>%
    select(-restaurant.apikey) %>%
    janitor::clean_names()

  data[["parsed"]][["location"]] <- data[["parsed"]][["location"]] %>%
    tibble::as_tibble() %>%
    janitor::clean_names()

  data[["parsed"]][["experts"]] <- data[["parsed"]][["experts"]] %>%
    tibble::as_tibble() %>%
    janitor::clean_names()

  data

}

#'@title Search for locations
#'
#'@description Search for Zomato locations by keyword. Provide coordinates to get better search results.
#'
#'
#'@param query String. suggestion for location name.
#'@param lat Double. Latitude
#'@param lon Double. Longitude
#'@param max Integer. Number of max results to display
#'@param api_key Character. Api key.
#'
#'@return A tibble
#'
#'@examples
#'\dontrun{
#'get_locations(query   = "london",
#'              api_key = Sys.getenv("ZOMATO_API_KEY"))
#'}
#'@importFrom tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>%
#'@importFrom purrr map_lgl
#'@export


get_locations <- function(query            = NULL,
                          lat              = NULL,
                          lon              = NULL,
                          max            = NULL,
                          api_key          = Sys.getenv("ZOMATO_API_KEY")){

  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(query, lat, lon, max), is.null))){
    stop(paste("Please provide at least query"))
  }

  query_list <- list(query            = query,
                     lat              = lat,
                     lon              = lon,
                     count            = max
  )

  data <- get_data(api_key = api_key,
                   path = "locations",
                   query = query_list)

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  tibble::as_tibble(data[["parsed"]][["location_suggestions"]]) %>%
    janitor::clean_names()

}

