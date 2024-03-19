import 'package:flutter/foundation.dart';

import '../models/user.dart';

class MyState with ChangeNotifier{
  mUser user = mUser(id: 'id');
  bool isChanged = false;


  getUser(mUser u){
    print(u.id);
    print(user.id);
    user = u;
    notifyListeners();
  }
  void updateState() {
    isChanged = !isChanged;
    notifyListeners(); // Thông báo cho các widget nghe để rebuild
  }
}
