#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games")

tail -n +2 games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  IFEXIST=$($PSQL "SELECT name FROM teams WHERE name = '$WINNER'")
  if [[ -z "$IFEXIST" ]]
  then
    $PSQL "INSERT INTO teams(name) VALUES('$WINNER')"
    echo "Inserted $WINNER on the teams table."
  fi
  IFEXIST2=$($PSQL "SELECT name FROM teams WHERE name = '$OPPONENT'")
  if [[ -z "$IFEXIST2" ]]
  then
    $PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')"
    echo "Inserted $OPPONENT on the teams table."
  fi
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
  $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)"
  echo "Inserted the game between the winner $WINNER and the opponent $OPPONENT, which 
  happened in the year of $YEAR, at the $ROUND round. The winner team scored $WINNER_GOALS goals,
  and the opponent scored $OPPONENT_GOALS goals."
done