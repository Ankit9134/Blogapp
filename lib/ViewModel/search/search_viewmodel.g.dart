// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchViewModel on SearchViewModelMobx, Store {
  Computed<List<Artigo>>? _$artigosComputed;

  @override
  List<Artigo> get artigos =>
      (_$artigosComputed ??= Computed<List<Artigo>>(() => super.artigos,
              name: 'SearchViewModelMobx.artigos'))
          .value;
  Computed<List<String>>? _$topicosComputed;

  @override
  List<String> get topicos =>
      (_$topicosComputed ??= Computed<List<String>>(() => super.topicos,
              name: 'SearchViewModelMobx.topicos'))
          .value;
  Computed<List<Artigo>>? _$listFilteredComputed;

  @override
  List<Artigo> get listFiltered => (_$listFilteredComputed ??=
          Computed<List<Artigo>>(() => super.listFiltered,
              name: 'SearchViewModelMobx.listFiltered'))
      .value;
  Computed<List<String>>? _$listTopicFilteredComputed;

  @override
  List<String> get listTopicFiltered => (_$listTopicFilteredComputed ??=
          Computed<List<String>>(() => super.listTopicFiltered,
              name: 'SearchViewModelMobx.listTopicFiltered'))
      .value;
  Computed<bool>? _$artigosFiltradosPorTopicoComputed;

  @override
  bool get artigosFiltradosPorTopico => (_$artigosFiltradosPorTopicoComputed ??=
          Computed<bool>(() => super.artigosFiltradosPorTopico,
              name: 'SearchViewModelMobx.artigosFiltradosPorTopico'))
      .value;
  Computed<String>? _$topicoSelecionadoComputed;

  @override
  String get topicoSelecionado => (_$topicoSelecionadoComputed ??=
          Computed<String>(() => super.topicoSelecionado,
              name: 'SearchViewModelMobx.topicoSelecionado'))
      .value;

  late final _$_artigosAtom =
      Atom(name: 'SearchViewModelMobx._artigos', context: context);

  @override
  List<Artigo> get _artigos {
    _$_artigosAtom.reportRead();
    return super._artigos;
  }

  @override
  set _artigos(List<Artigo> value) {
    _$_artigosAtom.reportWrite(value, super._artigos, () {
      super._artigos = value;
    });
  }

  late final _$_topicosAtom =
      Atom(name: 'SearchViewModelMobx._topicos', context: context);

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

  late final _$filterAtom =
      Atom(name: 'SearchViewModelMobx.filter', context: context);

  @override
  String get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(String value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  late final _$filterTopicAtom =
      Atom(name: 'SearchViewModelMobx.filterTopic', context: context);

  @override
  String get filterTopic {
    _$filterTopicAtom.reportRead();
    return super.filterTopic;
  }

  @override
  set filterTopic(String value) {
    _$filterTopicAtom.reportWrite(value, super.filterTopic, () {
      super.filterTopic = value;
    });
  }

  late final _$_artigosFiltradosPorTopicoAtom = Atom(
      name: 'SearchViewModelMobx._artigosFiltradosPorTopico', context: context);

  @override
  bool get _artigosFiltradosPorTopico {
    _$_artigosFiltradosPorTopicoAtom.reportRead();
    return super._artigosFiltradosPorTopico;
  }

  @override
  set _artigosFiltradosPorTopico(bool value) {
    _$_artigosFiltradosPorTopicoAtom
        .reportWrite(value, super._artigosFiltradosPorTopico, () {
      super._artigosFiltradosPorTopico = value;
    });
  }

  late final _$_topicoSelecionadoAtom =
      Atom(name: 'SearchViewModelMobx._topicoSelecionado', context: context);

  @override
  String get _topicoSelecionado {
    _$_topicoSelecionadoAtom.reportRead();
    return super._topicoSelecionado;
  }

  @override
  set _topicoSelecionado(String value) {
    _$_topicoSelecionadoAtom.reportWrite(value, super._topicoSelecionado, () {
      super._topicoSelecionado = value;
    });
  }

  late final _$recuperarDadosAsyncAction =
      AsyncAction('SearchViewModelMobx.recuperarDados', context: context);

  @override
  Future recuperarDados(BuildContext context) {
    return _$recuperarDadosAsyncAction.run(() => super.recuperarDados(context));
  }

  late final _$recuperarTopicosAsyncAction =
      AsyncAction('SearchViewModelMobx.recuperarTopicos', context: context);

  @override
  Future recuperarTopicos(BuildContext context) {
    return _$recuperarTopicosAsyncAction
        .run(() => super.recuperarTopicos(context));
  }

  late final _$SearchViewModelMobxActionController =
      ActionController(name: 'SearchViewModelMobx', context: context);

  @override
  dynamic setFilter(String value) {
    final _$actionInfo = _$SearchViewModelMobxActionController.startAction(
        name: 'SearchViewModelMobx.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$SearchViewModelMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTopicFilter(String value) {
    final _$actionInfo = _$SearchViewModelMobxActionController.startAction(
        name: 'SearchViewModelMobx.setTopicFilter');
    try {
      return super.setTopicFilter(value);
    } finally {
      _$SearchViewModelMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBoolTopico(String topico) {
    final _$actionInfo = _$SearchViewModelMobxActionController.startAction(
        name: 'SearchViewModelMobx.setBoolTopico');
    try {
      return super.setBoolTopico(topico);
    } finally {
      _$SearchViewModelMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic limparFiltro() {
    final _$actionInfo = _$SearchViewModelMobxActionController.startAction(
        name: 'SearchViewModelMobx.limparFiltro');
    try {
      return super.limparFiltro();
    } finally {
      _$SearchViewModelMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filter: ${filter},
filterTopic: ${filterTopic},
artigos: ${artigos},
topicos: ${topicos},
listFiltered: ${listFiltered},
listTopicFiltered: ${listTopicFiltered},
artigosFiltradosPorTopico: ${artigosFiltradosPorTopico},
topicoSelecionado: ${topicoSelecionado}
    ''';
  }
}
