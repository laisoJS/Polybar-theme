#!/bin/bash

# Define the path to the config folder
_config="${HOME}/.config"
_polybar="${HOME}/.config/polybar"

# Check if Polybar config folder already exists
if [ -d "$_polybar" ]; then
    read -p "Polybar config folder already exists. Do you want to overwrite it? (y/n): " yn
    case $yn in
        [Yy]* ) 
            rm -rf "$_polybar" ;;
        [Nn]* ) 
            echo "Setup aborted."; 
            exit;;
        * ) 
            echo "Invalid input. Setup aborted.";
            exit;;
    esac
fi

# Clone the repository into the Polybar config folder
if git clone https://github.com/laisoJS/Polybar-theme.git "$_polybar"; then
    echo "Setup completed successfully!"
else
    echo "An unexpected error occurred."
fi