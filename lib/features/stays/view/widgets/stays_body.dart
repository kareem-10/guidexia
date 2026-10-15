import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/stay_cubit.dart';
import '../../view_model/cubit/stay_state.dart';
import 'stay_card.dart';

class StaysBody extends StatelessWidget {
  const StaysBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StayCubit, StayState>(
      builder: (context, state) {
        if (state is StayLoading || state is StayInitial) {
          return const _StaysLoading();
        }

        if (state is StayFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 12),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      context.read<StayCubit>().getStays();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try again'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is StaySuccess) {
          if (state.stays.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('No stays available right now.'),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            itemCount: state.stays.length,
            separatorBuilder: (_, _) => const SizedBox(height: 22),
            itemBuilder: (context, index) {
              return StayCard(stay: state.stays[index]);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _StaysLoading extends StatelessWidget {
  const _StaysLoading();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      itemCount: 3,
      separatorBuilder: (_, _) => const SizedBox(height: 22),
      itemBuilder: (context, index) {
        return Container(
          height: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 210, color: Colors.grey.shade200),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 18,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 14,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
