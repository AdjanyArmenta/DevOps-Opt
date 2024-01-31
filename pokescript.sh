#!/bin/bash

# -lt less than
# -ne not equal
if [ $# -ne 1 ]; then
    echo "Proporciona el nombre de un pokemon"
    exit 1
fi

pokemon=$1
pokemon=$(echo "$pokemon" | tr '[:upper:]' '[:lower:]')

pokemon_api_response=$(curl "https://pokeapi.co/api/v2/pokemon/$pokemon")

if [[ "$pokemon_api_response" == *"Not Found"* ]];
then
  echo "No se encontró información acerca de ese pokemon"
  exit 1
fi

name=$(echo "$pokemon_api_response" | jq -r ".name")
name="$(tr '[:lower:]' '[:upper:]' <<< ${name:0:1})${name:1}"
id=$(echo "$pokemon_api_response" | jq -r ".id")
weight=$(echo "$pokemon_api_response" | jq -r ".weight")
height=$(echo "$pokemon_api_response" | jq -r ".height")

echo "$name (No. $id)
Id = $id
Weight = $weight
Height = $height "


