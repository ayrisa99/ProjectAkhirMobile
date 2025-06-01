import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/models/medicine_model.dart';

// State class, simpan list item di keranjang + list item yang dipilih
class AppState {
  final List<Medicine> shopItems;
  final List<Medicine> selectedItems;

  AppState({required this.shopItems, required this.selectedItems});

  factory AppState.initial() => AppState(shopItems: [], selectedItems: []);

  AppState copyWith({
    List<Medicine>? shopItems,
    List<Medicine>? selectedItems,
  }) {
    return AppState(
      shopItems: shopItems ?? this.shopItems,
      selectedItems: selectedItems ?? this.selectedItems,
    );
  }
}

// Cubit untuk kelola state keranjang + pilihan item
class AppStateCubit extends Cubit<AppState> {
  Map<String, int> quantities = {};
  List<Medicine> shopItems = [];
  List<Medicine> selectedItems = [];

  AppStateCubit() : super(AppState(shopItems: [], selectedItems: []));

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
