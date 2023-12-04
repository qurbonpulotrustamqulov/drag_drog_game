part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}
class AddScoreEvent extends GameEvent{
  final int score;
  const AddScoreEvent({required this.score});
  @override
  List<Object?> get props => [];
}
class RemoveEvent extends GameEvent{
  final ItemModel model;
  const RemoveEvent({required this.model});
  @override
  List<Object?> get props => [model];
}
