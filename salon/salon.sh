#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~\n"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "Which service would you like to schedule?"
  echo -e "\n1) Blow-out\n2) Cut and Style\n3) Color\n4) Style Only"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) SCHEDULE_MENU "1" ;;
    2) SCHEDULE_MENU "2" ;;
    3) SCHEDULE_MENU "3" ;;
    4) SCHEDULE_MENU "4" ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac
}

SCHEDULE_MENU(){
  echo -e "\nFor scheduling, please provide your phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_ID ]]
  then
    echo -e "\nWelcome new customer. What's your name?"
    read CUSTOMER_NAME
    INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  else
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID")
    echo -e "\nWelcome back,$CUSTOMER_NAME"
  fi
  echo -e "\nWhat time would you like to book this service?"
  read SERVICE_TIME
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $1, '$SERVICE_TIME')")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $1")
  if [[ $INSERT_APPOINTMENT_RESULT == "INSERT 0 1" ]]
  then
    echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  else
    echo $INSERT_APPOINTMENT_RESULT"|"
    MAIN_MENU "There was an issue with booking the$SERVICE_NAME for you. Please try again."
  fi
}

MAIN_MENU
