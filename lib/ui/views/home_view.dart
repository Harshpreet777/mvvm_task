import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_task_demo/core/constants/color_constants.dart';
import 'package:mvvm_task_demo/core/constants/image_constants.dart';
import 'package:mvvm_task_demo/core/constants/string_constants.dart';
import 'package:mvvm_task_demo/core/enums/viewstate.dart';
import 'package:mvvm_task_demo/core/viewmodels/home_view_model.dart';
import 'package:mvvm_task_demo/ui/views/base_view.dart';
import 'package:mvvm_task_demo/ui/views/detail_view.dart';
import 'package:mvvm_task_demo/ui/widgets/common_text.dart';
import 'package:mvvm_task_demo/ui/widgets/common_textform_field.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  HomeViewModel? model;
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool isFinish = true;

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(onModelReady: (model) {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          page++;
          isFinish = false;
          model.getUserDetails(context, page);
        }
      });
      this.model = model;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        model.getUserDetails(context, page);
      });
    }, builder: (context, model, child) {
      return scaffold(context, model);
    });
  }

  Scaffold scaffold(BuildContext context, HomeViewModel model) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageConstant.backgroundImage),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            size: 30,
                            color: ColorConstants.black,
                          )),
                      TextWidget(
                        alignmentGeometry: Alignment.centerLeft,
                        text: StringConstants.homeTitle,
                        size: 22,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.blueb432C81,
                      ),
                      Image.asset(ImageConstant.avatarImg, fit: BoxFit.contain),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 125),
                  child: TextFormFieldWidget(
                    name: StringConstants.hintText,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.close),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextWidget(
                alignmentGeometry: Alignment.centerLeft,
                fontWeight: FontWeight.w500,
                text: StringConstants.category,
                size: 22,
                color: ColorConstants.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: StringConstants.seeMore,
                      style:
                          TextStyle(color: ColorConstants.black, fontSize: 15)),
                  const WidgetSpan(
                      child: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                  ))
                ])),
              ),
            ),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: categoryList(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextWidget(
                alignmentGeometry: Alignment.centerLeft,
                fontWeight: FontWeight.w500,
                text: StringConstants.popularDoctor,
                size: 22,
                color: ColorConstants.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: StringConstants.seeMore,
                      style:
                          TextStyle(color: ColorConstants.black, fontSize: 15)),
                  const WidgetSpan(
                      child: Icon(
                    Icons.arrow_downward,
                    size: 17,
                  ))
                ])),
              ),
            ),
            model.state == ViewState.busy
                ? const CircularProgressIndicator()
                : popularDoctorList(model)
          ],
        ),
      ),
    );
  }

  ListView popularDoctorList(HomeViewModel model) {
    return ListView.builder(
      physics: const PageScrollPhysics(),
      shrinkWrap: true,
      itemCount: model.data.length + 1,
      itemBuilder: (context, index) {
        if (index < model.data.length) {
          final list = model.data[index];
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailView(
                            id: list.id,
                            avatar: list.avatar,
                            email: list.email,
                            firstName: list.firstName,
                            lastName: list.lastName),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [ColorConstants.grey, ColorConstants.white])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: 160,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(list.avatar),
                              fit: BoxFit.cover),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextWidget(
                              alignmentGeometry: Alignment.center,
                              text: "${list.firstName} ${list.lastName}",
                              color: ColorConstants.black,
                              fontWeight: FontWeight.w500,
                              size: 18,
                            ),
                          ),
                          TextWidget(
                            alignmentGeometry: Alignment.center,
                            text: StringConstants.dentist,
                            size: 16,
                            fontWeight: FontWeight.w400,
                            color: ColorConstants.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          );
        } else {
          return isFinish
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TextWidget(
                  text: StringConstants.noData,
                  alignmentGeometry: Alignment.center,
                  size: 20,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.black,
                );
        }
      },
    );
  }

  ListView categoryList() {
    return ListView.builder(
      itemCount: ImageConstant.imageList.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 100,
            width: 90,
            decoration: BoxDecoration(
                color: ColorConstants.colorList[index],
                borderRadius: const BorderRadius.all(Radius.circular(17))),
            child: Image.asset(
              ImageConstant.imageList[index] ?? ImageConstant.user,
            ),
          ),
        );
      },
    );
  }
}
