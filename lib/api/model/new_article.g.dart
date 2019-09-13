// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_article.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

abstract class _$NewArticleValidator implements Validator<NewArticle> {
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
          name: 'tagList', validators: [NotEmptyValidator()])
    ];
  }

  String validateTitle(Object value) => errorCheck('title', value);
  String validateDescription(Object value) => errorCheck('description', value);
  String validateBody(Object value) => errorCheck('body', value);
  String validateTagList(Object value) => errorCheck('tagList', value);
  @override
  PropertyMap<NewArticle> props(NewArticle instance) {
    return PropertyMap<NewArticle>({
      'title': instance.title,
      'description': instance.description,
      'body': instance.body,
      'tagList': instance.tagList
    });
  }
}
