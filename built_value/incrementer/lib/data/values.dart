import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'values.g.dart';

abstract class IncrementValue
    implements Built<IncrementValue, IncrementValueBuilder> {
  /// Declare a static final [Serializer] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<IncrementValue> get serializer =>
      _$incrementValueSerializer;

  int get value;

  factory IncrementValue.fromInt(int value) =>
      new _$IncrementValue._(value: value);

  factory IncrementValue([updates(IncrementValueBuilder b)]) = _$IncrementValue;

  IncrementValue._();
}
