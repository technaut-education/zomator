#'@title Get daily menu of a restaurant
#'
#'@description Get daily menu using Zomato restaurant ID.
#'
#'@param res_id Integer. ID of restaurant whose details are requested
#'@param api_key String. Api key.
#'
#'
#'@return A tibble
#'
#'@examples
#'\dontrun{
#'get_dailymenu(res_id = 16782899, api_key = Sys.getenv("ZOMATO_API_KEY"))
#'}
#'@importFrom tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>%
#'@importFrom purrr map_lgl
#'@export
get_dailymenu <- function(res_id    = NULL,
                       api_key  = Sys.getenv("ZOMATO_API_KEY")){

  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(res_id), is.null))){
    stop(paste("Please provide res_id"))
  }

  query_list <- list(res_id    = res_id)

  data <- get_data(api_key = api_key,
                   path    = "dailymenu",
                   query   = query_list)

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  tibble::as_tibble(data[["parsed"]][["daily_menus"]]) %>%
    janitor::clean_names()

}

#'@title Get restaurant details
#'
#'@description Get detailed restaurant information using Zomato restaurant ID. Partner Access is required to access photos and reviews.
#'
#'@param res_id Integer. ID of restaurant whose details are requested
#'@param api_key String. Api key.
#'
#'
#'@return A tibble
#'
#'@examples
#'\dontrun{
#'get_restaurant(res_id = 16782899, api_key = Sys.getenv("ZOMATO_API_KEY"))
#'}
#'@importFrom tibble tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>% select rename
#'@importFrom purrr map_lgl
#'@importFrom tidyr nest
#'@export
get_dailymenu <- function(res_id    = NULL,
                          api_key  = Sys.getenv("ZOMATO_API_KEY")){

  res_id                = NULL
  is_grocery_store      = NULL
  has_menu_status       = NULL
  res_name              = NULL
  res_url               = NULL
  location              = NULL
  switch_to_order_menu  = NULL
  cuisines              = NULL
  timings               = NULL
  average_cost_for_two  = NULL
  price_range           = NULL
  currency              = NULL
  highlights            = NULL
  offers                = NULL
  opentable_support     = NULL
  is_zomato_book_res    = NULL
  mezzo_provider        = NULL
  is_book_from_web_view = NULL
  book_from_web_view_url= NULL
  book_again_url        = NULL
  thumb                 = NULL
  user_rating           = NULL
  all_reviews_count     = NULL
  photos_url            = NULL
  photo_count           = NULL
  menu_url              = NULL
  fetured_image         = NULL
  medio_provider        = NULL
  has_online_delivery   = NULL
  is_delivering_now     = NULL
  store_type            = NULL
  include_bogo_offers   = NULL
  deeplink              = NULL
  is_table_reservation_supported =NULL
  has_table_booking = NULL
  events_url = NULL
  phone_numbers = NULL
  all_reviews = NULL
  establishment = NULL


  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(res_id), is.null))){
    stop(paste("Please provide res_id"))
  }

  query_list <- list(res_id    = res_id)

  data <- get_data(api_key = api_key,
                   path    = "restaurant",
                   query   = query_list)

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  tibble::tibble(res_id = data$parsed$R$res_id,
                 is_grocery_store = data$parsed$R$is_grocery_store,
                 has_menu_status = list(data$parsed$R$has_menu_status),
                 res_name = data$parsed$name,
                 res_url = data$parsed$url,
                 location = list(data$parsed$location),
                 switch_to_order_menu = data$parsed$switch_to_order_menu,
                 cuisines = data$parsed$cuisines,
                 timings = data$parsed$timings,
                 average_cost_for_two = data$parsed$average_cost_for_two,
                 price_range = data$parsed$price_range,
                 currency = data$parsed$currency,
                 highlights = list(data$parsed$highlights),
                 offers = list(data$parsed$offers),
                 opentable_support = data$parsed$opentable_support,
                 is_zomato_book_res = data$parsed$is_zomato_book_res,
                 mezzo_provider = data$parsed$mezzo_provider,
                 is_book_from_web_view = data$parsed$is_book_form_web_view,
                 book_from_web_view_url = data$parsed$book_form_web_view_url,
                 book_again_url = data$parsed$book_again_url,
                 thumb = data$parsed$thumb,
                 user_rating = list(data$parsed$user_rating),
                 all_reviews_count = data$parsed$all_reviews_count,
                 photos_url = data$parsed$photos_url,
                 photo_count = data$parsed$photo_count,
                 menu_url = data$parsed$menu_url,
                 fetured_image = data$parsed$featured_image,
                 medio_provider = data$parsed$medio_provider,
                 has_online_delivery = data$parsed$has_online_delivery,
                 is_delivering_now = data$parsed$is_delivering_now,
                 store_type = data$parsed$store_type,
                 include_bogo_offers = data$parsed$include_bogo_offers,
                 deeplink = data$parsed$deeplink,
                 is_table_reservation_supported = data$parsed$is_table_reservation_supported,
                 has_table_booking = data$parsed$has_table_booking,
                 events_url = data$parsed$events_url,
                 phone_numbers = data$parsed$phone_numbers,
                 all_reviews = list(data$parsed$all_reviews),
                 establishment = data$parsed$establishment)

}

