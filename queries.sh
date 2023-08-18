#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo  "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo  "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo  "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo  "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT winner_goals FROM games ORDER BY winner_goals DESC")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo echo "$($PSQL "SELECT teams.name FROM teams JOIN(SELECT winner_id, COUNT(*) AS num_wins FROM games WHERE year = 2018 GROUP BY winner_id ORDER BY num_wins DESC LIMIT 1) AS winning_teams ON teams.team_id = winning_teams.winner_id")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT DISTINCT teams.name FROM teams JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE games.year = 2014 AND games.round = 'Eighth-Final'")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT games.year, teams.name
              FROM teams
              JOIN games ON teams.team_id = games.winner_id
              WHERE games.year = 2014 OR games.year = 2018")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"
