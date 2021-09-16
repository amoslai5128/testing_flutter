import 'dart:convert';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:testing_flutter/local_storage.dart';

/* ------------------------------- Data Model ------------------------------- */
class Order {
  String id;
  String orderName;
  Order({
    required this.id,
    required this.orderName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderName': orderName,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      orderName: map['orderName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() => 'Order(id: $id, orderName: $orderName)';
}

/* ------------------------ Repository With CRUD API ------------------------ */
class OrderRepository implements ICRUD<Order, String> {
  @override
  Future<List<Order>> read(String? param) async {
    print('READ');

    await Future.delayed(Duration(seconds: 2)); // Fake latency
    final fakeOrders =
        List.generate(5, (index) => Order(id: 'id-$index', orderName: 'Order No.#$index')); // Generated fake orders

    return fakeOrders;
  }

  @override
  Future<Order> create(item, param) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future delete(List items, param) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> init() async {}

  @override
  Future update(List items, param) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

/* ----------------------------- Injected State ----------------------------- */
final testOrderCRUD = RM.injectCRUD<Order?, String>(
  () => OrderRepository(),
  readOnInitialization: true, // NOTE Must add this line.
  persist: () => PersistState(
    key: '__Order__',
    toJson: (List<Order?> orders) {
      print('TO JSON');
      final mappedOrders = (orders).map((o) => o?.toMap()).toList();
      return jsonEncode(mappedOrders);
    },
    fromJson: (json) {
      print('FROM JSON');
      return (jsonDecode(json) as List<Map<String, dynamic>>).map((mappedOrder) => Order.fromMap(mappedOrder)).toList();
    },
  ),
);
