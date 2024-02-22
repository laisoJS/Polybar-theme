#!/bin/bash

# Define the required packages
required_packages=("polybar" "playerctl" "pavucontrol")

# Function to check if a package is installed
is_package_installed() {
    local package="$1"
    if pacman -Qs "$package" >/dev/null; then
        return 0  # Package is installed
    else
        return 1  # Package is not installed
    fi
}

# Check if required packages are installed
missing_packages=()
for package in "${required_packages[@]}"; do
    if ! is_package_installed "$package"; then
        missing_packages+=("$package")
    fi
done

# If any packages are missing, prompt to install them
if [ ${#missing_packages[@]} -gt 0 ]; then
    echo "The following packages are required but not installed:"
    for package in "${missing_packages[@]}"; do
        echo "- $package"
    done
    read -p "Do you want to install them? (y/n): " yn
    case $yn in
        [Yy]* )
            sudo pacman -S "${missing_packages[@]}" ;;
        * )
            echo "Setup aborted."
            exit ;;
    esac
fi

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

# Define the script directories
script_directories=(
    "${HOME}/.script"
    "${HOME}/.scripts"
    "${HOME}/.autorun"
)

for dir in "${script_directories[@]}"; do
    if [ -d "$dir" ]; then
        _script="$dir"
        break
    fi
done

# If no script directory is found, prompt to create one
if [ -z "$_script" ]; then
    echo "No script directory found. Do you want to create one?"
    read -r -p "(Y/N): " response
    if [[ "$response" =~ ^[Yy](es)?$ ]]; then
        mkdir -p "${HOME}/.scripts"
        _script="${HOME}/.scripts"
        echo "Script directory created at $_script"
    else
        echo "No script directory created. Exiting."
        exit 1
    fi
fi

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