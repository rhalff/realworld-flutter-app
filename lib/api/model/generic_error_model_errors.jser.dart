// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_error_model_errors.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$GenericErrorModelErrorsSerializer
    implements Serializer<GenericErrorModelErrors> {
  @override
  Map<String, dynamic> toMap(GenericErrorModelErrors model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'body',
        codeNonNullIterable(model.body, (val) => val as String, []));
    return ret;
  }

  @override
  GenericErrorModelErrors fromMap(Map map) {
    if (map == null) return null;
    final obj = GenericErrorModelErrors(
        body: codeNonNullIterable<String>(
                map['body'] as Iterable, (val) => val as String, <String>[]) ??
            getJserDefault('body'));
    return obj;
  }
}
