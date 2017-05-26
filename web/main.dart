// Copyright (c) 2017, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:mirrors' hide Comment;
import 'package:angular2/platform/browser.dart';

import 'package:BudgetManager/app_component.dart';

import 'package:modal_dialog/core.dart';

import 'package:ng_bootstrap/ng_bootstrap.dart';

/*// show you log-infos in the console
import 'package:logging/logging.dart';
import 'package:console_log_handler/console_log_handler.dart';

import 'package:mdl/mdl.dart';
*/
void main() {
  /*ModalDialog dialog = new ModalConfirm('Delete record', 'Are you sure?',
      accept: (ModalDialog dialog) {
    print('deleting record...');
    dialog.close();
  });
  dialog.open();*/
  bootstrap(AppComponent);
}