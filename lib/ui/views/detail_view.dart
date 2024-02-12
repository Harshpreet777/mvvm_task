import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_task_demo/core/constants/color_constants.dart';
import 'package:mvvm_task_demo/core/constants/image_constants.dart';
import 'package:mvvm_task_demo/core/constants/string_constants.dart';
import 'package:mvvm_task_demo/core/models/user_list_response_model.dart';
import 'package:mvvm_task_demo/core/viewmodels/detail_view_model.dart';
import 'package:mvvm_task_demo/ui/views/base_view.dart';
import 'package:mvvm_task_demo/ui/widgets/common_elevated_button.dart';
import 'package:mvvm_task_demo/ui/widgets/common_text.dart';

// ignore: must_be_immutable
class DetailView extends StatelessWidget {
  DetailView({
    super.key,
     this.name,
  
  });
  UserListResponseModel? name;

  int buttonInd = 0;

  DetailViewModel model = DetailViewModel();
  @override
  Widget build(BuildContext context) {
    return BaseView<DetailViewModel>(onModelReady: (model) {
      this.model = model;
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      //   model.buttonColorChn();
      // });
    }, builder: (BuildContext context, DetailViewModel model, Widget? child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              detailStack(context),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: 160,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: name?.avatar != null
                                  ? NetworkImage('${name?.avatar}')
                                  : NetworkImage(ImageConstant.user),
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
                              text: "${name?.firstName} ${name?.lastName}",
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              height: 30,
                              child: starList(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: dayList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: ElevatedBtnWidget(
                    color: ColorConstants.blueb432C81,
                    name: StringConstants.btn1,
                    textColor: ColorConstants.white),
              ),
              TextWidget(
                alignmentGeometry: Alignment.center,
                text: StringConstants.or,
                size: 16,
                fontWeight: FontWeight.w400,
                color: ColorConstants.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: ElevatedBtnWidget(
                    borderSide: const BorderSide(color: Colors.black),
                    color: ColorConstants.white,
                    name: StringConstants.btn2,
                    textColor: ColorConstants.black),
              ),
            ],
          ),
        ),
      );
    });
  }

  ListView starList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return const Icon(
          Icons.star,
          color: Colors.yellow,
        );
      },
    );
  }

  ListView dayList() {
    return ListView.builder(
      itemCount: StringConstants.day.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            buttonInd = index;
            model.buttonColorChn();
            log('${model.isPress}');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                width: 160,
                height: 50,
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    color: buttonInd == index
                        ? model.isPress
                            ? ColorConstants.blueb432C81
                            : ColorConstants.white
                        : ColorConstants.white,
                    border: Border.all(color: Colors.black38),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: [
                    Text(
                      StringConstants.day[index],
                      style: TextStyle(
                          color: buttonInd == index
                              ? model.isPress
                                  ? ColorConstants.white
                                  : ColorConstants.black
                              : ColorConstants.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      StringConstants.available[index],
                      style: TextStyle(
                          color: buttonInd == index
                              ? model.isPress
                                  ? ColorConstants.white
                                  : ColorConstants.black
                              : ColorConstants.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  Stack detailStack(BuildContext context) {
    return Stack(
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
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    size: 30,
                    color: ColorConstants.black,
                  )),
              TextWidget(
                alignmentGeometry: Alignment.center,
                text: StringConstants.detailTitle,
                size: 22,
                fontWeight: FontWeight.w600,
                color: ColorConstants.blueb432C81,
              ),
              Image.asset(ImageConstant.avatarImg, fit: BoxFit.contain),
            ],
          ),
        ),
      ],
    );
  }
}
