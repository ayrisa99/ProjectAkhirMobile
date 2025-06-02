import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/models/medicine_model.dart';

class AppState {
  final List<Medicine> shopItems;
  final List<Medicine> selectedItems;
  final Map<String, DateTime> pickUpTimes;
  final Map<String, double> totalPrices;

  AppState({
    required this.shopItems,
    required this.selectedItems,
    this.pickUpTimes = const {},
    this.totalPrices = const {},
  });

  factory AppState.initial() => AppState(shopItems: [], selectedItems: []);

  AppState copyWith({
    List<Medicine>? shopItems,
    List<Medicine>? selectedItems,
    Map<String, DateTime>? pickUpTimes,
    Map<String, double>? totalPrices,
  }) {
    return AppState(
      shopItems: shopItems ?? this.shopItems,
      selectedItems: selectedItems ?? this.selectedItems,
      pickUpTimes: pickUpTimes ?? this.pickUpTimes,
      totalPrices: totalPrices ?? this.totalPrices,
    );
  }
}

// Cubit untuk kelola state keranjang + pilihan item
class AppStateCubit extends Cubit<AppState> {
  Map<String, int> quantities = {};
  List<Medicine> shopItems = [];
  List<Medicine> selectedItems = [];
  Map<String, DateTime> get pickUpTimes => state.pickUpTimes;
  Map<String, double> get totalPrices => state.totalPrices;

  AppStateCubit() : super(AppState(shopItems: [], selectedItems: []));

  void setOrderData(
    List<Medicine> items,
    Map<String, DateTime> times,
    Map<String, double> totals,
  ) {
    emit(
      state.copyWith(
        selectedItems: items,
        pickUpTimes: times,
        totalPrices: totals,
      ),
    );
  }

  void addItemToCart(Medicine item) {
    final id = item.name;
    if (!shopItems.any((e) => e.name == id)) {
      shopItems.add(item);
      quantities[id] = 1;
      selectedItems.add(item); // langsung tandai selected
    } else {
      quantities[id] = (quantities[id] ?? 1) + 1;
    }
    emit(state.copyWith(shopItems: shopItems, selectedItems: selectedItems));
  }

  void incrementQuantity(Medicine item) {
    final id = item.name;
    quantities[id] = (quantities[id] ?? 1) + 1;
    emit(state.copyWith(shopItems: shopItems, selectedItems: selectedItems));
  }

  void decrementQuantity(Medicine item) {
    final id = item.name;
    if ((quantities[id] ?? 1) > 1) {
      quantities[id] = (quantities[id] ?? 1) - 1;
      emit(state.copyWith(shopItems: shopItems, selectedItems: selectedItems));
    }
  }

  int getQuantity(Medicine item) {
    return quantities[item.name] ?? 1;
  }

  // CEK apakah item selected
  bool isItemSelected(Medicine item) {
    return selectedItems.any((e) => e.name == item.name);
  }

  // TOGGLE pilihan item
  void toggleItemSelected(Medicine item, bool selected) {
    final id = item.name;
    if (selected) {
      if (!selectedItems.any((e) => e.name == id)) {
        selectedItems.add(item);
      }
    } else {
      selectedItems.removeWhere((e) => e.name == id);
    }
    emit(state.copyWith(shopItems: shopItems, selectedItems: selectedItems));
  }

  void removeItemFromCart(Medicine item) {
    final id = item.name;
    shopItems.removeWhere((e) => e.name == id);
    quantities.remove(id);
    selectedItems.removeWhere((e) => e.name == id);
    emit(state.copyWith(shopItems: shopItems, selectedItems: selectedItems));
  }
}
