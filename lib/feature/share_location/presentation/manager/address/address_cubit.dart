import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/feature/share_location/data/repos/address_repo.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository addressRepository;

  AddressCubit({required this.addressRepository}) : super(AddressInitial());

  Future<void> getAddressFromCoordinates(LatLng coordinates) async {
    emit(AddressLoading());
    try {
      final address = await addressRepository.getAddressFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );

      emit(AddressLoaded(address));
    } catch (e) {
      emit(const AddressError('حدث خطأ أثناء تحميل العنوان'));
    }
  }

  Future<void> saveLocation(
    String userId,
    LatLng coordinates,
    String locationName,
  ) async {
    emit(AddressSaving());
    try {
      await addressRepository.saveUserLocation(
        userId,
        coordinates.latitude,
        coordinates.longitude,
        locationName,
      );
      emit(AddressSaved());
    } catch (e) {
      emit(const AddressError('حدث خطأ أثناء حفظ الموقع'));
    }
  }
}
