#'@title Get categories name and id
#'
#'@description A function to get a list of categories.
#'
#'@param api_key String. Api key.
#'
#'@return A tibble
#'
#'@examples
#'\dontrun{
#'get_categories()
#'}
#'@importFrom tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>%
#'@export

get_categories <- function(api_key = Sys.getenv("ZOMATO_API_KEY")){

  data <- get_data(api_key = api_key,
                   path = "categories")

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  tibble::as_tibble(data[["parsed"]]$categories) %>%
    janitor::clean_names()

}


#'@title Get city details
#'
#'@description Find the Zomato ID and other details for a city.
#'
#'@param q String. City name
#'@param lat Double. Latitude
#'@param lon Double. Longitude
#'@param city_ids Integer. City ID
#'@param max Integer. Number of max results to display
#'@param api_key String. Api key.
#'
#'@note You can obtain the Zomato City ID in one of the following ways: 1. City Name in the q (query) parameters - Returns list of cities matching the query, 2. Using coordinates (lat and lon) - Identifies the city details based on the coordinates of any location inside a city
#'
#'@return A tibble
#'
#'@examples
#'\dontrun{
#'get_cities(q = "new york", api_key = Sys.getenv("ZOMATO_API_KEY"))
#'}
#'@importFrom tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>%
#'@importFrom purrr map_lgl
#'@export
get_cities <- function(q        = NULL,
                       lat      = NULL,
                       lon      = NULL,
                       city_ids = NULL,
                       max    = NULL,
                       api_key  = Sys.getenv("ZOMATO_API_KEY")){

  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(q, lat, lon, city_ids, max), is.null))){
    stop(paste("Please provide at least q (city name) or city_ids"))
  }

  query_list <- list(q        = q,
                     lat      = lat,
                     lon      = lon,
                     city_ids = city_ids,
                     count    = max)

  data <- get_data(api_key = api_key,
                   path    = "cities",
                   query   = query_list)

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  tibble::as_tibble(data[["parsed"]][["location_suggestions"]]) %>%
    janitor::clean_names()

}

#'@title Get Zomato collections in a city
#'
#'@description Returns Zomato restaurant collections in a city.
#'
#'@param city_id Integer. City ID.
#'@param lat Double. Latitude.
#'@param lon Double. Longitude.
#'@param max Integer. Number of max results to display.
#'@param api_key String. Api key.
#'
#'@note The location/City input can be provided in the following ways - 1. Using Zomato City ID; 2. Using coordinates of any location within a city.
#'
#'@return A tibble
#'
#'@examples
#'\dontrun{
#'# find 20 restaurant collections in New York city
#'get_collections(city_id = 61, api_key = Sys.getenv("ZOMATO_API_KEY"), max = 20)
#'}
#'@importFrom tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>%
#'@importFrom purrr map_lgl
#'@export


get_collections <- function(city_id = NULL,
                            lat      = NULL,
                            lon      = NULL,
                            max    = NULL,
                            api_key  = Sys.getenv("ZOMATO_API_KEY")){

  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(lat, lon, city_id, max), is.null))){
    stop(paste("Please provide at least city_ids"))
  }

  query_list <- list(lat      = lat,
                     lon      = lon,
                     city_id  = city_id,
                     count    = max)

  data <- get_data(api_key = api_key,
                   path = "collections",
                   query = query_list)

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  tibble::as_tibble(data[["parsed"]][["collections"]]) %>%
    janitor::clean_names()

}


#'@title Get list of all cuisines in a city
#'
#'@description Get a list of all cuisines of restaurants listed in a city.
#'
#'@param city_id Integer. City ID
#'@param lat Double. Latitude
#'@param lon Double. Longitude
#'@param api_key String. Api key.
#'
#'@note The location/city input can be provided in the following ways - 1. Using Zomato City ID, 2. Using coordinates of any location within a city.
#'
#'@return A tibble
#'
#'@examples
#'\dontrun{
#'# get list of all cuisines in New York city
#'get_cuisines(city_id = 61, api_key = Sys.getenv("ZOMATO_API_KEY"))
#'}
#'@importFrom tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>%
#'@importFrom purrr map_lgl
#'@export


