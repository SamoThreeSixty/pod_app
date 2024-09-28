import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:pod_app/features/delivery_record/presentation/pages/delivery_page.dart';

class DeliveryRecord extends StatelessWidget {
  final DeliveryHeader delivery;

  const DeliveryRecord({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // if (true)
        //   {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => const ProcessDeliveryPage(),
        //       ),
        //     ),
        //   }
        // else
        //   {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DeliveryDetailPage(
              deliveryHeader: delivery,
            ),
          ),
        ),
        // }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 4.0,
        ),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Text(
                  'Order #${delivery.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  delivery.customer,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  delivery.address_line_1,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  delivery.address_line_2,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  delivery.postcode,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  delivery.region,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  delivery.country,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'dropCode',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const Positioned(
              right: 0,
              top: 0,
              child: _StatusPill(status: 'Active'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String status;

  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String displayText;

    switch (status.toLowerCase()) {
      case 'active':
        color = Colors.blue;
        displayText = 'Active';
        break;
      case 'failed':
        color = Colors.red;
        displayText = 'Failed';
        break;
      case 'complete':
        color = Colors.green;
        displayText = 'Complete';
        break;
      case 'part done':
        color = Colors.orange;
        displayText = 'Part Done';
        break;
      default:
        color = Colors.grey;
        displayText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        displayText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 8,
        ),
      ),
    );
  }
}
