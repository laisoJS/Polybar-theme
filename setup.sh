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
if git clone https://github.com/laisoJS/Polybar-theme.git -b themes "$_polybar"; then
    echo "Setup completed successfully!"
else
    echo "An unexpected error occurred."
fi

# Define the script folder
_script="${HOME}/.scripts"

# Check if any of the standard script directories exist, otherwise, prompt to create one
if [[ -d "${HOME}/.script" ]]; then
    _script="${HOME}/.script"
elif [[ -d "${HOME}/.scripts" ]]; then
    _script="${HOME}/.scripts"
elif [[ -d "${HOME}/.autorun" ]]; then
    _script="${HOME}/.autorun"
else
    read -p "Script folder for autorun doesn't exist. Do you want to create it? (y/n): " yn
    case $yn in
        [Yy]* ) 
            mkdir "$_script" ;
            echo "Script folder for autorun created" ;

            # Create the autorun script in the $_script folder
            echo "Creating an autorun file..."
            
            echo "#!/bin/bash" > "${_script}/polybar-autorun.sh"
            echo "polybar --config=${_config}/polybar/config.ini main 2>&1 | tee -a /tmp/polybar.log & disown" >> "${_script}/polybar-autorun.sh"
            chmod +x "${_script}/autorun.sh" 

            echo "Polybar autorun script successfuly created as $_script/polybar-autorun.sh"
            ;;
        [Nn]* ) 
            echo "Setup aborted."; 
            exit;;
        * ) 
            echo "Invalid input. Setup aborted.";
            exit;;
    esac
fi
