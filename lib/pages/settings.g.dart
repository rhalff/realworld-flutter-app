// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

abstract class _$SettingsDataValidator implements Validator<SettingsData> {
  static String passwordSizeMessage12(int min, int max, Object validatedValue) {
    return 'password length must be between $min and $max';
  }

  @override
  List<FieldValidator> getFieldValidators() {
    return [
      FieldValidator<String>(
          name: 'pictureUrl', validators: [SizeValidator(min: 2, max: 255)]),
      FieldValidator<String>(
          name: 'name', validators: [SizeValidator(min: 2, max: 255)]),
      FieldValidator<String>(
          name: 'email', validators: [EmailValidator(), NotEmptyValidator()]),
      FieldValidator<String>(name: 'password', validators: [
        NotEmptyValidator(),
        SizeValidator(min: 2, max: 20)..message = passwordSizeMessage12
      ])
    ];
  }

  String validatePictureUrl(Object value) => errorCheck('pictureUrl', value);
  String validateName(Object value) => errorCheck('name', value);
  String validateEmail(Object value) => errorCheck('email', value);
  String validatePassword(Object value) => errorCheck('password', value);
  @override
  PropertyMap<SettingsData> props(SettingsData instance) {
    return PropertyMap<SettingsData>({
      'pictureUrl': instance.pictureUrl,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password
    });
  }
}
