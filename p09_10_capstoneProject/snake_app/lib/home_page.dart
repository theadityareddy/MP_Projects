import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// design: cleaner and cuter...
// make apk and publish to github...
// learn how to publish an apk to the macapplestore lol...

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List snakePosition = [45, 65, 85, 105, 125];
  int fruitPosition = 330;
  bool gameOver = false;
  bool isPaused = false;
  String direction = 'down';
  int boxesInARow = 20;
  int score = 0;
  bool isButtonActive = true;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _usernameController = TextEditingController();
  bool _scoreSaved = false;
  Timer? _gameTimer;
  int _baseSpeed = 300; // Base speed in milliseconds
  int _currentSpeed = 300; // Current speed that changes with score
  int _snakeGrowthInterval = 3; // Grow snake every 3 points

  generateFruit(numberOfRows, firstColumn, lastColumn) {
    int totalBoxes = boxesInARow * boxesInARow;

    Random random = Random();

    int newFruitPosition = random.nextInt(totalBoxes);
    while (snakePosition.contains(newFruitPosition) ||
        (newFruitPosition >= boxesInARow * (numberOfRows) - 1) ||
        (newFruitPosition <= (boxesInARow - 1)) ||
        (firstColumn.contains(newFruitPosition)) ||
        (lastColumn.contains(newFruitPosition))) {
      newFruitPosition = random.nextInt(totalBoxes);
    }

    setState(() {
      fruitPosition = newFruitPosition;
    });
  }

  int _calculateSpeed() {
    // Decrease speed (make faster) as score increases
    // Minimum speed of 100ms, maximum speed of 300ms
    return (_baseSpeed - (score * 10)).clamp(100, 1000);
  }

  void _growSnake() {
    // Add a new segment in the direction of movement
    int lastPosition = snakePosition.last;
    int newPosition;
    
    switch (direction) {
      case 'down':
        newPosition = lastPosition + 20;
        break;
      case 'up':
        newPosition = lastPosition - 20;
        break;
      case 'left':
        newPosition = lastPosition - 1;
        break;
      case 'right':
        newPosition = lastPosition + 1;
        break;
      default:
        newPosition = lastPosition;
    }
    
    setState(() {
      snakePosition.add(newPosition);
    });
  }

  startGame(numberOfRows, firstColumn, lastColumn) {
    setState(() {
      snakePosition = [45, 65, 85, 105, 125];
      fruitPosition = 330;
      direction = 'down';
      gameOver = false;
      isPaused = false;
      score = 0;
      _scoreSaved = false;
      _currentSpeed = _baseSpeed;
    });

    _gameTimer = Timer.periodic(Duration(milliseconds: _currentSpeed), (Timer timer) {
      if (!isPaused) {
        // Update speed based on current score
        _currentSpeed = _calculateSpeed();
        timer.cancel();
        _gameTimer = Timer.periodic(Duration(milliseconds: _currentSpeed), (Timer t) {
          if (!isPaused) {
            updateSnake(numberOfRows, direction, firstColumn, lastColumn);
            if (gameOver) {
              t.cancel();
              showGameOverDialog(numberOfRows, firstColumn, lastColumn);
            }
          }
        });
        
        updateSnake(numberOfRows, direction, firstColumn, lastColumn);
        if (gameOver) {
          timer.cancel();
          showGameOverDialog(numberOfRows, firstColumn, lastColumn);
        }
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  Future<void> _saveScore() async {
    if (!_scoreSaved && _auth.currentUser != null) {
      final userEmail = _auth.currentUser!.email!;
      
      // Get the current user's document
      final userScoreDoc = await _firestore
          .collection('highscores')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userScoreDoc.docs.isEmpty) {
        // If no score exists for this user, create a new document
        await _firestore.collection('highscores').add({
          'email': userEmail,
          'score': score,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        // If score exists, update only if new score is higher
        final currentScore = userScoreDoc.docs.first.data()['score'] as int;
        if (score > currentScore) {
          await userScoreDoc.docs.first.reference.update({
            'score': score,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
      }
      setState(() {
        _scoreSaved = true;
      });
    }
  }

  void showGameOverDialog(numberOfRows, firstColumn, lastColumn) {
    _saveScore(); // Save score when game is over
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Score: $score'),
              const SizedBox(height: 20),
              const Text(
                'High Scores',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('highscores')
                    .orderBy('score', descending: true)
                    .limit(5)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  return Column(
                    children: snapshot.data!.docs.asMap().entries.map((entry) {
                      final doc = entry.value;
                      final rank = entry.key + 1;
                      final email = doc['email'] as String;
                      final displayName = email.split('@')[0]; // Show only the part before @
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$rank. $displayName',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              '${doc['score']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[900],
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                startGame(numberOfRows, firstColumn, lastColumn);
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  updateSnake(numberOfRows, direction, firstColumn, lastColumn) {
    List snakePositionNoHead = [...snakePosition];
    snakePositionNoHead.removeLast();

    if (direction == 'down') {
      setState(() {
        if (snakePosition.last >= (boxesInARow * (numberOfRows) - 1)) {
          snakePosition.add(snakePosition.last - (numberOfRows) * boxesInARow);
          snakePosition.removeAt(0);
        } else if (snakePosition.last == fruitPosition) {
          snakePosition.add(snakePosition.last + 20);
          score++;
          // Grow snake every _snakeGrowthInterval points
          if (score % _snakeGrowthInterval == 0) {
            _growSnake();
          }
          generateFruit(numberOfRows, firstColumn, lastColumn);
        } else if (snakePositionNoHead.contains(snakePosition.last)) {
          gameOver = true;
        } else {
          snakePosition.add(snakePosition.last + 20);
          snakePosition.removeAt(0);
        }
      });
    } else if (direction == 'left') {
      setState(() {
        if (firstColumn.contains(snakePosition.last)) {
          snakePosition.add(snakePosition.last + 19);
          snakePosition.removeAt(0);
        } else if (snakePosition.last == fruitPosition) {
          snakePosition.add(snakePosition.last - 1);
          score++;
          if (score % _snakeGrowthInterval == 0) {
            _growSnake();
          }
          generateFruit(numberOfRows, firstColumn, lastColumn);
        } else if (snakePositionNoHead.contains(snakePosition.last)) {
          gameOver = true;
        } else {
          snakePosition.add(snakePosition.last - 1);
          snakePosition.removeAt(0);
        }
      });
    } else if (direction == 'right') {
      setState(() {
        if (lastColumn.contains(snakePosition.last)) {
          snakePosition.add(snakePosition.last - 19);
          snakePosition.removeAt(0);
        } else if (snakePosition.last == fruitPosition) {
          snakePosition.add(snakePosition.last + 1);
          score++;
          if (score % _snakeGrowthInterval == 0) {
            _growSnake();
          }
          generateFruit(numberOfRows, firstColumn, lastColumn);
        } else if (snakePositionNoHead.contains(snakePosition.last)) {
          gameOver = true;
        } else {
          snakePosition.add(snakePosition.last + 1);
          snakePosition.removeAt(0);
        }
      });
    } else if (direction == 'up') {
      setState(() {
        if (snakePosition.last <= (boxesInARow - 1)) {
          snakePosition.add(
            snakePosition.last + (numberOfRows - 1) * boxesInARow,
          );
          snakePosition.removeAt(0);
        } else if (snakePosition.last == fruitPosition) {
          snakePosition.add(snakePosition.last - 20);
          score++;
          if (score % _snakeGrowthInterval == 0) {
            _growSnake();
          }
          generateFruit(numberOfRows, firstColumn, lastColumn);
        } else if (snakePositionNoHead.contains(snakePosition.last)) {
          gameOver = true;
        } else {
          snakePosition.add(snakePosition.last - 20);
          snakePosition.removeAt(0);
        }
      });
    }
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height * 0.9;

    double approxWidthBox = screenWidth / boxesInARow;
    double approxNumRows = screenHeight / approxWidthBox;

    int numberOfRows = approxNumRows.floor() - 1;

    List firstColumn = [];

    for (int i = 0; i < (numberOfRows * boxesInARow); i += 20) {
      firstColumn.add(i);
    }

    List lastColumn = [];

    for (int i = 19; i < (numberOfRows * boxesInARow); i += 20) {
      lastColumn.add(i);
    }

    int totalNumberBoxes = numberOfRows * boxesInARow;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Snake Game'),
            if (!isButtonActive) // Only show score when game is active
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Score: $score',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
            onPressed: togglePause,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (!isPaused) {
                  if (details.delta.dy > 0 && direction != 'up') {
                    direction = 'down';
                  } else if (details.delta.dy < 0 && direction != 'down') {
                    direction = 'up';
                  }
                }
              },
              onHorizontalDragUpdate: (details) {
                if (!isPaused) {
                  if (details.delta.dx > 0 && direction != 'left') {
                    direction = 'right';
                  } else if (details.delta.dx < 0 && direction != 'right') {
                    direction = 'left';
                  }
                }
              },
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: totalNumberBoxes,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: boxesInARow,
                  ),
                  itemBuilder: (context, int index) {
                    if (snakePosition.contains(index)) {
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Container(color: Colors.white),
                        ),
                      );
                    } else if (index == fruitPosition) {
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Container(color: Colors.green),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Container(color: Colors.grey[900]),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed:
                        isButtonActive
                            ? () {
                              startGame(numberOfRows, firstColumn, lastColumn);
                              setState(() {
                                isButtonActive = false;
                              });
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900],
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Start'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
