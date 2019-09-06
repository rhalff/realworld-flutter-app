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
          name: 'body',
          validators: [NotEmptyValidator(), SizeValidator(min: 10, max: 255)]),
      FieldValidator<String>(name: 'tags', validators: [NotEmptyValidator()])
    ];
  }

  String validateTitle(Object value) => errorCheck('title', value);
  String validateBody(Object value) => errorCheck('body', value);
  String validateTags(Object value) => errorCheck('tags', value);
  @override
  PropertyMap<PostData> props(PostData instance) {
    return PropertyMap<PostData>({
      'title': instance.title,
      'body': instance.body,
      'tags': instance.tags
    });
  }
}
