#!/bin/bash

# Function to generate passwords
generate_passwords() {
    local length=$1
    local count=$2
    local mode=$3

    case $mode in
        1)
            chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
            ;;
        2)
            chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
            ;;
        3)
            chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>?'
            ;;
        *)
            echo "Invalid option."
            exit 1
            ;;
    esac

    for ((i = 1; i <= count; i++)); do
        password=""
        for ((j = 1; j <= length; j++)); do
            rand_char=${chars:RANDOM%${#chars}:1}
            password+=$rand_char
        done
        echo "Password $i: $password"
    done
}

# Main script
clear
echo "==== Password Generator ===="
while true; do
    read -p "Enter the desired password length (or 0 to exit): " length
    if [[ $length == 0 ]]; then
        echo "Exiting..."
        break
    fi
    if ! [[ $length =~ ^[0-9]+$ ]]; then
        echo "Error: Please enter a valid number for length."
        continue
    fi

    read -p "Enter the number of passwords to generate: " count
    if ! [[ $count =~ ^[0-9]+$ ]]; then
        echo "Error: Please enter a valid number for count."
        continue
    fi

    echo "Choose the type of passwords:"
    echo "1. Alphabets only"
    echo "2. Alphabets and Numbers"
    echo "3. Alphabets, Numbers, and Special Characters"
    read -p "Enter your choice (1/2/3): " choice

    if ! [[ $choice =~ ^[1-3]$ ]]; then
        echo "Error: Please select a valid option (1, 2, or 3)."
        continue
    fi

    echo "\nGenerating passwords...\n"
    generate_passwords $length $count $choice
    echo "\nPasswords generated successfully!"
done
