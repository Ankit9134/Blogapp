// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inicio_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InicioViewModel on InicioViewModelMobx, Store {
  Computed<List<Artigo>>? _$artigosPopularesComputed;

  @override
  List<Artigo> get artigosPopulares => (_$artigosPopularesComputed ??=
          Computed<List<Artigo>>(() => super.artigosPopulares,
              name: 'InicioViewModelMobx.artigosPopulares'))
      .value;
  Computed<List<Artigo>>? _$artigosEmAltaComputed;

  @override
  List<Artigo> get artigosEmAlta => (_$artigosEmAltaComputed ??=
          Computed<List<Artigo>>(() => super.artigosEmAlta,
              name: 'InicioViewModelMobx.artigosEmAlta'))
      .value;

  late final _$_popularesAtom =
      Atom(name: 'InicioViewModelMobx._populares', context: context);

  @override
  List<Artigo> get _populares {
    _$_popularesAtom.reportRead();
    return super._populares;
  }

  @override
  set _populares(List<Artigo> value) {
    _$_popularesAtom.reportWrite(value, super._populares, () {
      super._populares = value;
    });
  }

  late final _$_emAltaAtom =
      Atom(name: 'InicioViewModelMobx._emAlta', context: context);

  @override
  List<Artigo> get _emAlta {
    _$_emAltaAtom.reportRead();
    return super._emAlta;
  }

  @override
  set _emAlta(List<Artigo> value) {
    _$_emAltaAtom.reportWrite(value, super._emAlta, () {
      super._emAlta = value;
    });
  }

  late final _$_artigosPorTopicosAtom =
      Atom(name: 'InicioViewModelMobx._artigosPorTopicos', context: context);

  @override
  List<List<Artigo>> get _artigosPorTopicos {
    _$_artigosPorTopicosAtom.reportRead();
    return super._artigosPorTopicos;
  }

  @override
  set _artigosPorTopicos(List<List<Artigo>> value) {
    _$_artigosPorTopicosAtom.reportWrite(value, super._artigosPorTopicos, () {
      super._artigosPorTopicos = value;
    });
  }

  late final _$recuperarArtigosPopularesAsyncAction = AsyncAction(
      'InicioViewModelMobx.recuperarArtigosPopulares',
      context: context);

  @override
  Future recuperarArtigosPopulares(BuildContext context) {
    return _$recuperarArtigosPopularesAsyncAction
        .run(() => super.recuperarArtigosPopulares(context));
  }

  late final _$recuperarArtigosEmAltaAsyncAction = AsyncAction(
      'InicioViewModelMobx.recuperarArtigosEmAlta',
      context: context);

  @override
  Future recuperarArtigosEmAlta(BuildContext context) {
    return _$recuperarArtigosEmAltaAsyncAction
        .run(() => super.recuperarArtigosEmAlta(context));
  }

  late final _$recuperarArtigosTopicoAsyncAction = AsyncAction(
      'InicioViewModelMobx.recuperarArtigosTopico',
      context: context);

  @override
  Future recuperarArtigosTopico(BuildContext context) {
    return _$recuperarArtigosTopicoAsyncAction
        .run(() => super.recuperarArtigosTopico(context));
  }

  late final _$recuperarArtigoPorTopicoEspecificoAsyncAction = AsyncAction(
      'InicioViewModelMobx.recuperarArtigoPorTopicoEspecifico',
      context: context);

  @override
  Future recuperarArtigoPorTopicoEspecifico(BuildContext context) {
    return _$recuperarArtigoPorTopicoEspecificoAsyncAction
        .run(() => super.recuperarArtigoPorTopicoEspecifico(context));
  }

  @override
  String toString() {
    return '''
artigosPopulares: ${artigosPopulares},
artigosEmAlta: ${artigosEmAlta}
    ''';
  }
}
