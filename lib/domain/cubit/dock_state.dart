part of 'dock_cubit.dart';

class DockState extends Equatable {
  final List<IconData> icons;
  final int draggingIndex;
  final int hoverIndex;

  const DockState({required this.icons, required this.draggingIndex, required this.hoverIndex});

  DockState copyWith({List<IconData>? icons, int? draggingIndex, int? hoverIndex}) {
    return DockState(
      icons: icons ?? this.icons,
      draggingIndex: draggingIndex ?? this.draggingIndex,
      hoverIndex: hoverIndex ?? this.hoverIndex,
    );
  }

  @override
  List<Object> get props => [icons, draggingIndex, hoverIndex];
}
