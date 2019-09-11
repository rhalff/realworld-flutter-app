// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

abstract class _$ArticleValidator implements Validator<Article> {
  @override
  List<FieldValidator> getFieldValidators() {
    return [
      FieldValidator<String>(name: 'title', validators: [NotEmptyValidator()]),
      FieldValidator<String>(
          name: 'description', validators: [SizeValidator(min: 1, max: 500)]),
      FieldValidator<String>(name: 'body', validators: [NotEmptyValidator()])
    ];
  }

  String validateTitle(Object value) => errorCheck('title', value);
  String validateDescription(Object value) => errorCheck('description', value);
  String validateBody(Object value) => errorCheck('body', value);
  @override
  PropertyMap<Article> props(Article instance) {
    return PropertyMap<Article>({
      'title': instance.title,
      'description': instance.description,
      'body': instance.body
    });
  }
}
