part of 'game_bloc.dart';

abstract class GameState extends Equatable {
   List<ItemModel> items;
   List<ItemModel> items2;
   int score;
   bool gameOver;
   AudioPlayer audioPlayer;
   GameState({required this.items, required this.audioPlayer, required this.gameOver, required this.score, required this.items2});
   @override
   List<Object?> get props => [score, items, items2, audioPlayer, gameOver];
}

class GameInitial extends GameState {
  GameInitial({required super.items, required super.audioPlayer, required super.gameOver, required super.score, required super.items2});
  @override
  List<Object> get props => [];
}
class GameLoading extends GameState {
  GameLoading({required super.items, required super.audioPlayer, required super.gameOver, required super.score, required super.items2});
  @override
  List<Object> get props => [];
}
class AddScore extends GameState {
  AddScore({required super.items, required super.audioPlayer, required super.gameOver, required super.score, required super.items2});
  @override
  List<Object> get props => [];
}

class RemoveItem extends GameState {
  RemoveItem({required super.items, required super.audioPlayer, required super.gameOver, required super.score, required super.items2});
  @override
  List<Object> get props => [];
}


