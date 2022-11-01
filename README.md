# Intial Setup

    docker-compose build
    docker-compose up mariadb
    # Once mariadb says it's ready for connections, you can use ctrl + c to stop it
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc
   
# Short code algorithm

    To obtain the short code its necessary to convert the id from base 10 to base 62

# Base 62 coder

    1- First declare a character array with all the base 62 characters.
    2- Make the modular division between the number to be converted by 62 to get the position of 
    the first char of the base 62 code (that index is the residue of the division)
    3- Add the char to the beginning of the string of the base 62 code
    4- Divide the given number by 62 and get the integer part and repeat the process
    
# Technical-Assesment