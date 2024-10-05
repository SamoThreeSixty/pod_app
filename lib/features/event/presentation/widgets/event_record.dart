import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pod_app/features/event/domain/entities/event_log.dart';

class EventRecord extends StatefulWidget {
  // Handle how the date is displayed
  static DateFormat formatter = DateFormat('yyyy-MM-dd - HH:mm');

  final EventLog event;

  const EventRecord({super.key, required this.event});

  @override
  State<EventRecord> createState() => _EventRecordState();
}

class _EventRecordState extends State<EventRecord> {
  bool moreInformation = false;

  void _toggleShowMoreInfo() {
    setState(() {
      moreInformation = !moreInformation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          title: Text(widget.event.Description),
          subtitle: Text(
            EventRecord.formatter.format(widget.event.EventDate),
          ),
          trailing: IconButton(
            onPressed: _toggleShowMoreInfo,
            icon: Icon(moreInformation
                ? Icons.expand_less_outlined
                : Icons.expand_more),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: moreInformation
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.event.LogID.toString()),
                        Text(widget.event.UserID.toString()),
                        Text(widget.event.FreeType),
                        Text(widget.event.KeyValue),
                        Text(widget.event.ModuleName),
                        Text(widget.event.Operation),
                        Text(widget.event.ShortDesc),
                        Text(widget.event.Table),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
