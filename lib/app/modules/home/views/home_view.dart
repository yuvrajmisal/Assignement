import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helper/responsive_ui.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: _customText("RoboFriends", ResponsiveUI().fontSize(5.5),
            Colors.white, FontWeight.bold),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        elevation: 5.0,
        // toolbarHeight: ResponsiveUI().height(8),
        // titleSpacing: ResponsiveUI().width(7.4),
      ),
      body: SafeArea(
        child: Container(
            height: Get.height, width: Get.width, child: _buildView()),
      ),
    );
  }

  _buildView() {
    return Obx(() => controller.init.value
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  ResponsiveUI().height(2),
                  ResponsiveUI().height(2),
                  ResponsiveUI().height(2),
                  ResponsiveUI().height(.1),
                ),
                child: _searchView(),
              ),
              SizedBox(
                height: ResponsiveUI().height(0.3),
              ),
              Flexible(
                child: _buildGridView(),
              ),
            ],
          )
        : _noDataView());
  }

  _searchView() {
    return TextFormField(
      controller: controller.searchTEC,
      focusNode: controller.searchFN,
      maxLines: 1,
      onFieldSubmitted: controller.onChanged,
      onChanged: controller.onChanged,
      maxLength: 15,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      decoration: new InputDecoration(
        hintText: "Search Robo Friends",
        labelText: "Search Robo Friends",
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: ResponsiveUI().fontSize(6),
          letterSpacing: 0.5,
        ),
        counterStyle: TextStyle(
          height: double.minPositive,
        ),
        counterText: "",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: ResponsiveUI().fontSize(5),
          letterSpacing: 0.4,
        ),
        errorStyle: TextStyle(
          color: Colors.redAccent,
          fontSize: ResponsiveUI().fontSize(4),
          letterSpacing: 1.2,
        ),
        contentPadding: EdgeInsets.only(
            right: ResponsiveUI().width(2),
            left: ResponsiveUI().width(2),
            top: ResponsiveUI().height(1.5),
            bottom: ResponsiveUI().height(0.1)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(width: 3, color: Colors.blueGrey),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }

  _buildGridView() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        ResponsiveUI().height(2),
        ResponsiveUI().height(3),
        ResponsiveUI().height(2),
        ResponsiveUI().height(2),
      ),
      child: Obx(
        () => (controller.usersFilter.isEmpty) ? _noDataView() : _gridView(),
      ),
    );
  }

  _noDataView() {
    return Center(
      child: Text(
        "No data found.",
        style: TextStyle(
          color: Colors.black87,
          fontSize: ResponsiveUI().fontSize(3.9),
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
          overflow: TextOverflow.visible,
        ),
        maxLines: 3,
        softWrap: true,
      ),
    );
  }

  _gridView() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      // cacheExtent: 0.1,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 2 / 2, //2 / 2,
        crossAxisSpacing: ResponsiveUI().height(0.5),
        mainAxisSpacing: ResponsiveUI().height(4),
        maxCrossAxisExtent: ResponsiveUI().height(29),
      ),
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   crossAxisSpacing: ResponsiveUI().height(0.5),
      //   mainAxisSpacing: ResponsiveUI().height(3),
      // ),
      itemCount: controller.usersFilter.length,
      itemBuilder: (BuildContext ctx, index) {
        return _gridRow(index);
      },
    );
  }

  _gridRow(int index) {
    Color color =
        controller.checkFavorite(index) ? Colors.teal : Colors.blueGrey;
    return InkWell(
      onTap: () {
        controller.onGridItemTap(index);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
          color: color,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withAlpha(40),
              blurRadius: 10.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
            ),
            BoxShadow(
              color: color.withAlpha(40),
              spreadRadius: -4,
              blurRadius: 10,
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.2),
              color.withOpacity(0.4),
              color.withOpacity(0.6),
              color.withOpacity(0.8),
              color.withOpacity(0.9),
              color,
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: _stackView(index),
      ),
    );
  }

  _stackView(int index) {
    return Stack(
      fit: StackFit.loose,
      children: [
        _columnWithImage(index),
        Positioned(
          top: ResponsiveUI().height(0.5),
          right: ResponsiveUI().width(1.5),
          child: _favButtonView(index),
        ),
      ],
    );
  }

  _favButtonView(int index) {
    bool fav = controller.checkFavorite(index);
    return InkWell(
      onTap: () {
        controller.onFavTap(index);
      },
      child: Icon(
        fav ? Icons.favorite : Icons.favorite_border_sharp,
        size: ResponsiveUI().width(6.5),
        color: fav ? Colors.orangeAccent : Colors.orangeAccent,
      ),
    );
  }

  _columnWithImage(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: ResponsiveUI().height(0.3),
        ),
        Expanded(
          child: CachedNetworkImage(
            imageUrl:
                "https://robohash.org/${controller.usersFilter[index].id}?200x200",
            fit: BoxFit.contain,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            ),
            errorWidget: (context, url, error) => Center(
              child: Icon(
                Icons.warning_amber_sharp,
                size: ResponsiveUI().width(15),
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
        SizedBox(
          height: ResponsiveUI().height(1),
        ),
        _customText(controller.getName(index), ResponsiveUI().fontSize(4.2),
            Colors.black, FontWeight.bold),
        SizedBox(
          height: ResponsiveUI().height(0.5),
        ),
        _customText(controller.getEmail(index), ResponsiveUI().fontSize(4),
            Colors.black, FontWeight.w400),
        SizedBox(
          height: ResponsiveUI().height(0.5),
        ),
      ],
    );
  }

  _customText(
      String name, double fontSize, Color color, FontWeight fontWeight) {
    return Container(
      padding: EdgeInsets.only(
        left: ResponsiveUI().width(3),
        right: ResponsiveUI().width(2),
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: 1.2,
          overflow: TextOverflow.visible,
        ),
        maxLines: 2,
        softWrap: true,
      ),
    );
  }
}