get_cuisines <- function(city_id  = NULL,
                            lat      = NULL,
                            lon      = NULL,
                            api_key  = Sys.getenv("ZOMATO_API_KEY")){

  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(lat, lon, city_id), is.null))){
    stop(paste("Please provide at least city_ids"))
  }

  query_list <- list(city_id  = city_id,
                lat      = lat,
                lon      = lon
  )

  data <- get_data(api_key = api_key,
                   path = "cuisines",
                   query = query_list)

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  tibble::as_tibble(data[["parsed"]][["cuisines"]]) %>%
    janitor::clean_names()

}


#'@title Get list of restaurant types in a city
#'
#'@description Get a list of restaurant types in a city.
#'
#'
#'
#'@param city_id Integer. City ID
#'@param lat Double. Latitude
#'@param lon Double. Longitude
#'@param api_key String. Api key.
#'
#'@note The location/City input can be provided in the following ways - 1. Using Zomato City ID, 2. Using coordinates of any location within a city.
#'
#'@return A tibble
#'
#'@examples
#'\dontrun{
#'# get list of restaurant types in New York city
#'get_establishments(city_id = 61, api_key = Sys.getenv("ZOMATO_API_KEY"))
#'}
#'@importFrom tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>%
#'@importFrom purrr map_lgl
#'@export


get_establishments <- function(city_id  = NULL,
                               lat      = NULL,
                               lon      = NULL,
                               api_key  = Sys.getenv("ZOMATO_API_KEY")){

  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(lat, lon, city_id), is.null))){
    stop(paste("Please provide at least city_ids"))
  }

  query_list <- list(city_id  = city_id,
                lat      = lat,
                lon      = lon
  )

  data <- get_data(api_key = api_key,
                   path = "establishments",
                   query = query_list)

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  tibble::as_tibble(data[["parsed"]][["establishments"]]) %>%
    janitor::clean_names()

}


#'@title Get location details based on coordinates
#'
#'@description Get Foodie and Nightlife Index, list of popular cuisines and nearby restaurants around the given coordinates.
#'
#'@param lat Double. Latitude
#'@param lon Double. Longitude
#'@param api_key String. Api key.
#'
#'@note The location/City input can be provided in the following ways - 1. Using Zomato City ID, 2. Using coordinates of any location within a city.
#'
#'@return A list contains 3 tibble
#'
#'@examples
#'\dontrun{
#'get_geocode(lat = 40.742051, lon = -74.004821,
#`            api_key = Sys.getenv("ZOMATO_API_KEY"))
#'}
#'@importFrom tibble as_tibble tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>% select
#'@importFrom purrr map_lgl
#'@export

get_geocode <- function(lat      = NULL,
                        lon      = NULL,
                        api_key  = Sys.getenv("ZOMATO_API_KEY")){

  restaurant.apikey <- NULL

  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(lat, lon), is.null))){
    stop(paste("Please provide lat and lon"))
  }

  query_list <- list(lat      = lat,
                lon      = lon
  )

  data <- get_data(api_key = api_key,
                   path = "geocode",
                   query = query_list)

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  location <- data[["parsed"]][["location"]] %>% as_tibble()
  popularity <- tibble(popularity = data$parsed$popularity$popularity,
                       nightlife_index = data$parsed$popularity$nightlife_index,
                       nearby_res = list(data$parsed$popularity$nearby_res),
                       top_cuisines = list(data$parsed$popularity$top_cuisines),
                       popularity_res = data$parsed$popularity$popularity_res,
                       nightlife_res = data$parsed$popularity$nightlife_res,
                       subzone_id = data$parsed$popularity$subzone_id,
                       city = data$parsed$popularity$city)

  nearby_restaurants <- data[["parsed"]][["nearby_restaurants"]] %>%
    select(-restaurant.apikey) %>%
    janitor::clean_names() %>%
    as_tibble()

  list(location = location,
       popularity = popularity,
       nearby_restaurants = nearby_restaurants)

}







