// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

abstract class _$UpdateUserValidator implements Validator<UpdateUser> {
  @override
  List<FieldValidator> getFieldValidators() {
    return [
      FieldValidator<String>(
          name: 'username', validators: [SizeValidator(min: 2, max: 255)]),
      FieldValidator<String>(
          name: 'email', validators: [EmailValidator(), NotEmptyValidator()]),
      FieldValidator<String>(
          name: 'bio',
          validators: [NotEmptyValidator(), SizeValidator(min: 1, max: 255)]),
      FieldValidator<String>(
          name: 'image', validators: [SizeValidator(min: 2, max: 255)])
    ];
  }

  String validateUsername(Object value) => errorCheck('username', value);

  String validateEmail(Object value) => errorCheck('email', value);

  String validateBio(Object value) => errorCheck('bio', value);

  String validateImage(Object value) => errorCheck('image', value);

  @override
  PropertyMap<UpdateUser> props(UpdateUser instance) {
    return PropertyMap<UpdateUser>({
      'username': instance.username,
      'email': instance.email,
      'bio': instance.bio,
      'image': instance.image
    });
  }
}
