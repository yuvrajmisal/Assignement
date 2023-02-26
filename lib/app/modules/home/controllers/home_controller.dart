import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robofriends/app/data/api/sample_api.dart';
import 'package:robofriends/app/data/model/user_model.dart';

import '../../../helper/easy_loading_helper.dart';
import '../../../helper/snackbar_helper.dart';

class HomeController extends GetxController {
  final init = false.obs;

  TextEditingController searchTEC = TextEditingController();
  FocusNode searchFN = FocusNode();

  final users = <Users>[].obs;
  final usersFilter = <Users>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await _fetchUsers();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  _fetchUsers() async {
    var response = await SampleApi.getUsers(onTry: () {});
    init.value = true;
    if (response != null &&
        response.error != null &&
        response.error!.isNotEmpty) {
      SnackbarHelper.showError(
          "Error", "Users API Error - ${response.error}", "Close", true, () {});
      EasyLoadingHelper.hideLoader();
      return;
    } else {
      var userList = usersFromJson(response.response!);
      users.assignAll(userList);
      usersFilter.assignAll(userList);
    }
  }

  String getName(index) {
    String name = "NA";
    String? name1 = usersFilter[index].name;
    if (name1 != null) {
      name = name1;
    }
    return name;
  }

  String getEmail(index) {
    String email = "NA";
    String? name1 = usersFilter[index].email;
    if (name1 != null) {
      email = name1;
    }
    return email;
  }

  bool checkFavorite(index) {
    bool fav = false;
    RxBool? favorite = usersFilter[index].favorite;
    if (favorite != null) {
      fav = favorite.value;
    }
    return fav;
  }

  onChanged(String value) {
    // searchFN.unfocus();
    if (value.isEmpty) {
      usersFilter.assignAll(users);
    } else {
      usersFilter.clear();
      List<Users> alist = [];
      users.forEach((element) {
        if (element.name != null &&
            element.name!.isNotEmpty &&
            element.name!.toLowerCase().contains(value.toLowerCase())) {
          alist.add(element);
        }
      });
      usersFilter.assignAll(alist);
    }
  }

  onFavTap(int index) {
    searchFN.unfocus();
    var favorite = usersFilter[index].favorite;
    if (favorite != null) {
      favorite.value = !favorite.value;
    }
    usersFilter.refresh();
  }

  onGridItemTap(int index) {
    searchFN.unfocus();
  }
}
