import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothersontasks/routers.dart';

import 'features/dashboard/presantation/bloc/activity_bloc.dart';

void main() {
  runApp(const MotherSonTasksApp());
}

class MotherSonTasksApp extends StatelessWidget {
  const MotherSonTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivityBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}


