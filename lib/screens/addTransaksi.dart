import 'package:flutter/material.dart';

class addTransaksi extends StatefulWidget {
  const addTransaksi({Key? key}) : super(key: key);

  @override
  State<addTransaksi> createState() => _addTransaksiState();
}

class _addTransaksiState extends State<addTransaksi> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  Color buttonColor = Colors.grey; // Warna default


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tambah Transaksi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.0),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  hintText: 'Masukkan nama transaksi',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),
              Text(
                "Nominal",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  prefix: Text("Rp "),
                  prefixStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a nominal';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),
              Text(
                "Deskripsi",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.0),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  hintText: 'Masukkan deskripsi transaksi',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),
              Text(
                "Tanggal",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.0),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  suffixIcon: Icon(Icons.calendar_month),
                  hintText: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 40.0),
              Container(
                width: double.infinity,
                height: 57,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.blue; 
                        } else if (states.contains(MaterialState.pressed)) {
                          return Colors.blue;
                        }
                        return buttonColor;
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    "Simpan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully')),
      );
    }
  }
}