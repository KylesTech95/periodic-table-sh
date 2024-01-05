#! /bin/bash
PSQL="psql -X --username=postgres --dbname=periodic_table --tuples-only -c"

# if an argument is present
if [[ $1 ]]
    then
    # keep going 

else
    # provide an arguemnt
    echo "Please provide an element as an argument."
fi