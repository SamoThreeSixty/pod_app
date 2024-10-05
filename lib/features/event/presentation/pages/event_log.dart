import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pod_app/features/event/presentation/bloc/event_log_bloc.dart';
import 'package:pod_app/features/event/presentation/widgets/event_record.dart';

class EventLogPage extends StatefulWidget {
  const EventLogPage({super.key});

  @override
  State<EventLogPage> createState() => _EventLogPageState();
}

class _EventLogPageState extends State<EventLogPage> {
  @override
  void initState() {
    context.read<EventLogBloc>().add(DataGetAllEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<EventLogBloc, EventLogState>(
        builder: (event, state) {
          if (state is EventLogSuccess) {
            final events = state.eventLog;

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventRecord(event: events[index]);
              },
            );
          } else {
            return const Text('No data found');
          }
        },
      ),
    );
  }
}
