import 'package:i_love_pao/model/backer.dart';
import 'package:i_love_pao/model/address.dart';

class backerListMock {

  List<Backer> _list = new List<Backer>();

  List<Backer> getList(){

    Address addr = new Address();
    addr.city = 'Florianópolis';
    addr.district = 'Centro';

    Backer bk1 = new Backer('Padaria Santa Gula', 'images/backer_0001.jpg', 'images/fundo_0001.jpg', addr);
    _list.add(bk1);

    Backer bk2 = new Backer('O Padeiro de Sevilha', 'images/backer_0004.jpg', 'images/fundo_0004.jpg',addr);
    _list.add(bk2);

    Backer bk3 = new Backer('Padoka', 'images/backer_0005.jpg', 'images/fundo_0005.png', addr);
    _list.add(bk3);

    Backer bk4 = new Backer('Lombardo Pão Italiano', 'images/backer_0003.jpg', 'images/fundo_0003.jpg',addr);
    _list.add(bk4);

    Backer bk5 = new Backer('Padaria Cafè François', 'images/backer_0002.jpg', 'images/fundo_0002.jpg',addr);
    _list.add(bk5);

    Backer bk6 = new Backer('Floripão', 'images/backer_0006.jpg', 'images/fundo_0006.jpg',addr);
    _list.add(bk6);

    return _list;
  }
}