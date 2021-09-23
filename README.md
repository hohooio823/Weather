# Weather

A weather app built using flutter. You can download the app from a workflow on the github actions tab.
## Dependencies:
- [Location](https://pub.dev/packages/location) and [Geocoding](https://pub.dev/packages/geocoding) packages used for getting home city automatically .
- [Roadgoat](https://www.roadgoat.com/) api for autocompletion on searching cities.
- [Weatherbit](https://www.weatherbit.io/) api for fetching weather data.
## Features:
### On home screen:
- You can set your home city either automatically using location api, or you can set it manually by searching for it .
- The app uses shared preferences so you don't have to set your city manually every time if you don't chose to allow the location api .
- You can change home city manually by tapping on the weather screen of the city.
### On worldwide screen:
- You can add cities by clicking the "+" button .
- A tap on the weather card moves to you a single city screen.
- A long press deletes the city from the list.
### On search screen:
- You have autocompletion for searching cities.
