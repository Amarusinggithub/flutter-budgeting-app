import 'package:budgetingapp/models/user_data_model.dart';
import 'package:budgetingapp/services/user_data_service.dart';
import 'package:flutter/cupertino.dart';

class UserDataProvider extends ChangeNotifier {
  UserDataModel? userDataModel;
  UserDataService userDataService;

  UserDataProvider({required this.userDataService}) {
    initialize();
  }

  Future<void> initialize() async {
    await fetchUserData();
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    UserDataModel? fetchedUserData = await userDataService.fetchUserData();
    if (userDataModel == null && fetchedUserData != null) {
      userDataModel = fetchedUserData;
    } else {
      userDataModel = UserDataModel(username: '', email: '');
    }
  }

  Future<void> updateNotificationDailyLimit() async {
    await userDataService.updateUserDataInDatabase(userDataModel!);
  }
}
