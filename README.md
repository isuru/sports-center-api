# Sports Center API
## Overview
API to manage a sports centre with tennis, basketball, football and volleyball courts, by customers to search for available courts and handle bookings. 
(This does not cover the authentication part)

**This API covers:**
* Search for available courts, filtering by date, type & hour (slot)
* Create new bookings
* Amend notes to existing bookings
* Cancel bookings

## Requirements:
* Ruby 2.7.2
* PostgreSQL
## Setup
```
git clone git@github.com:isuru/sports-center-api.git
bundle install

rails db:setup
rails db:seed
rails s

Server will run by default in: 
http://127.0.0.1:3000
```
## API Endpoints
### 1). Search for Available Courts
> *GET* `/api/v1/bookings/search`
#####  Params:
 * *type_id* - Integer
 * *booking_date* - date (yyyy-mm-dd)
 * *from* - Integer (0-23)
 * *to* - Integer (0-23)
##### Ex. Response:
#
```
{
    "staus": "ok",
    "results": {
        "booking_date": "2023-01-22",
        "from": "13",
        "to": "14",
        "type": "tennis",
        "slots_count": 4,
        "slots": [
            {
                "court_id": 1,
                "court_name": "T1",
                "hour": 13
            },
            {
                "court_id": 2,
                "court_name": "T2",
                "hour": 14
            },
            {
                "court_id": 3,
                "court_name": "T3",
                "hour": 13
            },
            {
                "court_id": 3,
                "court_name": "T3",
                "hour": 14
            }
        ]
    }
}
```
### 2). New Booking
>*POST* `/api/v1/bookings/new`
##### Params:
 * *customer_id* - Interger
 * *booking_date* - date (yyyy-mm-dd)
 * *court_id* - Integer
 * *hour* - Integer [0 to 23]
##### Ex. Response:
#
```
{
    "status": "ok",
    "message": "booking successful",
    "court": {
        "id": 6,
        "name": "F1",
        "hour": 21
    }
}
```
### 3). Update Booking
-- Amend notes to existing booking
>*PATCH* `/api/v1/bookings/:booking_id/update`
##### Params:
 * *booking_id* - Interger
 * *notes* - Text
### 4). Cancel Booking
-- Cancel an existing booking
>*PATCH* `/api/v1/bookings/:booking_id/cancel`
##### Params:
 * *booking_id* - Interger
 * *cancelled_reason* - String [Optional]
## Todo
-- Covering the test cases
