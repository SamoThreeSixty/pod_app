import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';
import 'package:pod_app/features/delivery_record/domain/usecase/get_delivery_detail.dart';
import 'package:pod_app/features/delivery_record/domain/usecase/save_images.dart';
import 'package:pod_app/features/delivery_record/domain/usecase/save_signature.dart';

part 'delivery_detail_event.dart';
part 'delivery_detail_state.dart';

class DeliveryDetailBloc
    extends Bloc<DeliveryDetailEvent, DeliveryDetailState> {
  final GetDeliveryDetail _getDeliveryDetail;
  final SaveImages _saveImages;
  final SaveSignature _saveSignature;

  DeliveryDetailBloc({
    required getDeliveryDetail,
    required saveImages,
    required saveSignature,
  })  : _getDeliveryDetail = getDeliveryDetail,
        _saveImages = saveImages,
        _saveSignature = saveSignature,
        super(DeliveryDetailInitial()) {
    on<DeliveryGetDetails>(_onGetDeliveryDetail);
    on<SaveSignatureAndImages>(_onSaveSignatureAndImages);
  }

  void _onGetDeliveryDetail(
    DeliveryGetDetails event,
    Emitter<DeliveryDetailState> emit,
  ) async {
    emit(DeliveryDetailLoading());

    final res = await _getDeliveryDetail(event.id);

    res.fold((l) => emit(DeliveryDetailFailure(l.message)),
        (r) => emit(DeliveryDetailSuccess(r)));
  }

  void _onSaveSignatureAndImages(
      SaveSignatureAndImages event, Emitter<DeliveryDetailState> emit) async {
    emit(SaveSignatureAndImagesLoading());

    // Setting up the params for calling the functions
    SaveSignatureParams signatureParams = SaveSignatureParams(
        path: event.signaturePath, deliveryID: event.deliveryId);
    SaveImagesParams imagesParams =
        SaveImagesParams(paths: event.imagePaths, deliveryID: event.deliveryId);

    final resSignature = await _saveSignature(signatureParams);
    final resImage = await _saveImages(imagesParams);

    resSignature.flatMap((_) => resImage).fold((f) {
      emit(SaveSignatureAndImagesFailure());
    }, (r) {
      emit(SaveSignatureAndImagesSuccess());
    });
  }
}
