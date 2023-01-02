import 'package:flutter/material.dart';

mixin AutoCompleteMixin {
  Widget fieldViewBuilder(
          BuildContext context,
          TextEditingController controller,
          FocusNode focusNode,
          void Function() onFieldSubmitted) =>
      TextFormField();
}
