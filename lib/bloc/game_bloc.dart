import 'package:bloc/bloc.dart';
import 'package:drag_drop_gape/item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'game_event.dart';
part 'game_state.dart';

 List<ItemModel>items = [
   ItemModel(name: "lion", value: "Lion", img: "assets/lion.jpg"),
   ItemModel(name: "dogs", value: "Dogs", img: "assets/dogs.jpg"),
   ItemModel(name: "bird", value: "Bird", img: "assets/bird.jpg"),
   ItemModel(name: "tiger", value: "Tiger", img: "assets/tiger.jpg"),
   ItemModel(name: "butterfly", value: "Butterfly", img: "assets/butterfly.jpg"),
   ItemModel(name: "deer", value: "Deer", img: "assets/deer.jpg"),
   ItemModel(name: "fox", value: "Fox", img: "assets/fox.jpg"),
 ];

 List<ItemModel> items2 = List<ItemModel>.from(items);
 class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial(items: items,audioPlayer: AudioPlayer(), gameOver: false,    items2 : items2,score: 0)) {
    on<AddScoreEvent>(_addScore);
    on<RemoveEvent>(_removeItem);
    on<StateEvent>(_setState);
  }

  void _addScore(AddScoreEvent event, Emitter emit){
    int score= state.score;
    List<ItemModel>items = state.items;
    List<ItemModel>items2 = state.items2;
    AudioPlayer audioPlayer = state.audioPlayer;
    bool gameOver = state.gameOver;
    emit(GameLoading(items: items, audioPlayer: audioPlayer, gameOver: gameOver, score: score, items2: items2));
    emit(AddScore(items: items, audioPlayer: audioPlayer, gameOver: gameOver, score: score+event.score, items2: items2));
  }
  void _removeItem(RemoveEvent event, Emitter emit){
    int score= state.score;
    List<ItemModel>items = state.items;
    List<ItemModel>items2 = state.items2;
    items2.remove(event.model);
    items.remove(event.model);
    AudioPlayer audioPlayer = state.audioPlayer;
    bool gameOver = state.gameOver;
    emit(GameLoading(items: items, audioPlayer: audioPlayer, gameOver: gameOver, score: score, items2: items2));
    emit(RemoveItem(items: items, audioPlayer: audioPlayer, gameOver: gameOver, score: score, items2: items2));
  }


  void _setState(StateEvent event, Emitter emit){
    int score= state.score;
    List<ItemModel>items = state.items;
    List<ItemModel>items2 = state.items2;
    AudioPlayer audioPlayer = state.audioPlayer;
    bool gameOver = state.gameOver;
    emit(GameLoading(items: items, audioPlayer: audioPlayer, gameOver: gameOver, score: score, items2: items2));
    emit(GameInitial(items: items, audioPlayer: audioPlayer, gameOver: gameOver, score: score, items2: items2));
  }
}
