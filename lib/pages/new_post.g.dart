// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_post.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

abstract class _$PostDataValidator implements Validator<PostData> {
  @override
  List<FieldValidator> getFieldValidators() {
    return [
      FieldValidator<String>(
          name: 'title', validators: [SizeValidator(min: 2, max: 255)]),
      FieldValidator<String>(
          name: 'description',
          validators: [NotEmptyValidator(), SizeValidator(min: 1, max: 500)]),
      FieldValidator<String>(name: 'body', validators: [NotEmptyValidator()]),
      FieldValidator<List<String>>(
          name: 'tags', validators: [NotEmptyValidator()])
    ];
  }

  String validateTitle(Object value) => errorCheck('title', value);
  String validateDescription(Object value) => errorCheck('description', value);
  String validateBody(Object value) => errorCheck('body', value);
  String validateTags(Object value) => errorCheck('tags', value);
  @override
  PropertyMap<PostData> props(PostData instance) {
    return PropertyMap<PostData>({
      'title': instance.title,
      'description': instance.description,
      'body': instance.body,
      'tags': instance.tags
    });
  }
}
