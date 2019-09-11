// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_form.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

abstract class _$SignInDataValidator implements Validator<SignInData> {
  static String passwordSizeMessage1(int min, int max, Object validatedValue) {
    return 'password length must be between $min and $max';
  }

  @override
  List<FieldValidator> getFieldValidators() {
    return [
      FieldValidator<String>(
          name: 'name', validators: [SizeValidator(min: 2, max: 255)]),
      FieldValidator<String>(
          name: 'email', validators: [EmailValidator(), NotEmptyValidator()]),
      FieldValidator<String>(name: 'password', validators: [
        NotEmptyValidator(),
        SizeValidator(min: 2, max: 20)..message = passwordSizeMessage1
      ])
    ];
  }

  String validateName(Object value) => errorCheck('name', value);
  String validateEmail(Object value) => errorCheck('email', value);
  String validatePassword(Object value) => errorCheck('password', value);
  @override
  PropertyMap<SignInData> props(SignInData instance) {
    return PropertyMap<SignInData>({
      'name': instance.name,
      'email': instance.email,
      'password': instance.password
    });
  }
}
