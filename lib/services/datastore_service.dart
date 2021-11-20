import 'package:amplify_flutter/amplify.dart';
import '/models/ModelProvider.dart';

class DataStoreService {
  Future<void> saveUser(User user) async {
    try {
      print('DataStore Save');
      //await Amplify.DataStore.clear();
      await Amplify.DataStore.save(user);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<User?> getUser(String userId) async {
    try {
      List<User> user = await Amplify.DataStore.query(User.classType,
          where: User.ID.eq(userId));
      if (user.length > 0) {
        return user.first;
      } else
        print('null');
      return null;
    } catch (e) {
      throw e;
    }
  }
}
