import 'package:flutter/foundation.dart';

import '../models/user.dart';

class MyState with ChangeNotifier{
  mUser user = mUser(id: 'id');
  bool _isChanged = false;
  bool get isChanged => _isChanged;

  getUser(mUser u){
    print(u.id);
    print(user.id);
    user = u;
    notifyListeners();
  }
  void updateState() {
    notifyListeners(); // Thông báo cho các widget nghe để rebuild
  }
}
