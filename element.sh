#! /bin/bash
PSQL="psql -X --username=postgres --dbname=periodic_table --tuples-only -c"

# if an argument is present
if [[ $1 ]]
    then
    # keep going 
    if [[ $1 =~ ^[0-9]+$ ]]
    then
    # get information from atomic_number
    AVAILABLE_ATOMS=$($PSQL "select atomic_number from elements where atomic_number=$1")
    if [[ -z $AVAILABLE_ATOMS ]]
        then
        echo -e "\nI could not find that element in the database."
        else
    ELEMENT_INFO=$($PSQL "select * from elements inner join properties using(atomic_number) where atomic_number=$1")
    READ_ELEMENTS 
    fi
    fi

    if [[ $1 =~ ^[A-Z]([a-z])?$ ]]
        then
        # get information from smybol
        AVAILABLE_SYMBOLS=$($PSQL "select symbol from elements where symbol='$1'")
            if [[ -z $AVAILABLE_SYMBOLS ]]
            then
            echo -e "\nI could not find that element in the database."
            else
            ELEMENT_INFO=$($PSQL "select * from elements inner join properties using(atomic_number) where symbol='$1'")
            READ_ELEMENTS
            fi
        fi

        if [[ $1 =~ ^[A-Z][a-z][a-z]+$ ]]
        then
        # get information from name
        AVAILABLE_NAMES=$($PSQL "select name from elements where name='$1'")
            if [[ -z $AVAILABLE_NAMES ]]
            then
            echo -e "\nI could not find that element in the database."
            else
            ELEMENT_INFO=$($PSQL "select * from elements inner join properties using(atomic_number) where name='$1'")
            READ_ELEMENTS
            fi
    fi

else
    # provide an arguemnt
    echo "Please provide an element as an argument."
fi