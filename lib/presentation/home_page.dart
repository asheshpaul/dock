import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/dock_cubit.dart';
import 'widgets/dock.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                create: (_) => DockCubit(
                  const [
                    Icons.person,
                    Icons.message,
                    Icons.call,
                    Icons.camera,
                    Icons.photo,
                  ],
                ),
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
