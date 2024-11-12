import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/dock_cubit.dart';

class Dock extends StatelessWidget {
  const Dock({super.key, required this.builder});

  final Widget Function(IconData) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DockCubit, DockState>(
      builder: (context, state) {
        final dockCubit = context.read<DockCubit>();
        final isDragging = dockCubit.state.draggingIndex != -1;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black12,
          ),
          padding: const EdgeInsets.all(4).copyWith(right: 16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.ease,
            width: isDragging ? (state.icons.length - 1) * 64.0 : state.icons.length * 64.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 64,
                width: (isDragging ? state.icons.length + 1 : state.icons.length) * 64.0,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: state.icons.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isDraggingItem = dockCubit.state.draggingIndex == index;

                    return AnimatedPositioned(
                      key: ValueKey(item),
                      duration: const Duration(milliseconds: 150), // Adjust animation duration here
                      curve: Curves.ease,
                      left: dockCubit.calculatePosition(index) * 64.0,
                      top: isDraggingItem ? 16 : 0,
                      child: Draggable<int>(
                        data: index,
                        feedback: Material(
                          color: Colors.transparent,
                          child: Transform.scale(
                            scale: 1.2,
                            child: builder(item),
                          ),
                        ),
                        childWhenDragging: const SizedBox(width: 48, height: 48),
                        onDragStarted: () {
                          dockCubit.startDragging(index);
                        },
                        onDragUpdate: (details) {
                          final newIndex = (details.globalPosition.dx / 64).round().clamp(0, state.icons.length - 1);
                          if (newIndex != dockCubit.state.hoverIndex) {
                            dockCubit.updateHoverIndex(newIndex);
                          }
                        },
                        onDragEnd: (details) {
                          final newIndex = (details.offset.dx / 64).round().clamp(0, dockCubit.state.icons.length - 1);
                          if (newIndex != dockCubit.state.draggingIndex) {
                            dockCubit.moveIcon(dockCubit.state.draggingIndex, newIndex);
                          } else {
                            dockCubit.stopDragging();
                          }
                        },
                        child: DragTarget<int>(
                          onWillAcceptWithDetails: (details) {
                            if (details.data != index) {
                              dockCubit.updateHoverIndex(index);
                              return true;
                            }
                            return false;
                          },
                          onAcceptWithDetails: (details) {
                            dockCubit.moveIcon(details.data, index);
                            dockCubit.clearHoverIndex();
                          },
                          onLeave: (_) {
                            dockCubit.clearHoverIndex();
                          },
                          builder: (context, candidateData, rejectedData) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 150), // Adjust animation duration here
                              curve: Curves.ease,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: builder(item),
                            );
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}