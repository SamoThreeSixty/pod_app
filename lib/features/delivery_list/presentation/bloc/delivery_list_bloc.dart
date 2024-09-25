import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:pod_app/features/delivery_list/domain/usecases/get_all_delivery_headers.dart';

part 'delivery_list_event.dart';
part 'delivery_list_state.dart';

class DeliveryListBloc extends Bloc<DeliveryListEvent, DeliveryListState> {
  final GetAllDeliveryHeaders _getAllDeliveryList;

  DeliveryListBloc({required GetAllDeliveryHeaders getAllDeliveryList})
      : _getAllDeliveryList = getAllDeliveryList,
        super(DeliveryListInitial()) {
    on<DeliveryListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAllDeliveryList>(_onGetAllEventLogs);
  }

  void _onGetAllEventLogs(
      GetAllDeliveryList event, Emitter<DeliveryListState> emit) async {
    final res = await _getAllDeliveryList(NoParams());

    res.fold(
      (l) => emit(DeliveryListFailure(l.message)),
      (r) => emit(
        DeliveryListSuccess(r),
      ),
    );
  }
}
