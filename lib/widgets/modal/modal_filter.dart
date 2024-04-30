import 'package:budgetin/widgets/modal/budgetin_modal.dart';
import 'package:budgetin/widgets/reusable/title_modal.dart';
import 'package:flutter/material.dart';

Future<void> showModalFilter(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return BudgetinModal(
          title: TitleModal(title: 'Filter Search'),
          content: SizedBox(
            child: Text('Test'),
          ),
          actions: Container()
          // Taruh Disini Untuk Tombolnya

          );
    },
  );
}
