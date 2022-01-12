# Hangman
A game of hangman to play in the console

[Live Preview](https://replit.com/@NotAtec/Hangman#main.rb) <--

## Game Description
In this version of hangman, you're tasked with solving a 5 to 12 character random word, by guessing each letter. The length of the word is randomly chosen at startup. 

You have 10 lives, and lose a life every time you incorrectly guess a letter. Once the counter reaches 0; you lose.

Saving is possible during every guess, by typing `SAVE` in the console.

## Instructions
This game of hangman is intended for 1-player, and played in the CLI. You can choose at the beginning to load a previously saved game, or to create a new one. 

You will have 10 incorrect guesses available, the incorrect letters are shown to you and you can see the known letters on screen.
## Built With
- Ruby
- Pry Byebug for testing
- OOP Paradigm
- YAML Serialization for saving rounds