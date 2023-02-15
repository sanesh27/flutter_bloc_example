import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/bloc/timer_bloc.dart';

export 'bloc/timer_bloc.dart';
export 'view/timer_page.dart';

class TimerActions extends StatelessWidget {
  const TimerActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (state is TimerInitial) ...[
            FloatingActionButton(
              onPressed: () {
                return context.read<TimerBloc>().add(TimerStarted(duration: state.duration));
              },
              child: const Icon(Icons.play_arrow),
            ),
          ],
          if (state is TimerRunInProgress) ...[
            FloatingActionButton(
              onPressed: () {
                return context.read<TimerBloc>().add(const TimerPaused());
              },
              child: const Icon(Icons.pause),
            ),
          ],
          if (state is TimerRunPause) ...[
            FloatingActionButton(
              child: const Icon(Icons.play_arrow),
              onPressed: () => context.read<TimerBloc>().add(const TimerResumed()),
            ),
            FloatingActionButton(
              child: const Icon(Icons.replay),
              onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
            ),
          ],
          if (state is TimerRunComplete) ...[
            FloatingActionButton(
              child: const Icon(Icons.replay),
              onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
            ),
          ],
        ],
      );
    });
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade500,
            ]
        ),
      ),
    );
  }
}

