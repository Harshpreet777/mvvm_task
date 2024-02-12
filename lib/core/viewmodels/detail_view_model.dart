import 'package:flutter/material.dart';
import 'package:mvvm_task_demo/core/viewmodels/base_model.dart';

class DetailViewModel extends BaseModel {
  bool isPress=false;
  buttonColorChn(BuildContext context) {
    updateUI();
    if (isPress = true) {
      isPress = false;
    }
    else{
      isPress=true;
    }
    isPress = !isPress;
  }
}
