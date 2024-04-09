import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(WordleGame());
}

class WordleGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WordleScreen(),
    );
  }
}

class WordleScreen extends StatefulWidget {
  @override
  _WordleScreenState createState() => _WordleScreenState();
}

class _WordleScreenState extends State<WordleScreen> {
  late String secretWord;
  late List<String> guesses;
  late int remainingAttempts;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    // Generate a random five-letter word for the player to guess
    secretWord = generateRandomWord();
    guesses = List.filled(secretWord.length, '');
    remainingAttempts = 6;
  }

  String generateRandomWord() {
    // This is just a dummy function. You may replace it with your own logic
    List<String> words = ['apple', 'banana', 'cherry', 'grape', 'lemon'];
    return words[Random().nextInt(words.length)];
  }

  void makeGuess(String guess) {
    setState(() {
      if (guess.length == 1 && remainingAttempts > 0) {
        // Check if the guessed letter is in the secret word
        if (secretWord.contains(guess)) {
          for (int i = 0; i < secretWord.length; i++) {
            if (secretWord[i] == guess) {
              guesses[i] = guess;
            }
          }
        } else {
          remainingAttempts--;
        }
      }

      // Check if the player has won or lost
      if (guesses.join('') == secretWord) {
        // Player wins
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You guessed the word: $secretWord'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  startNewGame();
                },
                child: Text('Play Again'),
              ),
            ],
          ),
        );
      } else if (remainingAttempts == 0) {
        // Player loses
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Game Over'),
            content: Text('The word was: $secretWord'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  startNewGame();
                },
                child: Text('Play Again'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wordle Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Guess the word:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              guesses.join(' '),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (remainingAttempts > 0)
              Column(
                children: [
                  TextField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        makeGuess(value.toLowerCase());
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Attempts left: $remainingAttempts',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            else
              Text(
                'You have run out of attempts!',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}