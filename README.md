
<!-- README.md is generated from README.Rmd. Please edit that file -->

# zomator

<!-- badges: start -->

<!-- badges: end -->

Zomator serves as a wraper function for the Zomato API. Zomator serves
as a wraper function for the Zomato API. The functionality of this
package is quite consistent with that of the [Zomato API
documentation](https://developers.zomato.com/documentation?lang=id#/).
The function format is `get_ <endpoint>`. The resulting overall output
is tibble by considering the principle of [data
tidy](https://vita.had.co.nz/papers/tidy-data.pdf).

## Installation

You can install the released version of zomator from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("zomator")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("technaut-education/zomator")
```

## Get API Keys

To create an API key, you can visit the [Zomato API
website](https://developers.zomato.com/api?lang=id#headline2). The
registration process is quite easy, we only need to register the email
we have and confirm via the link sent by Zomato to our email.

In general, we can make requests as many as 1000 times per day.

## Authentication

To perform authentication, we need to copy the api key we have obtained
into our R environment. The trick is to run the following command:

``` r
library(zomator)
```

``` r
set_api_key(path = "./.Renviron")
```

In this function, we add a path where we will store our API key. Based
on the command executed, we save the file `.Renviron` to the R working
directory. Paste the api key in the window that appears.

## Get list of Categories

Get a list of categories can be obtain using `get_categories` function.
List of all restaurants categorized under a particular restaurant type
can be obtained using `get_search` function with `categories_id` as
inputs.

``` r
get_categories()
#> # A tibble: 13 x 2
#>    categories_id categories_name         
#>            <int> <chr>                   
#>  1             1 Delivery                
#>  2             2 Dine-out                
#>  3             3 Nightlife               
#>  4             4 Catching-up             
#>  5             5 Takeaway                
#>  6             6 Cafes                   
#>  7             7 Daily Menus             
#>  8             8 Breakfast               
#>  9             9 Lunch                   
#> 10            10 Dinner                  
#> 11            11 Pubs & Bars             
#> 12            13 Pocket Friendly Delivery
#> 13            14 Clubs & Lounges
```

## Get city details

Find the Zomato ID and other details for a city . You can obtain the
Zomato City ID in one of the following ways:

  - City Name in the Search Query (`q`) - Returns list of cities
    matching the query
  - Using coordinates (`lat` and `lon`) - Identifies the city details
    based on the coordinates of any location inside a city

If you already know the Zomato City ID, this API can be used to get
other details of the city.

``` r
get_cities(q = "Jakarta")
#> # A tibble: 1 x 13
#>      id name  country_id country_name country_flag_url should_experime~
#>   <int> <chr>      <int> <chr>        <chr>                       <int>
#> 1    74 Jaka~         94 Indonesia    https://b.zmtcd~                0
#> # ... with 7 more variables: has_go_out_tab <int>, discovery_enabled <int>,
#> #   has_new_ad_format <int>, is_state <int>, state_id <int>, state_name <chr>,
#> #   state_code <chr>
```

``` r
# get New York City details using city_ids
get_cities(city_ids = 280)
#> # A tibble: 1 x 13
#>      id name  country_id country_name country_flag_url should_experime~
#>   <int> <chr>      <int> <chr>        <chr>                       <int>
#> 1   280 New ~        216 United Stat~ https://b.zmtcd~                0
#> # ... with 7 more variables: has_go_out_tab <int>, discovery_enabled <int>,
#> #   has_new_ad_format <int>, is_state <int>, state_id <int>, state_name <chr>,
#> #   state_code <chr>
```

## Get Zomato collections in a city

`get_collections` function can be used to obtain Zomato Restaurant
Collections in a City. The location/City input can be provided in the
following ways -

  - Using Zomato City ID
  - Using coordinates of any location within a city

List of all restaurants listed in any particular Zomato Collection can
be obtained using the `get_search` function with Collection ID and
Zomato City ID as the input.

``` r
get_collections(city_id = 74)
#> # A tibble: 36 x 7
#>    collection_coll~ collection_res_~ collection_imag~ collection_url
#>               <int>            <int> <chr>            <chr>         
#>  1                1               30 https://b.zmtcd~ https://www.z~
#>  2           306459               60 https://b.zmtcd~ https://www.z~
#>  3           306729               26 https://b.zmtcd~ https://www.z~
#>  4           274852              240 https://b.zmtcd~ https://www.z~
#>  5           306749               31 https://b.zmtcd~ https://www.z~
#>  6               71               89 https://b.zmtcd~ https://www.z~
#>  7           306754               23 https://b.zmtcd~ https://www.z~
#>  8               22               64 https://b.zmtcd~ https://www.z~
#>  9              537               76 https://b.zmtcd~ https://www.z~
#> 10               92               19 https://b.zmtcd~ https://www.z~
#> # ... with 26 more rows, and 3 more variables: collection_title <chr>,
#> #   collection_description <chr>, collection_share_url <chr>
```

## Get list of all cuisines in a city

`get_cuisines` function can be used to obtain all cuisines of
restaurants listed in a city. The location/city input can be provided in
the following ways -

  - Using Zomato City ID
  - Using coordinates of any location within a city

List of all restaurants serving a particular cuisine can be obtained
using `get_search` function with cuisine ID and location details.

``` r
get_cuisines(city_id = 280)
```

## Get list of restaurant types in a city

`get_establishments` function can be used to get a list of restaurant
types in a city. The location/City input can be provided in the
following ways -

  - Using Zomato City ID
  - Using coordinates of any location within a city

List of all restaurants categorized under a particular restaurant type
can obtained using `get_search` function with Establishment ID and
location details as inputs.

``` r
get_establishments(city_id = 280)
```

## Get location details based on coordinates

Get Foodie and Nightlife Index, list of popular cuisines and nearby
restaurants around the given coordinates.

``` r
get_geocode(lat = 40.742051, lon = -74.004821)
```

## Get Zomato location details

Get Foodie Index, Nightlife Index, Top Cuisines and Best rated
restaurants in a given location.

``` r
get_location_details(entity_id = 36932, entity_type = "group")
```

## Search for locations

Search for Zomato locations by keyword. Provide coordinates to get
better search results.

``` r
get_locations(query = "Jakarta")
```

## Get daily menu of a restaurant

``` r

get_dailymenu(res_id = 16782899)
```

## Get restaurant details

Get detailed restaurant information using Zomato restaurant ID. Partner
Access is required to access photos and reviews.

``` r
get_restaurant(res_id = 16782899)
#> # A tibble: 1 x 39
#>   res_id is_grocery_store has_menu_status res_name res_url location
#>    <int> <lgl>            <list>          <chr>    <chr>   <list>  
#> 1 1.68e7 FALSE            <named list [2~ Ninth S~ https:~ <named ~
#> # ... with 33 more variables: switch_to_order_menu <int>, cuisines <chr>,
#> #   timings <chr>, average_cost_for_two <int>, price_range <int>,
#> #   currency <chr>, highlights <list>, offers <list>, opentable_support <int>,
#> #   is_zomato_book_res <int>, mezzo_provider <chr>,
#> #   is_book_from_web_view <int>, book_from_web_view_url <chr>,
#> #   book_again_url <chr>, thumb <chr>, user_rating <list>,
#> #   all_reviews_count <int>, photos_url <chr>, photo_count <int>,
#> #   menu_url <chr>, fetured_image <chr>, medio_provider <lgl>,
#> #   has_online_delivery <int>, is_delivering_now <int>, store_type <chr>,
#> #   include_bogo_offers <lgl>, deeplink <chr>,
#> #   is_table_reservation_supported <int>, has_table_booking <int>,
#> #   events_url <chr>, phone_numbers <chr>, all_reviews <list>,
#> #   establishment <chr>
```

## Get restaurant reviews

Get restaurant reviews using the Zomato restaurant ID. Only 5 latest
reviews are available under the Basic API plan.

``` r
get_reviews(res_id = 16782899)
#> # A tibble: 5 x 17
#>   review_rating review_text review_id review_rating_c~ review_time_fri~
#>           <int> <chr>           <int> <chr>            <date>          
#> 1             5 This organ~  46581715 305D02           2019-12-07      
#> 2             4 A favorite~  27365984 5BA829           2016-06-14      
#> 3             4 Very good ~  25752263 5BA829           2015-12-15      
#> 4             5 The best l~  24127336 305D02           2015-06-28      
#> 5             3 A misshape~  24081874 CDD614           2015-06-24      
#> # ... with 12 more variables: review_rating_text <chr>,
#> #   review_timestamp <dttm>, review_likes <int>, review_comments_count <int>,
#> #   review_user_name <chr>, review_user_zomato_handle <chr>,
#> #   review_user_foodie_level <chr>, review_user_foodie_level_num <int>,
#> #   review_user_foodie_color <chr>, review_user_profile_url <chr>,
#> #   review_user_profile_image <chr>, review_user_profile_deeplink <chr>
```

## Search for restaurants

The location input can be specified using Zomato location ID or
coordinates. Cuisine / Establishment / Collection IDs can be obtained
from respective api calls. Get up to 100 restaurants for free API.
Partner Access is required to access photos and reviews.

Examples:

  - To search for ‘Italian’ restaurants in ‘Manhattan, New York City’,
    set cuisines = 55, entity\_id = 94741 and entity\_type = zone

<!-- end list -->

``` r
get_search(cuisines = 55, entity_id = 94741, entity_type = "zone")
#> # A tibble: 17 x 56
#>    restaurant_id restaurant_name restaurant_url restaurant_swit~
#>    <chr>         <chr>           <chr>                     <int>
#>  1 16793301      Marta           https://www.z~                0
#>  2 16788789      Giovanni Rana ~ https://www.z~                0
#>  3 16781429      Buon Italia     https://www.z~                0
#>  4 16793056      Corkbuzz Wine ~ https://www.z~                0
#>  5 18087224      Big Mozz        https://www.z~                0
#>  6 18758226      PN Wood Fired ~ https://www.z~                0
#>  7 18945669      PQR             https://www.z~                0
#>  8 18820308      La Pecora Bian~ https://www.z~                0
#>  9 19022421      Starbucks Rese~ https://www.z~                0
#> 10 18815747      Patavini        https://www.z~                0
#> 11 18932260      Spaghetti Inci~ https://www.z~                0
#> 12 18989382      Il Mulino Prime https://www.z~                0
#> 13 19067929      Resca           https://www.z~                0
#> 14 18999860      Tarallucci e V~ https://www.z~                0
#> 15 18814421      &pizza          https://www.z~                0
#> 16 18929058      Leonelli Focac~ https://www.z~                0
#> 17 18946990      Scampi          https://www.z~                0
#> # ... with 52 more variables: restaurant_cuisines <chr>,
#> #   restaurant_timings <chr>, restaurant_average_cost_for_two <int>,
#> #   restaurant_price_range <int>, restaurant_currency <chr>,
#> #   restaurant_highlights <list>, restaurant_offers <list>,
#> #   restaurant_opentable_support <int>, restaurant_is_zomato_book_res <int>,
#> #   restaurant_mezzo_provider <chr>, restaurant_is_book_form_web_view <int>,
#> #   restaurant_book_form_web_view_url <chr>, restaurant_book_again_url <chr>,
#> #   restaurant_thumb <chr>, restaurant_all_reviews_count <int>,
#> #   restaurant_photos_url <chr>, restaurant_photo_count <int>,
#> #   restaurant_menu_url <chr>, restaurant_featured_image <chr>,
#> #   restaurant_medio_provider <lgl>, restaurant_has_online_delivery <int>,
#> #   restaurant_is_delivering_now <int>, restaurant_store_type <chr>,
#> #   restaurant_include_bogo_offers <lgl>, restaurant_deeplink <chr>,
#> #   restaurant_is_table_reservation_supported <int>,
#> #   restaurant_has_table_booking <int>, restaurant_events_url <chr>,
#> #   restaurant_phone_numbers <chr>, restaurant_establishment <list>,
#> #   restaurant_establishment_types <list>, restaurant_r_res_id <int>,
#> #   restaurant_r_is_grocery_store <lgl>,
#> #   restaurant_r_has_menu_status_delivery <int>,
#> #   restaurant_r_has_menu_status_takeaway <int>,
#> #   restaurant_location_address <chr>, restaurant_location_locality <chr>,
#> #   restaurant_location_city <chr>, restaurant_location_city_id <int>,
#> #   restaurant_location_latitude <chr>, restaurant_location_longitude <chr>,
#> #   restaurant_location_zipcode <chr>, restaurant_location_country_id <int>,
#> #   restaurant_location_locality_verbose <chr>,
#> #   restaurant_user_rating_aggregate_rating <chr>,
#> #   restaurant_user_rating_rating_text <chr>,
#> #   restaurant_user_rating_rating_color <chr>,
#> #   restaurant_user_rating_votes <int>,
#> #   restaurant_user_rating_rating_obj_title_text <chr>,
#> #   restaurant_user_rating_rating_obj_bg_color_type <chr>,
#> #   restaurant_user_rating_rating_obj_bg_color_tint <chr>,
#> #   restaurant_all_reviews_reviews <list>
```

  - To search for ‘cafes’ in ‘Manhattan, New York City’, set
    establishment\_type = 1, entity\_type = zone and entity\_id = 94741

<!-- end list -->

``` r
get_search(establishment_type = 1, entity_type = "zone", entity_id = 94741)
#> # A tibble: 11 x 57
#>    restaurant_id restaurant_name restaurant_url restaurant_swit~
#>    <chr>         <chr>           <chr>                     <int>
#>  1 16782899      Ninth Street E~ https://www.z~                0
#>  2 16777127      Sarabeth's Bak~ https://www.z~                0
#>  3 16785143      Bar Suzette     https://www.z~                0
#>  4 19022421      Starbucks Rese~ https://www.z~                0
#>  5 18111669      LOX at Cafe     https://www.z~                0
#>  6 18482455      Gasoline Alley~ https://www.z~                0
#>  7 18990479      Bluestone Lane  https://www.z~                0
#>  8 18982832      Pret A Manger   https://www.z~                0
#>  9 18988192      Kung Fu Tea     https://www.z~                0
#> 10 19000457      Mellow Yellow ~ https://www.z~                0
#> 11 19000012      Juicology       https://www.z~                0
#> # ... with 53 more variables: restaurant_cuisines <chr>,
#> #   restaurant_timings <chr>, restaurant_average_cost_for_two <int>,
#> #   restaurant_price_range <int>, restaurant_currency <chr>,
#> #   restaurant_highlights <list>, restaurant_offers <list>,
#> #   restaurant_opentable_support <int>, restaurant_is_zomato_book_res <int>,
#> #   restaurant_mezzo_provider <chr>, restaurant_is_book_form_web_view <int>,
#> #   restaurant_book_form_web_view_url <chr>, restaurant_book_again_url <chr>,
#> #   restaurant_thumb <chr>, restaurant_all_reviews_count <int>,
#> #   restaurant_photos_url <chr>, restaurant_photo_count <int>,
#> #   restaurant_menu_url <chr>, restaurant_featured_image <chr>,
#> #   restaurant_medio_provider <lgl>, restaurant_has_online_delivery <int>,
#> #   restaurant_is_delivering_now <int>, restaurant_store_type <chr>,
#> #   restaurant_include_bogo_offers <lgl>, restaurant_deeplink <chr>,
#> #   restaurant_is_table_reservation_supported <int>,
#> #   restaurant_has_table_booking <int>, restaurant_events_url <chr>,
#> #   restaurant_phone_numbers <chr>, restaurant_establishment <list>,
#> #   restaurant_r_res_id <int>, restaurant_r_is_grocery_store <lgl>,
#> #   restaurant_r_has_menu_status_delivery <int>,
#> #   restaurant_r_has_menu_status_takeaway <int>,
#> #   restaurant_location_address <chr>, restaurant_location_locality <chr>,
#> #   restaurant_location_city <chr>, restaurant_location_city_id <int>,
#> #   restaurant_location_latitude <chr>, restaurant_location_longitude <chr>,
#> #   restaurant_location_zipcode <chr>, restaurant_location_country_id <int>,
#> #   restaurant_location_locality_verbose <chr>,
#> #   restaurant_user_rating_aggregate_rating <chr>,
#> #   restaurant_user_rating_rating_text <chr>,
#> #   restaurant_user_rating_rating_color <chr>,
#> #   restaurant_user_rating_votes <int>,
#> #   restaurant_user_rating_rating_obj_title_text <chr>,
#> #   restaurant_user_rating_rating_obj_bg_color_type <chr>,
#> #   restaurant_user_rating_rating_obj_bg_color_tint <chr>,
#> #   restaurant_all_reviews_reviews <list>,
#> #   restaurant_establishment_types_establishment_type_id <chr>,
#> #   restaurant_establishment_types_establishment_type_name <chr>
```

  - Get list of all restaurants in ‘Trending this Week’ collection in
    ‘New York City’ by using entity\_id = 280, entity\_type = city and
    collection\_id = 1

<!-- end list -->

``` r
get_search(entity_id = 280, entity_type = "city", collection_id = 1)
```
