/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

enum PinProperty implements _i1.SerializableModel {
  Digital,
  Analog,
  Pwm,
  I2C,
  SPI,
  I2S,
  Interrupt;

  static PinProperty fromJson(int index) {
    switch (index) {
      case 0:
        return PinProperty.Digital;
      case 1:
        return PinProperty.Analog;
      case 2:
        return PinProperty.Pwm;
      case 3:
        return PinProperty.I2C;
      case 4:
        return PinProperty.SPI;
      case 5:
        return PinProperty.I2S;
      case 6:
        return PinProperty.Interrupt;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "PinProperty"');
    }
  }

  @override
  int toJson() => index;
  @override
  String toString() => name;
}
