// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salvo_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SalvoViewModel on SalvoViewModelMobx, Store {
  Computed<List<Artigo>>? _$artigosSalvosComputed;

  @override
  List<Artigo> get artigosSalvos => (_$artigosSalvosComputed ??=
          Computed<List<Artigo>>(() => super.artigosSalvos,
              name: 'SalvoViewModelMobx.artigosSalvos'))
      .value;
  Computed<bool>? _$artigoEstaSalvoComputed;

  @override
  bool get artigoEstaSalvo =>
      (_$artigoEstaSalvoComputed ??= Computed<bool>(() => super.artigoEstaSalvo,
              name: 'SalvoViewModelMobx.artigoEstaSalvo'))
          .value;
  Computed<List<Artigo>>? _$listFilteredComputed;

  @override
  List<Artigo> get listFiltered => (_$listFilteredComputed ??=
          Computed<List<Artigo>>(() => super.listFiltered,
              name: 'SalvoViewModelMobx.listFiltered'))
      .value;

  late final _$_artigosSalvosAtom =
      Atom(name: 'SalvoViewModelMobx._artigosSalvos', context: context);

  @override
  List<Artigo> get _artigosSalvos {
    _$_artigosSalvosAtom.reportRead();
    return super._artigosSalvos;
  }

  @override
  set _artigosSalvos(List<Artigo> value) {
    _$_artigosSalvosAtom.reportWrite(value, super._artigosSalvos, () {
      super._artigosSalvos = value;
    });
  }

  late final _$_artigoEstaSalvoAtom =
      Atom(name: 'SalvoViewModelMobx._artigoEstaSalvo', context: context);

  @override
  bool get _artigoEstaSalvo {
    _$_artigoEstaSalvoAtom.reportRead();
    return super._artigoEstaSalvo;
  }

  @override
  set _artigoEstaSalvo(bool value) {
    _$_artigoEstaSalvoAtom.reportWrite(value, super._artigoEstaSalvo, () {
      super._artigoEstaSalvo = value;
    });
  }

  late final _$filterAtom =
      Atom(name: 'SalvoViewModelMobx.filter', context: context);

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

  late final _$recuperarArtigosSalvosAsyncAction = AsyncAction(
      'SalvoViewModelMobx.recuperarArtigosSalvos',
      context: context);

  @override
  Future recuperarArtigosSalvos(BuildContext context) {
    return _$recuperarArtigosSalvosAsyncAction
        .run(() => super.recuperarArtigosSalvos(context));
  }

  late final _$retirarArtigoSalvoAsyncAction =
      AsyncAction('SalvoViewModelMobx.retirarArtigoSalvo', context: context);

  @override
  Future retirarArtigoSalvo(BuildContext context, {required Artigo artigo}) {
    return _$retirarArtigoSalvoAsyncAction
        .run(() => super.retirarArtigoSalvo(context, artigo: artigo));
  }

  late final _$SalvoViewModelMobxActionController =
      ActionController(name: 'SalvoViewModelMobx', context: context);

  @override
  dynamic setFilter(String value) {
    final _$actionInfo = _$SalvoViewModelMobxActionController.startAction(
        name: 'SalvoViewModelMobx.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$SalvoViewModelMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic salvarArtigo(BuildContext context, {required Artigo artigo}) {
    final _$actionInfo = _$SalvoViewModelMobxActionController.startAction(
        name: 'SalvoViewModelMobx.salvarArtigo');
    try {
      return super.salvarArtigo(context, artigo: artigo);
    } finally {
      _$SalvoViewModelMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic aArtigoSalvo(BuildContext context, Artigo artigo) {
    final _$actionInfo = _$SalvoViewModelMobxActionController.startAction(
        name: 'SalvoViewModelMobx.aArtigoSalvo');
    try {
      return super.aArtigoSalvo(context, artigo);
    } finally {
      _$SalvoViewModelMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filter: ${filter},
artigosSalvos: ${artigosSalvos},
artigoEstaSalvo: ${artigoEstaSalvo},
listFiltered: ${listFiltered}
    ''';
  }
}