#'@title Get restaurant reviews
#'
#'@description Get restaurant reviews using the Zomato restaurant ID. Only 5 latest reviews are available under the Basic API plan.
#'
#'@param res_id Integer. ID of restaurant whose details are requested
#'@param start Integer. Fetch results after this offset
#'@param max Integer. Max number of results to retrieve
#'@param api_key String. Api key.
#'
#'
#'@return A tibble
#'
#'@examples
#'\dontrun{
#'get_reviews(res_id = 16782899, api_key = Sys.getenv("ZOMATO_API_KEY"))
#'}
#'@importFrom tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>% select rename mutate
#'@importFrom purrr map_lgl pluck
#'@importFrom lubridate mdy
#'@export
get_reviews <- function(res_id    = NULL,
                        start     = NULL,
                        max       = NULL,
                        api_key   = Sys.getenv("ZOMATO_API_KEY")){

  review_text <- review_review_text <- NULL
  review_time_friendly <- review_review_time_friendly <- NULL
  review_timestamp <- NULL

  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(res_id, start, max), is.null))){
    stop(paste("Please provide at least res_id"))
  }

  query_list <- list(res_id    = res_id,
                     start     = start,
                     count     = max)

  data <- get_data(api_key = api_key,
                   path    = "reviews",
                   query   = query_list)

  handle_error(data[["resp"]], data[["parsed"]]["message"])

  tibble::as_tibble(data$parsed) %>%
    purrr::pluck("user_reviews") %>%
    tibble::as_tibble() %>%
    janitor::clean_names() %>%
    rename(review_text = review_review_text,
           review_time_friendly = review_review_time_friendly) %>%
    mutate(review_timestamp = as.POSIXct(review_timestamp, origin = "1970-01-01"),
           review_time_friendly = lubridate::mdy(review_time_friendly))

}



