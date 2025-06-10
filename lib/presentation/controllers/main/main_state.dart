part of 'main_cubit.dart';

class MainState extends Equatable {
  final int timeStamp;
  final int currentIndex;
  final BottomNavigationEnum selected;

  const MainState({
    this.currentIndex = 1,
    this.selected = BottomNavigationEnum.Home,
    this.timeStamp = 0,
  });

  MainState copyWith({
    int? currentIndex,
    BottomNavigationEnum? selected,
    int? timeStamp,
  }) {
    return MainState(
      currentIndex: currentIndex ?? this.currentIndex,
      selected: selected ?? this.selected,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  @override
  List<Object> get props => [currentIndex, selected, timeStamp];
}
