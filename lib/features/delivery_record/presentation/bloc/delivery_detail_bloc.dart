import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';
import 'package:pod_app/features/delivery_record/domain/usecase/get_delivery_detail.dart';

part 'delivery_detail_event.dart';
part 'delivery_detail_state.dart';

class DeliveryDetailBloc
    extends Bloc<DeliveryDetailEvent, DeliveryDetailState> {
  final GetDeliveryDetail _getDeliveryDetail;

  DeliveryDetailBloc({required getDeliveryDetail})
      : _getDeliveryDetail = getDeliveryDetail,
        super(DeliveryDetailInitial()) {
    on<DeliveryGetDetails>(_onGetDeliveryDetail);
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
}
