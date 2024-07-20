// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ver_usuario_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VerUsuarioViewModel on VerUsuarioViewModelMobx, Store {
  Computed<List<Usuario>>? _$infoUserComputed;

  @override
  List<Usuario> get infoUser =>
      (_$infoUserComputed ??= Computed<List<Usuario>>(() => super.infoUser,
              name: 'VerUsuarioViewModelMobx.infoUser'))
          .value;
  Computed<List<Artigo>>? _$artigosComputed;

  @override
  List<Artigo> get artigos =>
      (_$artigosComputed ??= Computed<List<Artigo>>(() => super.artigos,
              name: 'VerUsuarioViewModelMobx.artigos'))
          .value;
  Computed<bool>? _$seguidoComputed;

  @override
  bool get seguido => (_$seguidoComputed ??= Computed<bool>(() => super.seguido,
          name: 'VerUsuarioViewModelMobx.seguido'))
      .value;

  late final _$_infoUserAtom =
      Atom(name: 'VerUsuarioViewModelMobx._infoUser', context: context);

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
      Atom(name: 'VerUsuarioViewModelMobx._artigos', context: context);

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

  late final _$_seguidoAtom =
      Atom(name: 'VerUsuarioViewModelMobx._seguido', context: context);

  @override
  bool get _seguido {
    _$_seguidoAtom.reportRead();
    return super._seguido;
  }

  @override
  set _seguido(bool value) {
    _$_seguidoAtom.reportWrite(value, super._seguido, () {
      super._seguido = value;
    });
  }

  late final _$recuperarInfoUsuarioAsyncAction = AsyncAction(
      'VerUsuarioViewModelMobx.recuperarInfoUsuario',
      context: context);

  @override
  Future recuperarInfoUsuario(BuildContext context, String idUsuario) {
    return _$recuperarInfoUsuarioAsyncAction
        .run(() => super.recuperarInfoUsuario(context, idUsuario));
  }

  late final _$recuperarArtigosAsyncAction =
      AsyncAction('VerUsuarioViewModelMobx.recuperarArtigos', context: context);

  @override
  Future recuperarArtigos(BuildContext context, String idUsuario) {
    return _$recuperarArtigosAsyncAction
        .run(() => super.recuperarArtigos(context, idUsuario));
  }

  late final _$VerUsuarioViewModelMobxActionController =
      ActionController(name: 'VerUsuarioViewModelMobx', context: context);

  @override
  dynamic seguir(
      {required String idUsuario,
      required String idUsuarioSeguido,
      required BuildContext context}) {
    final _$actionInfo = _$VerUsuarioViewModelMobxActionController.startAction(
        name: 'VerUsuarioViewModelMobx.seguir');
    try {
      return super.seguir(
          idUsuario: idUsuario,
          idUsuarioSeguido: idUsuarioSeguido,
          context: context);
    } finally {
      _$VerUsuarioViewModelMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
infoUser: ${infoUser},
artigos: ${artigos},
seguido: ${seguido}
    ''';
  }
}
