#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only --no-align -c"

echo -e "Enter your username:"
read USERNAME
#echo -e "|"$USERNAME"|"
GAMES_PLAYED=$($PSQL "SELECT games_played FROM master WHERE username = '$USERNAME'")
#echo GAMES_PLAYED = $GAMES_PLAYED
if [[ -z $GAMES_PLAYED ]]
then
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
else
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM master WHERE username = '$USERNAME'")
  BEST_GUESSES=$($PSQL "SELECT best_guesses FROM master WHERE username = '$USERNAME'")
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GUESSES guesses."
fi
RANDOM_NUMBER=$[ $RANDOM % 1000 + 1 ]
echo -e "Guess the secret number between 1 and 1000:"

GET_INPUT(){
  NUM_TRIES=$(($NUM_TRIES+1))
  read INPUT
  RESPOND
}

RESPOND(){
  if ! [[ $INPUT =~ ^[0-9]+$ ]]
  then
    echo -e "That is not an integer, guess again:"
    GET_INPUT
  else 
    if [[ $INPUT -gt $RANDOM_NUMBER ]]
    then
      echo -e "It's lower than that, guess again:"
      GET_INPUT
    else
      if [[ $INPUT -lt $RANDOM_NUMBER ]]
      then
        echo -e "It's higher than that, guess again:"
        GET_INPUT
      else
        if [[ $INPUT -eq $RANDOM_NUMBER ]]
        then
          echo -e "You guessed it in $NUM_TRIES tries. The secret number was $RANDOM_NUMBER. Nice job!"
          #echo NUM_TRIES $NUM_TRIES
          #echo BEST_GUESS $BEST_GUESSES
          if [[ -z $GAMES_PLAYED ]]
          then
            ADD_USER_RESULT=$($PSQL "INSERT INTO master (best_guesses, username) VALUES (0, '$USERNAME')")
            UPDATE_SCORE=$($PSQL "UPDATE master SET best_guesses = $NUM_TRIES WHERE username = '$USERNAME'")
            UPDATE_GAMES=$($PSQL "UPDATE master SET games_played = 1 WHERE username = '$USERNAME'")
          else
            if [[ $BEST_GUESSES == 0 || $NUM_TRIES -lt $BEST_GUESSES ]]
            then
              UPDATE_SCORE=$($PSQL "UPDATE master SET best_guesses = $NUM_TRIES WHERE username = '$USERNAME'")
              #echo $UPDATE_SCORE
              NEW_GAMES=$((GAMES_PLAYED + 1))
              #echo $NEW_GAMES
              #echo $NUM_TRIES
              UPDATE_GAMES=$($PSQL "UPDATE master SET games_played = $NEW_GAMES WHERE username = '$USERNAME'") 
            fi
          fi
        fi
      fi
    fi
  fi
}

NUM_TRIES=0

GET_INPUT
