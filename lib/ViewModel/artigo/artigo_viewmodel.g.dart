// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artigo_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ArtigoViewModel on ArtigoViewModelMobx, Store {
  Computed<List<String>>? _$topicosComputed;

  @override
  List<String> get topicos =>
      (_$topicosComputed ??= Computed<List<String>>(() => super.topicos,
              name: 'ArtigoViewModelMobx.topicos'))
          .value;

  late final _$_topicosAtom =
      Atom(name: 'ArtigoViewModelMobx._topicos', context: context);

  @override
  List<String> get _topicos {
    _$_topicosAtom.reportRead();
    return super._topicos;
  }

  @override
  set _topicos(List<String> value) {
    _$_topicosAtom.reportWrite(value, super._topicos, () {
      super._topicos = value;
    });
  }

  late final _$acessarTopicosAsyncAction =
      AsyncAction('ArtigoViewModelMobx.acessarTopicos', context: context);

  @override
  Future acessarTopicos(BuildContext context) {
    return _$acessarTopicosAsyncAction.run(() => super.acessarTopicos(context));
  }

  late final _$ArtigoViewModelMobxActionController =
      ActionController(name: 'ArtigoViewModelMobx', context: context);

  @override
  dynamic salvarDados(BuildContext context, {required Artigo artigo}) {
    final _$actionInfo = _$ArtigoViewModelMobxActionController.startAction(
        name: 'ArtigoViewModelMobx.salvarDados');
    try {
      return super.salvarDados(context, artigo: artigo);
    } finally {
      _$ArtigoViewModelMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
topicos: ${topicos}
    ''';
  }
}
