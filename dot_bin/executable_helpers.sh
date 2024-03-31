#!/bin/sh

## Author  : Rubin Bhandari (rubiin)
## Mail    : roobin.bhandari@gmail.com
## Github  : @rubiin
## Twitter : @RubinCodes


# Function to ask yes/no question with a default value
ask_yes_no_default() {
    local prompt="$1 (Y/n)"
    local default="${2:-}"

    read -p "$prompt: " -n 1 answer
    echo

    case "$answer" in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) return "${default:-0}";;
    esac
}

# Function to parse the .tool-versions file
parse_tools_version() {
    # Define the file path
    local file="$HOME/.tool-versions"

    # Check if the file exists
    if [ -f "$file" ]; then
        # Declare an associative array
        declare -A versions

        # Read each line of the file
        while IFS= read -r line; do
            # Extract tool and version
            local tool=$(echo "$line" | awk '{print $1}')
            local version=$(echo "$line" | awk '{print $2}')

            # Add tool and version to the associative array
            versions["$tool"]="$version"
        done < "$file"

        # Return the associative array
        echo "${versions[@]}"
    else
        echo "File $file not found."
        return 1
    fi
}
