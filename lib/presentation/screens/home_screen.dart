import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/icon_repository.dart';
import '../../domain/cubit/dock_cubit.dart';
import '../../domain/use_cases/get_icons_use_case.dart';
import '../widgets/dock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Center(
              child: BlocProvider(
                create: (_) => DockCubit(GetIconsUseCase(IconRepository())),
                child: Dock(
                  builder: (e) {
                    return Container(
                      constraints: const BoxConstraints(minWidth: 48),
                      height: 48,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors
                            .primaries[e.hashCode % Colors.primaries.length],
                      ),
                      child: Center(child: Icon(e, color: Colors.white)),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
