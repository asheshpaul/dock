import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dock_state.dart';

class DockCubit extends Cubit<DockState> {
  DockCubit(List<IconData> initialIcons)
      : super(
            DockState(icons: initialIcons, draggingIndex: -1, hoverIndex: -1));

  void startDragging(int index) {
    emit(state.copyWith(draggingIndex: index));
  }

  void stopDragging() {
    emit(state.copyWith(draggingIndex: -1, hoverIndex: -1));
  }

  void updateHoverIndex(int index) {
    emit(state.copyWith(hoverIndex: index));
  }

  void clearHoverIndex() {
    emit(state.copyWith(hoverIndex: -1));
  }

  void moveIcon(int fromIndex, int toIndex) {
    if (fromIndex < 0 || fromIndex >= state.icons.length || toIndex < 0 || toIndex >= state.icons.length) {
      return;
    }

    // Handle the case where the icon is dropped in the same slot
    if (fromIndex == toIndex) {
      emit(state.copyWith(draggingIndex: -1, hoverIndex: -1));
      return;
    }

    final icons = List<IconData>.from(state.icons);
    final icon = icons.removeAt(fromIndex);
    icons.insert(toIndex, icon);

    emit(state.copyWith(icons: icons, draggingIndex: -1, hoverIndex: -1));
  }


  double calculatePosition(int index) {
    final hoverIndex = state.hoverIndex;
    final draggingIndex = state.draggingIndex;

    if (draggingIndex != -1 && hoverIndex != -1) {
      if (index == draggingIndex) {
        return hoverIndex.toDouble();
      } else if (hoverIndex < draggingIndex && index >= hoverIndex && index < draggingIndex) {
        return index + 1.0;
      } else if (hoverIndex > draggingIndex && index > draggingIndex && index <= hoverIndex) {
        return index - 1.0;
      }
    }
    return index.toDouble();
  }


}
