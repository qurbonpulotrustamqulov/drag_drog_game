import 'package:drag_drop_gape/bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'item_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ItemModel> items;
  late List<ItemModel> items2;
  late bool gameOver;
  late AudioPlayer audioPlayer;

  initGame() {
    gameOver = false;
    items = [
      ItemModel(name: "lion", value: "Lion", img: "assets/lion.jpg"),
      ItemModel(name: "dogs", value: "Dogs", img: "assets/dogs.jpg"),
      ItemModel(name: "bird", value: "Bird", img: "assets/bird.jpg"),
      ItemModel(name: "tiger", value: "Tiger", img: "assets/tiger.jpg"),
      ItemModel(
          name: "butterfly", value: "Butterfly", img: "assets/butterfly.jpg"),
      ItemModel(name: "deer", value: "Deer", img: "assets/deer.jpg"),
      ItemModel(name: "fox", value: "Fox", img: "assets/fox.jpg"),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
    audioPlayer = AudioPlayer()..setAsset("assets/game_over.wav");
  }

  @override
  void initState() {
    initGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Score: ",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextSpan(
                              text: "${state.score}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.teal))
                        ],
                      ),
                    ),
                  ),
                  if (!gameOver)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Column(
                          children: items.map((item) {
                            return Container(
                              margin: const EdgeInsets.all(11),
                              child: Draggable<ItemModel>(
                                data: item,
                                childWhenDragging: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(item.img),
                                  radius: 50,
                                ),
                                feedback: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(item.img),
                                  radius: 40,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(item.img),
                                  radius: 40,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Column(
                          children: items2.map((item) {
                            return DragTarget<ItemModel>(
                              onAccept: (receivedItem) {
                                if (item.value == receivedItem.value) {
                                  items.remove(receivedItem);
                                  items2.remove(item);
                                  BlocProvider.of<GameBloc>(context)
                                      .add(const AddScoreEvent(score: 10));
                                  item.accepting = false;
                                  if (items.isNotEmpty) {
                                    audioPlayer.setAsset("assets/win.wav");
                                    audioPlayer.play();
                                  } else {
                                    audioPlayer
                                        .setAsset("assets/game_over.wav");
                                    audioPlayer.play();
                                    gameOver = true;
                                  }

                                  ///TODO true song
                                } else {
                                  BlocProvider.of<GameBloc>(context)
                                      .add(const AddScoreEvent(score: -5));
                                  item.accepting = false;

                                  if (items.isNotEmpty) {
                                    audioPlayer.setAsset("assets/lose.wav");
                                    audioPlayer.play();
                                  } else {
                                    audioPlayer
                                        .setAsset("assets/game_over.wav");
                                    audioPlayer.play();
                                    gameOver = true;
                                  }

                                  ///TODO false song
                                }
                              },
                              onWillAccept: (receivedItem) {
                                item.accepting = true;
                                BlocProvider.of<GameBloc>(context)
                                    .add(const StateEvent());
                                return true;
                              },
                              onLeave: (receivedItem) {
                                item.accepting = false;
                                BlocProvider.of<GameBloc>(context)
                                    .add(const StateEvent());
                              },
                              builder: (context, candidateData, rejectedData) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: item.accepting
                                      ? Colors.grey[400]
                                      : Colors.grey[200],
                                ),
                                alignment: Alignment.center,
                                height: MediaQuery.sizeOf(context).height / 9.2,
                                width: MediaQuery.sizeOf(context).width / 3,
                                margin: const EdgeInsets.all(8),
                                child: Text(
                                  item.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const Spacer(),
                      ],
                    ),
                  if (gameOver)
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Game Over",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                initGame();
                                BlocProvider.of<GameBloc>(context)
                                    .add(const StateEvent());
                              },
                              icon: const Icon(Icons.restart_alt_sharp))
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