#'@title Search for restaurants
#'
#'@description The location input can be specified using Zomato location ID or coordinates.
#'
#'@param entity_id Integer. Location id.
#'@param entity_type String. Location type. Possibel values: "city", "subzone", "landmark", "metro", or "group".
#'@param q String. Search keyword.
#'@param lat Double. Latitude.
#'@param lon Double. Longitude.
#'@param radius Double. Radius around (lat,lon); to define search area, defined in meters(M)
#'@param cuisines String. List of cuisine id's separated by comma.
#'@param establishment_type String. Establishment id obtained from \code{get_establishments}.
#'@param collection_id String. Collection id obtained from \code{get_collections}.
#'@param category String. Category ids obtained from \code{get_categories}.
#'@param sort String. sort restaurants by ... Possible values: "cost", "rating", or "real_distance".
#'@param order String. Used with 'sort' parameter to define ascending / descending. Possibel values: "asc", or "desc".
#'@param is_free Logical. If using free API set the value to TRUE
#'@param api_key String. Api key.
#'
#'@note Cuisine / Establishment / Collection IDs can be obtained from respective api calls. Get up to 100 restaurants by changing the 'start' and 'count' parameters with the maximum value of count being 20. Partner Access is required to access photos and reviews.
#'
#'@return A tibble
#'
#'@examples
#'\dontrun{
#'# search for 'Italian' restaurants in 'Manhattan, New York City'
#'get_search(cuisines = 55,
#'           entity_id = 94741,
#'           entity_type = "zone",
#'           api_key = Sys.getenv("ZOMATO_API_KEY"))
#'
#'
#'
#`# Get list of all restaurants in 'Trending this Week' collection in 'New York City'
#`get_search(entity_id = 280.
#'           entity_type = "city",
#'           collection_id = 1)
#'}
#'@importFrom tibble as_tibble
#'@importFrom janitor clean_names
#'@importFrom dplyr %>% select bind_rows
#'@importFrom purrr map_lgl map
#'@export
get_search <- function(q = NULL,
                       entity_id = NULL,
                       entity_type = NULL,
                       lat = NULL,
                       lon = NULL,
                       radius = NULL,
                       cuisines = NULL,
                       establishment_type = NULL,
                       collection_id = NULL,
                       category = NULL,
                       sort = NULL,
                       order = NULL,
                       is_free = TRUE,
                       api_key   = Sys.getenv("ZOMATO_API_KEY")){

  restaurant.apikey <- NULL


  ## if any arguments NULL ----
  if(all(purrr::map_lgl(list(q, entity_id, entity_type, lat, lon, radius, cuisines, establishment_type, collection_id, category,sort,order), is.null))){
    stop(paste("Please provide at least q"))
  }

  query_list <- list(q = q,
                     entity_id = entity_id,
                     entity_type = entity_type,
                     start = 0,
                     count = 20,
                     lat = lat,
                     lon = lon,
                     radius = radius,
                     cuisines = cuisines,
                     establishment_type = establishment_type,
                     category = category,
                     collection_id = collection_id,
                     sort = sort,
                     order = order
  )

  data <- get_data(api_key = api_key,
                   path = "search",
                   query = query_list)

  handle_error(data$resp, data$parsed$message)

  df1 <- tibble::as_tibble(data[["parsed"]][["restaurants"]]) %>%
    select(-restaurant.apikey) %>%
    janitor::clean_names()



  result_found <- data$parsed$results_found
  result_shown <- data$parsed$results_shown

  if(is_free){

    if(result_found > 20){

      data2 <- purrr::map(seq(result_shown, 80, by = 20), function(x){

        query_list2 <- list(q = q,
                           entity_id = entity_id,
                           entity_type = entity_type,
                           start = x,
                           count = 20,
                           lat = lat,
                           lon = lon,
                           radius = radius,
                           cuisines = cuisines,
                           establishment_type = establishment_type,
                           category = category,
                           collection_id = collection_id,
                           sort = sort,
                           order = order)
        temp <- get_data(api_key = api_key,
                         path = "search",
                         query = query_list2)

        handle_error(temp$resp, temp$parsed$message)

        tibble::as_tibble(temp[["parsed"]][["restaurants"]]) %>%
          select(-restaurant.apikey) %>%
          janitor::clean_names()

      })

      df2 <- do.call(dplyr::bind_rows, data2)

    }


  }else{

    if(result_found > 20){

      data2 <- purrr::map(seq(result_shown, result_found, by = 20), function(x){

        query_list2 <- list(q = q,
                            entity_id = entity_id,
                            entity_type = entity_type,
                            start = x,
                            count = 20,
                            lat = lat,
                            lon = lon,
                            radius = radius,
                            cuisines = cuisines,
                            establishment_type = establishment_type,
                            category = category,
                            collection_id = collection_id,
                            sort = sort,
                            order = order)
        temp <- get_data(api_key = api_key,
                         path = "search",
                         query = query_list2)

        handle_error(temp$resp, temp$parsed$message)

        tibble::as_tibble(temp[["parsed"]][["restaurants"]]) %>%
          select(-restaurant.apikey) %>%
          janitor::clean_names()

      })

      df2 <- do.call(dplyr::bind_rows, data2)

    }

  }

  final_df <- dplyr::bind_rows(df1, df2)


}




