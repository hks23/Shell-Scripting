#!/bin/bash

# Function to fetch weather data
fetch_weather() {
    local city=$1
    source .env
    local api_key="${WEATHER_API_KEY}"
    local response=$(curl -s "http://api.weatherapi.com/v1/current.json?key=$api_key&q=$city")

    if [[ $(echo "$response" | jq -r '.error') != null ]]; then
        echo "Error: Unable to fetch data for city: $city"
        return
    fi

    local date=$(date +"%m/%d/%Y")
    local time=$(date +"%H:%M:%S")
    local weather=$(echo "$response" | jq -r '.current.condition.text')
    local temp=$(echo "$response" | jq -r '.current.temp_c')
    local humidity=$(echo "$response" | jq -r '.current.humidity')
    local wind_speed=$(echo "$response" | jq -r '.current.wind_kph')
    local air_quality=$((RANDOM % 10 + 1)) # Simulated air quality rating

    echo "City: $city"
    echo "Date: $date"
    echo "Time: $time"
    echo "Weather: $weather"
    echo "Temperature: $temp°C"
    echo "Humidity: $humidity%"
    echo "Wind Speed: $wind_speed kph"
    echo "Air Quality: $air_quality/10"
}

# Main script
clear
echo "==== Weather Fetcher ===="
while true; do
    read -p "Enter the city name (or type 'exit' to quit): " city
    if [[ $city == "exit" ]]; then
        echo "Exiting..."
        break
    fi

    if [[ -z $city ]]; then
        echo "Error: City name cannot be empty."
        continue
    fi

    echo "\nFetching weather data for $city...\n"
    fetch_weather "$city"
    echo "\n--------------------------------------------\n"
done
