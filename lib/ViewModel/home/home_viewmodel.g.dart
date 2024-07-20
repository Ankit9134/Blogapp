// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelMobx, Store {
  Computed<List<Frase>>? _$frasesComputed;

  @override
  List<Frase> get frases =>
      (_$frasesComputed ??= Computed<List<Frase>>(() => super.frases,
              name: 'HomeViewModelMobx.frases'))
          .value;
  Computed<Frase>? _$fraseSorteadaComputed;

  @override
  Frase get fraseSorteada =>
      (_$fraseSorteadaComputed ??= Computed<Frase>(() => super.fraseSorteada,
              name: 'HomeViewModelMobx.fraseSorteada'))
          .value;

  late final _$_frasesAtom =
      Atom(name: 'HomeViewModelMobx._frases', context: context);

  @override
  List<Frase> get _frases {
    _$_frasesAtom.reportRead();
    return super._frases;
  }

  @override
  set _frases(List<Frase> value) {
    _$_frasesAtom.reportWrite(value, super._frases, () {
      super._frases = value;
    });
  }

  late final _$_fraseSorteadaAtom =
      Atom(name: 'HomeViewModelMobx._fraseSorteada', context: context);

  @override
  Frase get _fraseSorteada {
    _$_fraseSorteadaAtom.reportRead();
    return super._fraseSorteada;
  }

  @override
  set _fraseSorteada(Frase value) {
    _$_fraseSorteadaAtom.reportWrite(value, super._fraseSorteada, () {
      super._fraseSorteada = value;
    });
  }

  late final _$sortearFraseAsyncAction =
      AsyncAction('HomeViewModelMobx.sortearFrase', context: context);

  @override
  Future sortearFrase(BuildContext context) {
    return _$sortearFraseAsyncAction.run(() => super.sortearFrase(context));
  }

  @override
  String toString() {
    return '''
frases: ${frases},
fraseSorteada: ${fraseSorteada}
    ''';
  }
}
