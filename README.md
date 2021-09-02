# CKS Weather
A sample application to show weather details

## Getting Started
This project is a weather application with a basic UI and detailed backend.

### What they wanted ? 
1. [x] A simple weather app to show the weather of different districts [ DONE ]
2. [x] Load data from any weather api(open source) [ DONE ]
3. [x] Load data from api only for the first time and store the api response in the cache [ DONE ]
4. [] Every 10 mins call the same api, get the response. Check if the response is the same as in the cache
5. [x] If the responses are not the same, load the new data or else load from cache [ DONE ]
6. [x] Have a button on a screen and track the number of clicks on that session and show the realtime count on header or footer. [ DONE ] 
7. [x] Use BloC pattern for session management. [ DONE ]
8. [x] Have a toggle for Dark and light themes. [ DONE ]

### Backend Plans Before Start
 - Using lint to keep code organized
 - DI (using GetIt) to manage Blocs and Configurations
 - Dio and Retrofit for Network related operations
    - Not going to handle network errors such as timeout, or 400 assume every api is solid.
 - Hive for Storage
    - At this time, No secure storage, will save api key in configuration file
 - Json Serializable for Json Parsing and to Generate Models
 - Bloc for state management
 - Catcher for Error Management 
    - At this time no reporting. Just catch and ignore.
 
### Frontend Plans Before Start
 - Handle Dark / Light Themes
 - Google Fonts for Fonts
 - UI Not going to be Responsive

### Testing Plans Before Start
 - Unit Tests
  - Not able to cover all backend stuff due to time limitations ( Have less than 14 hrs )
 - Widget Tests
 
### Backup alternate options
 - Flutter has dedicated weather library to access weather info easily
   - such as https://pub.dev/packages/weather

### API and Responses ?

    Url : http://api.weatherapi.com/v1
    Key : 1dcd6a6d575d46f5aba92452210209

#### Weather API and Model Response
Request Url - GET
```
http://api.weatherapi.com/v1/current.json?key=1dcd6a6d575d46f5aba92452210209&q=koyamuttur-tamil-nadu-india&aqi=no
```
Response
```
{
    "location": {
        "name": "Koyamuttur",
        "region": "Tamil Nadu",
        "country": "India",
        "lat": 10.99,
        "lon": 76.96,
        "tz_id": "Asia/Kolkata",
        "localtime_epoch": 1630593760,
        "localtime": "2021-09-02 20:12"
    },
    "current": {
        "last_updated_epoch": 1630593000,
        "last_updated": "2021-09-02 20:00",
        "temp_c": 25.0,
        "is_day": 0,
        "condition": {
            "text": "Light rain",
            "icon": "//cdn.weatherapi.com/weather/64x64/night/296.png"
        },
        "wind_kph": 13.0,
        "wind_degree": 240,
        "wind_dir": "WSW",
        "humidity": 83,
        "feelslike_c": 26.9,
        "uv": 6.0
    }
}
```
---------------------------------------------------



