import 'dart:math';

sealed class GeradorId{

  static String gerarId(){

    List<String> _id = [];
    String _idFinal = '';

    const List<String> _alfabetoMIN = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
    const List<String> _alfabetoMax = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

    for(int i = 0; i < 28; i++){
       int letraNumero = Random().nextInt(2);
       if(letraNumero == 0){
         //número
         int num = Random().nextInt(10);
         _id.add(num.toString());
       } else {
         //letra
         int minMax = Random().nextInt(2);
         if(minMax==0){
           int min = Random().nextInt(_alfabetoMIN.length);
           _id.add(_alfabetoMIN[min]);
         } else {
           int max = Random().nextInt(_alfabetoMax.length);
           _id.add(_alfabetoMax[max]);
         }
       }
    }

    for(int x = 0; x < _id.length; x++){
      if(x==0){
        _idFinal = _id[x];
      }else{
        _idFinal = _idFinal+_id[x];
      }
    }

    return _idFinal;

  }

}