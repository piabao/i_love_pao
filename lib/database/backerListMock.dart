import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/model/address.dart';

class backerListMock {

  List<Backer> _list = new List<Backer>();

  List<Backer> getList(){

    Address addr = new Address();
    addr.city = 'Florianópolis';
    addr.district = 'Centro';

    Backer bk1 = new Backer('Padaria Santa Gula', 'images/backer_0001.jpg', 'images/fundo_0001.jpg', addr);
    bk1.overview = 'A Santíssima Gula é uma ótima opção para dar um sabor especial a todos os momentos do seu dia: café da manhã, almoço, café colonial, sopas (no inverno) e muito mais.';
    _list.add(bk1);

    Backer bk2 = new Backer('O Padeiro de Sevilha', 'images/backer_0004.jpg', 'images/fundo_0004.jpg',addr);
    bk2.overview = 'Padaria e confeitaria contemporânea, com mesa comunitária, oferece cappuccinos, brownies, sanduíches e bolos.';
    _list.add(bk2);

    Backer bk3 = new Backer('Padoka', 'images/backer_0005.jpg', 'images/fundo_0005.png', addr);
    bk3.overview = 'A Padoka é uma Tradicional padaria de Florianópolis, instalada num Casarão Açoriano de 1890 ( tombado e preservado), na charmosa esquina da Almirante Lamego com a Esteves Junior sendo que seus clientes podem usufruir do deslumbrante visual da Praça Esteves Junior e Avenida Beira Mar Norte.';
    _list.add(bk3);

    Backer bk4 = new Backer('Lombardo Pão Italiano', 'images/backer_0003.jpg', 'images/fundo_0003.jpg',addr);
    bk4.overview = 'Ao abrir as portas, em março de 1992, a Lombardo Pão Italiano tinha um foco de atuação bem definido. Produzir pães com base na arte tradicional milenar. E inovar. Nesses anos de trabalho, a empresa conquistou o respeito da clientela, da crítica, e um importante espaço no setor gastronômico da cidade. Além de produzir pães de alta qualidade, nos mais variados estilos, a casa investe no desenvolvimento de uma gastronomia para o pão. A Lombardo Pão Italiano colocou o pão no centro das boas mesas da cidade e desenvolveu deliciosos produtos para acompanhá-lo.';
    _list.add(bk4);

    Backer bk5 = new Backer('Padaria Cafè François', 'images/backer_0002.jpg', 'images/fundo_0002.jpg',addr);
    bk5.overview = 'Descubra os sabores dos pães feitos segundo a verdadeira tradição francesa da fermentação natural. Encante seu paladar com pães especiais e diferentes tipos de baguetes e ciabatas.';
    _list.add(bk5);

    Backer bk6 = new Backer('Floripão', 'images/backer_0006.jpg', 'images/fundo_0006.jpg',addr);
    bk6.overview = 'Poucos momentos na vida são tão simples e gostosos como começar o dia comendo um pãozinho quentinho e crocante acompanhado de uma boa xícara de café. Padaria e café Floripão , dispostos a servir os melhores cafés e pães da cidade ! Venha conferir nosso ambiente climatizado e confortável você também!';
    _list.add(bk6);

    return _list;
  }
}