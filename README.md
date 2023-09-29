# FutQuiz App
FutQuiz is a football (soccer) quiz application. It contains 280 football players. A randomly selected football player from a list of these football players is presented to the user with a few attributes and the user tries to guess the football player presented.

## Features
*  Two themes: light and dark
*  Splash screen with force update functionality (by firebase, firestore)
*  Google sign-in button
*  Leaderboard
*  Football player guessing game

## Video From the App
https://github.com/emrekaya035/futquiz/assets/72754835/0b03bc9a-a12d-48d8-b894-cb6d68133afa

## Installation
1.  Clone the repository
2.  Run ``flutter pub get`` to install dependencies
3.  Run the app using ``flutter run``

## APK Setup
Dowloand this apk and setup the apk
*  https://drive.google.com/file/d/1sJsuYHsCAgUQ4i2sXL2ZG2-1UrytEQm-/view?usp=sharing

## Usage
*  On the main screen, the user must sign in with Google.
*  If the user is not already logged in, they can sign in with Google by clicking on the 'Sign in with Google' button.
*  On the home screen there is also a 'Scoreboard' button where the leaderboard can be viewed. By clicking on the button, you can see the leaderboard of other users and your own score.
*  Once the user is logged in on the main screen, the 'Who am I? Play!' button will be active where the user can play the football player prediction game.
*  In the football player guessing game, the user is presented with a randomly selected football player from a list of 280 players stored in the Firestore.
*  The user has to guess the player's name based on three clues: age, league and position.
*  The user has six attempts to guess the player's name. Each wrong guess deducts 2 points from the game's score.
*  If the user guesses the player's name correctly, the user gets 10 points. If the user guesses the player's name incorrectly, but the guess shares some common attributes with the correct answer, the common attributes are highlighted in green.
*  Finally, the user's score and progress are saved in the Firestore.

## Contributing
1.  Fork the repository
2.  Create a new branch (git checkout -b feature/branch)
3.  Make changes
4.  Commit your changes (git commit -m 'Add feature')
5.  Push to the branch (git push origin feature/branch)
6.  Create a new Pull Request

## About Data and Dataset of Players and Teams Which is in the App
All logos and brands are property of their respective owners and are used for identification purposes only

## License
This project is licensed under the MIT License. See the [LICENSE](https://github.com/emrekaya035/futquiz/blob/main/LICENSE.md) file for more information.

This README file provides an overview of your application's features and functionality. You can customize it to include additional information or images as needed.

If you have any questions or need further assistance, please don't hesitate to reach me.


