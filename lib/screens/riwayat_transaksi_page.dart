import 'dart:async';
import 'package:budgetin/main.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/providers/date_formatter.dart';
import 'package:budgetin/screens/detail_transaksi_sheet.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/reusable/filter.dart';
import 'package:budgetin/widgets/reusable/information_modal.dart';
import 'package:budgetin/widgets/transaksi/create_update_transaksi.dart';
import 'package:budgetin/widgets/transaksi/saldo_card.dart';
import 'package:budgetin/widgets/transaksi/riwayat_transaksi_card.dart';
import 'package:budgetin/widgets/forms/input_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../widgets/reusable/transaksi_kosong.dart';

class RiwayatTransaksiPage extends StatefulWidget {
  const RiwayatTransaksiPage({super.key});

  @override
  State<RiwayatTransaksiPage> createState() => _RiwayatTransaksiPageState();
}

class _RiwayatTransaksiPageState extends State<RiwayatTransaksiPage> {
  Stream<List<TransactionWithCategory>> getAllTransactions(int month) {
    return db!.getAllTransactionWithCategory(month);
  }

  Stream<List<TransactionWithCategory>> searchTransaction(String keyword,
      {DateTime? start, DateTime? end}) {
    return db!.searchTransactionRepo(keyword);
  }

  final TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool isVisible = true;
  bool isToggleSearch = true;
  int selectedMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_updateVisibility);
    searchController.addListener(_updateVisibility);
  }

  void _updateVisibility() {
    setState(() {
      isVisible = searchController.text.isEmpty && !_focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_updateVisibility);
    _focusNode.removeListener(_updateVisibility);
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void onMonthSelected(int month) {
    setState(() {
      selectedMonth = month;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BudgetinColors.hitamPutih10,
      appBar: AppBar(
        leading: Container(),
        scrolledUnderElevation: 0,
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeInCirc,
              child: Visibility(
                key: Key(isVisible.toString()),
                visible: isVisible,
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: SaldoCard(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: InputSearch(
                controller: searchController,
                focusNode: _focusNode,
                showFilter: false,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              switchInCurve: Curves.easeInCirc,
              child: Visibility(
                key: Key(isVisible.toString()),
                visible: isVisible,
                child: Filter(
                  selectedMonth: selectedMonth,
                  onMonthSelected: onMonthSelected,
                ),
              ),
            ),
            _riwayatTransaksi(context),
          ],
        ),
      ),
    );
  }

  Widget _riwayatTransaksi(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: StreamBuilder<List<TransactionWithCategory>>(
            stream: searchController.text.isNotEmpty
                ? searchTransaction(searchController.text)
                : getAllTransactions(selectedMonth),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  var transactions = snapshot.data!;

                  if (transactions.isNotEmpty) {
                    var groupedTransactions =
                        _groupTransactionsByDate(transactions);

                    return ListView.builder(
                      itemCount: groupedTransactions.keys.length,
                      itemBuilder: (context, index) {
                        var date = groupedTransactions.keys.elementAt(index);
                        var transactionsByDate = groupedTransactions[date]!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              HumanReadableDateFormatter.formatToDate(date),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: BudgetinColors.hitamPutih50,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ...transactionsByDate.map((transaction) {
                              return _buildTransactionCard(transaction);
                            }),
                          ],
                        );
                      },
                    );
                  } else {
                    return const TransaksiKosong();
                  }
                } else {
                  return const TransaksiKosong();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  List<TransactionWithCategory> _filterTransactions(
      List<TransactionWithCategory> transactions) {
    return transactions.where((transaction) {
      final transactionDate = transaction.transaction.transaction_date;
      return transactionDate.month == selectedMonth;
    }).toList();
  }

  Map<DateTime, List<TransactionWithCategory>> _groupTransactionsByDate(
      List<TransactionWithCategory> transactions) {
    var groupedTransactions = <DateTime, List<TransactionWithCategory>>{};

    for (var transaction in transactions) {
      var date = transaction.transaction.transaction_date;
      date = DateTime(date.year, date.month, date.day);

      if (groupedTransactions.containsKey(date)) {
        groupedTransactions[date]!.add(transaction);
      } else {
        groupedTransactions[date] = [transaction];
      }
    }

    return groupedTransactions;
  }

  Widget _buildTransactionCard(TransactionWithCategory transaction) {
    return Stack(
      alignment: Alignment.centerRight,
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              clipBehavior: Clip.none,
              width: 80,
              height: 55,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: kuning50,
              ),
            ),
            Container(
              clipBehavior: Clip.none,
              width: 60,
              height: 55,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: merah50,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              extentRatio: 0.35,
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  autoClose: true,
                  onPressed: (BuildContext context) {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CreateUpdateTransaksiPage(
                        categoryId: transaction.category.id,
                        dataTransaction: transaction,
                        isEditPage: true,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.easeIn;

                        final tween = Tween(begin: begin, end: end);
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: curve,
                        );

                        return SlideTransition(
                          position: tween.animate(curvedAnimation),
                          child: child,
                        );
                      },
                    ));
                  },
                  backgroundColor: kuning50,
                  foregroundColor: Colors.white,
                  icon: Icons.edit_square,
                  padding: const EdgeInsets.all(8),
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                ),
                SlidableAction(
                  onPressed: (value) {
                    showModalInformation(
                        context,
                        'assets/images/modal_gagal.svg',
                        "Hapus Transaksi",
                        false, onPressed: () {
                      db!.deleteTransaction(transaction.transaction.id);
                      Navigator.of(context).pop();

                      _onDismissed(context, transaction.transaction.id, true);
                    });
                  },
                  autoClose: true,
                  backgroundColor: merah50,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  padding: const EdgeInsets.all(8),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(9),
                      bottomRight: Radius.circular(9)),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                showDetailTransaksiSheet(context, transaction);
              },
              child: RiwayatTransaksiCard(
                category: transaction.category.name,
                title: transaction.transaction.name,
                tanggal: transaction.transaction.transaction_date.toString(),
                money: transaction.transaction.amount.toString(),
                icon: transaction.category.icon,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onDismissed(BuildContext context, int index, bool delete) {
    if (delete) {
      showModalInformation(
          context, 'assets/images/alertYes.svg', "Berhasil Dihapus", true);
    } else {
      showModalInformation(
          context, 'assets/images/alertNo.svg', "Gagal Terhapus", true);
    }
  }
}
