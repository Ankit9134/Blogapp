// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conta_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContaViewModel on ContaViewModelMobx, Store {
  Computed<List<Usuario>>? _$dadosUsuarioComputed;

  @override
  List<Usuario> get dadosUsuario => (_$dadosUsuarioComputed ??=
          Computed<List<Usuario>>(() => super.dadosUsuario,
              name: 'ContaViewModelMobx.dadosUsuario'))
      .value;
  Computed<List<Artigo>>? _$artigosUsuarioComputed;

  @override
  List<Artigo> get artigosUsuario => (_$artigosUsuarioComputed ??=
          Computed<List<Artigo>>(() => super.artigosUsuario,
              name: 'ContaViewModelMobx.artigosUsuario'))
      .value;
  Computed<List<Artigo>>? _$listFilteredComputed;

  @override
  List<Artigo> get listFiltered => (_$listFilteredComputed ??=
          Computed<List<Artigo>>(() => super.listFiltered,
              name: 'ContaViewModelMobx.listFiltered'))
      .value;

  late final _$_infoUserAtom =
      Atom(name: 'ContaViewModelMobx._infoUser', context: context);

  @override
  List<Usuario> get _infoUser {
    _$_infoUserAtom.reportRead();
    return super._infoUser;
  }

  @override
  set _infoUser(List<Usuario> value) {
    _$_infoUserAtom.reportWrite(value, super._infoUser, () {
      super._infoUser = value;
    });
  }

  late final _$_artigosAtom =
      Atom(name: 'ContaViewModelMobx._artigos', context: context);

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

  late final _$filterAtom =
      Atom(name: 'ContaViewModelMobx.filter', context: context);

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

  late final _$acessarDadosAsyncAction =
      AsyncAction('ContaViewModelMobx.acessarDados', context: context);

  @override
  Future acessarDados(BuildContext context) {
    return _$acessarDadosAsyncAction.run(() => super.acessarDados(context));
  }

  late final _$salvarDadosAsyncAction =
      AsyncAction('ContaViewModelMobx.salvarDados', context: context);

  @override
  Future salvarDados(BuildContext context,
      {String? nome, dynamic sobre, dynamic profilePic}) {
    return _$salvarDadosAsyncAction.run(() => super.salvarDados(context,
        nome: nome, sobre: sobre, profilePic: profilePic));
  }

  late final _$acessarQuantidadeArtigosAsyncAction = AsyncAction(
      'ContaViewModelMobx.acessarQuantidadeArtigos',
      context: context);

  @override
  Future acessarQuantidadeArtigos(BuildContext context, {String? idUsuario}) {
    return _$acessarQuantidadeArtigosAsyncAction.run(
        () => super.acessarQuantidadeArtigos(context, idUsuario: idUsuario));
  }

  late final _$excluirArtigoAsyncAction =
      AsyncAction('ContaViewModelMobx.excluirArtigo', context: context);

  @override
  Future excluirArtigo(
      {required String collection,
      required String idDoc,
      required BuildContext context}) {
    return _$excluirArtigoAsyncAction.run(() => super
        .excluirArtigo(collection: collection, idDoc: idDoc, context: context));
  }

  late final _$ContaViewModelMobxActionController =
      ActionController(name: 'ContaViewModelMobx', context: context);

  @override
  dynamic setFilter(String value) {
    final _$actionInfo = _$ContaViewModelMobxActionController.startAction(
        name: 'ContaViewModelMobx.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$ContaViewModelMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filter: ${filter},
dadosUsuario: ${dadosUsuario},
artigosUsuario: ${artigosUsuario},
listFiltered: ${listFiltered}
    ''';
  }
}
