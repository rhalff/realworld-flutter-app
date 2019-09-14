// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

abstract class _$LoginUserValidator implements Validator<LoginUser> {
  static String passwordSizeMessage(int min, int max, Object validatedValue) {
    return 'password length must be between $min and $max';
  }

  @override
  List<FieldValidator> getFieldValidators() {
    return [
      FieldValidator<String>(
          name: 'email', validators: [EmailValidator(), NotEmptyValidator()]),
      FieldValidator<String>(name: 'password', validators: [
        NotEmptyValidator(),
        SizeValidator(min: 2, max: 20)..message = passwordSizeMessage
      ])
    ];
  }

  String validateEmail(Object value) => errorCheck('email', value);
  String validatePassword(Object value) => errorCheck('password', value);
  @override
  PropertyMap<LoginUser> props(LoginUser instance) {
    return PropertyMap<LoginUser>(
        {'email': instance.email, 'password': instance.password});
  }
}
