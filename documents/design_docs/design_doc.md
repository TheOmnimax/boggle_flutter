# Design document

## What it should do

* First prompted to start new game or join game room.
  * If start new game, then select board and settings, such as time, and display code to join room. Person who starts game will be "Host", and can start and pause the game as needed.
  * If join game, can enter code to enter that room (can also go there by direct URL)
* When waiting, displays a grid with hidden letters, and the start time. The letters will already be generated, but not received by the JavaScript, it is only stored on the server, so users can't cheat by hacking the JavaScript.
* When the host starts the game, the letters appear, and the timer starts.
* Players will be able to use their keyboard to enter words, and if they are real words, it is added to their personal word list.
* When the game is over, no more words can be entered, and results are displayed. It shows the lists of each player, which words they have in common, how many points they get for each unique word, and their total scores.
* Also displays all words that no one got.

## Tech stack

* FastAPI (Flask) and FastAPI
* Use Flutter as web apps

## Need to know

* How to control stuff from the server side, such as starting-and-stopping the game automatically, and handling new data retrieved from the players
* How to create a game room that others can't just enter at any time
* Create codes for joining the game, and create system for understanding the code
* Create word verifier to make sure entered word is correct
* Keep track of words entered by each player
* Compare words of each player, check if there are any in common, and create score based on their unique words

## Out of scope

* Preventing hacking of timestamp on client side, since better to work in areas with poor internet so anyone can play, and need to track their timestamps
