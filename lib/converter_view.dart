import 'dart:async';
import 'dart:ffi';

import 'package:cloudconvert_client/cloudconvert_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'converter_bloc.dart';
import 'converter_state.dart';
import 'converter_event.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  bool _loading = false;
  final List<String> items = [
    'Word',
    'Powerpoint',
    'Excel',
    'JPG',
  ];
  final List<String> items2 = [
    'Word',
    'Powerpoint',
    'Excel',
    'JPG',
  ];
  String? value;

  @override
  Widget build(BuildContext contex) {
    return BlocProvider(
        create: ((context) => ConverterBloc()),
        child: BlocBuilder<ConverterBloc, ConverterState>(
            builder: (context, state) {
          return Scaffold(
            body: Center(
                child: Container(
              padding: EdgeInsets.only(top: 230),
              child: Column(
                children: [
                  Container(
                    width: 362,
                    height: 40,
                    padding: EdgeInsets.only(left: 6, right: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Color.fromARGB(57, 198, 198, 198),
                            width: 2)),
                    child: Container(
                      color: Colors.white,
                      child: TextButton(
                        onPressed: (() {
                          context.read<ConverterBloc>().add(OpenMyDocument());
                        }),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            const Text("Загрузить файл",
                                style: TextStyle(color: Colors.black)),
                            const SizedBox(width: 200),
                            const Icon(
                              Icons.add_box,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      'Выбранный файл:   ${state.fileName} ${state.listExtensionString0}',
                    ),
                  ),

//----------------------------------------------------
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      width: 362,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Color.fromARGB(57, 198, 198, 198),
                              width: 2)),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        value: value,
                        isExpanded: true,
                        items: items.map(buildMenuItem).toList(),
                        onChanged: (value) => setState(
                          () {
                            context
                                .read<ConverterBloc>()
                                .add(ConverterDocument());
                            this.value = value;
                            _loading = true;
                            Timer(Duration(seconds: 3), () {
                              setState(() {
                                _loading = false;
                              });
                            });
                          },
                        ),
                      ))),
//-----------------------------------------------------

                  _loading ? _CircularProgressIndicator() : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 362,
                    height: 40,
                    padding: EdgeInsets.only(left: 6, right: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Color.fromARGB(57, 198, 198, 198),
                            width: 2)),
                    child: Container(
                      color: Colors.white,
                      child: TextButton(
                        onPressed: () {
                          context.read<ConverterBloc>().add(DownloadDocument());
                        },
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            const Text("Скачать файл",
                                style: TextStyle(color: Colors.black)),
                            const SizedBox(width: 212),
                            const Icon(
                              Icons.archive_sharp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          );
        }));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontSize: 15,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold),
        ),
      );
}

Widget _CircularProgressIndicator() {
  return Container(
      width: 40,
      height: 60,
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          CircularProgressIndicator(),
        ],
      ));
}
