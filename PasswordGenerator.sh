#!/bin/bash
#Simple Password Generator

echo "This is a simple password generator"
echo "Enter the length of the password: "
read PASS_LENGTH


for i in $(seq 1):
do
    openssl rand -base64 48 | cut -c1-$PASS_LENGTH
done