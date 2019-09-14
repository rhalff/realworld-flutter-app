// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

abstract class _$NewUserValidator implements Validator<NewUser> {
  static String passwordSizeMessage1(int min, int max, Object validatedValue) {
    return 'password length must be between $min and $max';
  }

  @override
  List<FieldValidator> getFieldValidators() {
    return [
      FieldValidator<String>(
          name: 'username', validators: [SizeValidator(min: 2, max: 255)]),
      FieldValidator<String>(
          name: 'email', validators: [EmailValidator(), NotEmptyValidator()]),
      FieldValidator<String>(name: 'password', validators: [
        NotEmptyValidator(),
        SizeValidator(min: 2, max: 20)..message = passwordSizeMessage1
      ])
    ];
  }

  String validateUsername(Object value) => errorCheck('username', value);
  String validateEmail(Object value) => errorCheck('email', value);
  String validatePassword(Object value) => errorCheck('password', value);
  @override
  PropertyMap<NewUser> props(NewUser instance) {
    return PropertyMap<NewUser>({
      'username': instance.username,
      'email': instance.email,
      'password': instance.password
    });
  }
}
