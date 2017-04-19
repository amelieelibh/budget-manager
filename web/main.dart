// Copyright (c) 2017, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/platform/browser.dart';

import 'package:BudgetManager/app_component.dart';

import 'package:modal_dialog/core.dart';


void main() {

  /*ModalDialog dialog = new ModalConfirm('Delete record', 'Are you sure?',
      accept: (ModalDialog dialog) {
    print('deleting record...');
    dialog.close();
  });
  dialog.open();*/
  bootstrap(AppComponent);
}