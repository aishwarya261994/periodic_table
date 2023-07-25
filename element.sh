#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ $1 ]]
then
if [[ $1 =~ ^[0-9]+$ ]]
then 
RESULTS=$($PSQL "SELECT elements.atomic_number,elements.name,elements.symbol,types.type,properties.atomic_mass,properties.melting_point_celsius,properties.boiling_point_celsius FROM elements FULL JOIN properties ON elements.atomic_number=properties.atomic_number FULL JOIN types ON properties.type_id=types.type_id WHERE elements.atomic_number=$1")
else
RESULTS=$($PSQL "SELECT elements.atomic_number,elements.name,elements.symbol,types.type,properties.atomic_mass,properties.melting_point_celsius,properties.boiling_point_celsius FROM elements FULL JOIN properties ON elements.atomic_number=properties.atomic_number FULL JOIN types ON properties.type_id=types.type_id WHERE elements.symbol='$1' OR elements.name='$1'")
fi

if [[ -z $RESULTS ]]
then echo  "I could not find that element in the database."
else
# echo "$RESULTS"
echo "$RESULTS" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
do
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
done
fi
else
echo  "Please provide an element as an argument."
fi