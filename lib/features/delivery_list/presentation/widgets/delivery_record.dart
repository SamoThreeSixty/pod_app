import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pod_app/features/delivery_list/data/database/delivery_header_dto.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:pod_app/features/delivery_list/presentation/widgets/status_pill.dart';
import 'package:pod_app/features/delivery_record/presentation/pages/view_delivery_page.dart';
import 'package:pod_app/features/delivery_record/presentation/pages/process_delivery_page.dart';

class DeliveryRecord extends StatelessWidget {
  final DeliveryHeader delivery;

  const DeliveryRecord({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (delivery.status == 0)
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProcessDeliveryPage(
                  deliveryHeader: delivery,
                ),
              ),
            ),
          }
        else
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DeliveryDetailPage(
                  deliveryHeader: delivery,
                ),
              ),
            ),
          }
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
            Positioned(
              right: 0,
              top: 0,
              child: StatusPill(status: delivery.status),
            ),
          ],
        ),
      ),
    );
  }
}
