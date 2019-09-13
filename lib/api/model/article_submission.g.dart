// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_submission.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

abstract class _$ArticleSubmissionValidator
    implements Validator<ArticleSubmission> {
  @override
  List<FieldValidator> getFieldValidators() {
    return [
      FieldValidator<String>(
          name: 'title', validators: [SizeValidator(min: 2, max: 255)]),
      FieldValidator<String>(
          name: 'description',
          validators: [NotEmptyValidator(), SizeValidator(min: 1, max: 500)]),
      FieldValidator<String>(name: 'body', validators: [NotEmptyValidator()])
    ];
  }

  String validateTitle(Object value) => errorCheck('title', value);
  String validateDescription(Object value) => errorCheck('description', value);
  String validateBody(Object value) => errorCheck('body', value);
  @override
  PropertyMap<ArticleSubmission> props(ArticleSubmission instance) {
    return PropertyMap<ArticleSubmission>({
      'title': instance.title,
      'description': instance.description,
      'body': instance.body
    });
  }
}
