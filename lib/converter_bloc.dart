import 'dart:math';

import 'package:cloudconvert_client/cloudconvert_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data.dart';
import 'package:flutter_application_1/converter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'converter_event.dart';
import 'Data.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  String? nameFString = " ";
  String? pathFString = " ";
  String ExtensionURL = " ";
  String outputFormat = "pdf";
  Client newclient = Client(
    apiKey:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjYyZWEyMTNkYmU4NzViN2JmNDk2MDEyMGM2MzI4YWE0Y2JjMmJmODdjMGQ3NDA4OGQ3ZGJiNTcwYWUxMTc2MWQ0NTg0NDdhZDc5OTVhYmQiLCJpYXQiOjE2NjU5NDE5MzIuMDczNzMyLCJuYmYiOjE2NjU5NDE5MzIuMDczNzMzLCJleHAiOjQ4MjE2MTU1MzIuMDY5MTExLCJzdWIiOiI2MDMzNTUxNiIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.Zijg_kqG9Dqr7laQltbaaJTMdvdtFEA1ahj5VrIXX_Q9UkMaNfq3QmvaSWTXk1u9y0c3ef1DrO8vbZuW6_UapTP1hSHW-Xrd_Z32xnJqU9y3v1vVtkCzmtfLFenbMWo-75-4pkgeeoCsTi_2UVCfEGboGOkbLpSuGyOyxT8YbzYiY7mB01ktTlBb9SIqv5LX2Q02ZDuNg6zDvibeKh3J4GpZUp1hopYWY6i4-dWXuOhvwxX4B7r_-JU5EoCWh1Rbugl5htY6kCdFWJpx_7beegJx4l5zT-gNuQBSIJKW7poOhHhvxnYuLSFu73G7Z7Bds5c1zfdKto8iyKQ3brpDowfLX6KevozXUIoy6SaAVpnN3dEY6aiHUyQ498VYxSI3XspFKHDSQji0Yg-8dTyaylBKR7TIUQ7mIpTMR20Sbpw0BgirPvMtIR2dq9xC37wVmckFBc2ZMFcjHDVsRJdxsssIR_PgT9Qyjdtr6MUxGov0yKHBvx1iXkbDBkOBsKAIk-slp36KGNyO9Co_nROOAw6eiw5Q2afg5nqISianE2pRk_L40KjKFYE-rcwFlCkQCamFYH8CBXOltaqgO5A_Qo2RtEHPV1iZ0wwzJHE9b9e1z9g8ve-wj4XrEYyp3hklKzYeuAUzOu6KKeknRWE935KBxFVVVouvmefbtlOAii0",
    baseUrls: BaseUrls.sandbox,
  );

  ConverterBloc() : super(const ConverterState()) {
    on<ConverterEvent>((event, emit) async {
      if (event is OpenMyDocument) {
        await GetAnExtension(event, state, emit);
      } else {
        if (event is ConverterDocument) {
          await Convertor(event, state, emit);
        } else {
          if (event is DownloadDocument) {
            await Download(event, state, emit);
          } else {}
        }
      }
    });
  }

  Future GetAnExtension(OpenMyDocument event, ConverterState state,
      Emitter<ConverterState> emit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      int found = 0;
      nameFString = file.name;
      pathFString = file.path;
      //==================================================
      // String filepath = "C:\\Users\\Svyatoslav\\Downloads\\a.txt";
      // ConverterResult token = (await newclient.getSupportedFormats(filepath));
      // if (token.exception != null) {
      //   ExtensionListString.addAll(token.exception);
      // } else {
      //   print(token.result);
      // }
      emit(state.copyWith(fileName: nameFString, filePath: pathFString));
    }
  }

  Future Convertor(ConverterDocument event, ConverterState state,
      Emitter<ConverterState> emit) async {
    ConverterResult url =
        (await newclient.postJob(pathFString.toString(), outputFormat));
    if (url.exception != null) {
      print(url.exception);
      ExtensionURL = url.exception.toString();
    } else {
      print(url.result);
    }
    emit(state.copyWith());
  }

  Future Download(DownloadDocument event, ConverterState state,
      Emitter<ConverterState> emit) async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'output-file.pdf',
    );

    if (outputFile == null) {
      // User canceled the picker
    }

    // ConverterResult response = await newclient.downloadResult(
    //     ExtensionURL, "filename", outputFormat, "C:\Users\Asus\TaskRadar");
    // if (response.exception != null) {
    //   print(response.exception);
    // }
    //emit(state.copyWith(listExtensionString0: response.exception.toString()));
    emit(state.copyWith());
  }
}
