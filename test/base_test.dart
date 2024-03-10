import 'package:bacon_bringer/bases/list_property.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:flutter_test/flutter_test.dart';

import 'util.dart';

void main() {
  group("ListProperty", () {
    test("ListPropertyが初期化されていること", () {
      final defaultValues = [0, 1, 2];
      final listProperty =
          ListProperty<int>(defaultValues, TestNotifier(testCallback: () {}));
      expect(listProperty.value.length, 3);
      expect(listProperty.onNotified, isNotNull);
    });

    test("ListPropertyに値を追加して反映されること", () {
      final defaultValues = [0, 1, 2];
      final targetValues = [0, 1, 2, 3];
      final listProperty = ListProperty<int>(defaultValues, TestNotifier());
      expect(listProperty.value.length, 3);
      expect(listProperty.onNotified, isNotNull);
      listProperty.value.asMap().forEach((value, index) {
        expect(value, defaultValues[index]);
      });
      listProperty.add(3);
      expect(listProperty.value.length, 4);
      listProperty.value.asMap().forEach((value, index) {
        expect(value, targetValues[index]);
      });
      expect(listProperty.value.last, 3);
    });

    test("ListPropertyから値を削除して反映されること", () {
      final defaultValues = [0, 1, 2];
      final targetValues = [0, 2];
      final listProperty = ListProperty<int>(defaultValues, TestNotifier());
      expect(listProperty.value.length, 3);
      expect(listProperty.onNotified, isNotNull);
      listProperty.value.asMap().forEach((value, index) {
        expect(value, defaultValues[index]);
      });
      listProperty.remove(1);
      expect(listProperty.value.length, 2);
      for (int i = 0; i < listProperty.value.length; i++) {
        final value = listProperty.value[i];
        expect(value, targetValues[i]);
      }
    });
  });

  group("Property", () {
    test("Propertyが初期化されていること", () {
      final property = Property<int>(0, TestNotifier());
      expect(property.value, 0);
      expect(property.onNotified, isNotNull);
    });
  });
}
