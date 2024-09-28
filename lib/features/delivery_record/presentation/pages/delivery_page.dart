import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';
import 'package:pod_app/features/delivery_record/presentation/bloc/delivery_detail_bloc.dart';
import 'package:signature/signature.dart';

class DeliveryDetailPage extends StatefulWidget {
  final DeliveryHeader deliveryHeader;

  const DeliveryDetailPage({super.key, required this.deliveryHeader});

  @override
  State<DeliveryDetailPage> createState() => _DeliveryDetailPageState();
}

class _DeliveryDetailPageState extends State<DeliveryDetailPage> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: const Color.fromARGB(255, 0, 0, 0),
    exportBackgroundColor: Colors.blue,
  );

  @override
  void initState() {
    _signatureController.addListener(() => print("Signature Changed"));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<DeliveryDetailBloc>()
          .add(DeliveryGetDetails(widget.deliveryHeader.id));
    });
    super.initState();
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Text('Order Detail'),
            const SizedBox(width: 25),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: BlocBuilder<DeliveryDetailBloc, DeliveryDetailState>(
          builder: (context, state) {
            if (state is DeliveryDetailSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    subheading('Order information'),
                    line('Order number #${widget.deliveryHeader.id}'),
                    line('Customer: ${widget.deliveryHeader.customer}'),
                    addressSection(widget.deliveryHeader),
                    line('Contact: ${widget.deliveryHeader.city}'),
                    subheading('Item List'),
                    _itemListBuilder(state),
                    subheading('Images'),
                    // imageGrid(),
                    subheading('Signature'),
                    Signature(
                      controller: _signatureController,
                      height: 200,
                      backgroundColor: Colors.blue,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }

  Widget addressSection(DeliveryHeader delivery) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address: ',
          style: lineStyle(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(delivery.address_line_1, style: lineStyle()),
            if (delivery.address_line_2.isNotEmpty)
              Text(delivery.address_line_2),
            if (delivery.postcode.isNotEmpty) Text(delivery.postcode),
            if (delivery.region.isNotEmpty) Text(delivery.region),
            Text(delivery.country),
          ],
        ),
      ],
    );
  }

  // A better layout for images using Wrap
  // Widget imageGrid() {
  //   return Wrap(
  //     children: imageAssets.map(
  //       (image) {
  //         return Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Image.asset(
  //             image,
  //             width: 150,
  //           ),
  //         );
  //       },
  //     ).toList(),
  //   );
  // }

  // Updated ListView with proper height constraint
  Widget _itemListBuilder(DeliveryDetailSuccess state) {
    return SizedBox(
      height: 200, // Constrain height
      child: state.deliveryDetail.isNotEmpty
          ? ListView.builder(
              itemCount: state.deliveryDetail.length,
              itemBuilder: (context, index) {
                final delivery = state.deliveryDetail[index];
                return ListTile(
                  leading: Icon(
                    delivery.loaded
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                  ),
                  title: Text(delivery.stock_ref),
                  subtitle: Text('${delivery.quantity} x ${delivery.unit}'),
                );
              },
            )
          : const Text("No delivery items to display"),
    );
  }

  Container subheading(String text) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Text(text, style: subheadingStyle()),
    );
  }

  TextStyle subheadingStyle() {
    return const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
  }

  Container line(String text) {
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      child: Text(text, style: lineStyle()),
    );
  }

  TextStyle lineStyle() => const TextStyle(fontSize: 15);
}
