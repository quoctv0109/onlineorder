import 'dart:io';
import 'package:flutter/material.dart';
import 'package:onlineorder/ui_view/list_view_qr.dart';
import 'page_app_theme.dart';
import 'package:onlineorder/ui_view/appbar_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class QrOrder extends StatefulWidget {
  const QrOrder({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  QrOrderState createState() => QrOrderState();
}

class QrOrderState extends State<QrOrder> with TickerProviderStateMixin {
  double topBarOpacity = 0.0;
  final ScrollController scrollController = ScrollController();
  List<Widget> listViews = <Widget>[];

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PageAppTheme.background,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PageAppTheme.nearlyDarkBlue,
          title: const Center(child: Text('QR Bàn')) ,
        ),
        backgroundColor: Colors.transparent,
        body: getMainListViewUI(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: AddProduct(),
        ),
      ),
    );
  }

  //List products
  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return Container(
              padding: EdgeInsets.only(
                bottom: 62 + MediaQuery.of(context).padding.bottom,
              ),
              child: ListViewQr());
        }
      },
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }
}

//Button add new product
class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            builder: (context) => Container(
                height: 600,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20))),
                child: Column(
                  children: <Widget>[
                    TitleAddProduct(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, top: 10, left: 20, right: 20),
                        child: ListView(
                          children: [
                            Container(
                                child: Text("Tên sản phẩm",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Container(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextField(
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      height: 1,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true, // Added this
                                    ))),
                            Container(
                                child: Text("Giá bán",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Container(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextField(
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      height: 1,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true, // Added this
                                    ))),
                            TakePicture(),
                            Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: FlatButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.save),
                                      SizedBox(width: 10),
                                      Center(child: Text("Lưu"))
                                    ],
                                  ),
                                  onPressed: () {},
                                  color: PageAppTheme.nearlyDarkBlue,
                                  textColor: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                )));
      },
      backgroundColor: PageAppTheme.nearlyDarkBlue,
    );
  }
}

//Title of add product
class TitleAddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      height: 40,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.white,
                child: Text('Thêm QR Bàn',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TakePicture extends StatefulWidget {
  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  List<XFile>? _imageFileList;
  final ImagePicker _picker = ImagePicker();
  String? _retrieveDataError;
  dynamic _pickImageError;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Align(
                alignment: Alignment.topLeft,
                child: FutureBuilder<void>(
                  future: retrieveLostData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Text(
                          'Không có hình ảnh',
                          textAlign: TextAlign.center,
                        );
                      case ConnectionState.done:
                        return _previewImages();
                      default:
                        if (snapshot.hasError) {
                          return Text(
                            'Hình ảnh bị lỗi: ${snapshot.error}}',
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return const Text(
                            'Không có hình ảnh',
                            textAlign: TextAlign.center,
                          );
                        }
                    }
                  },
                ))),
        Expanded(
            child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  backgroundColor: PageAppTheme.nearlyDarkBlue,
                  onPressed: () async {
                    try {
                      final pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );

                      setState(() {
                        _imageFile = pickedFile;
                      });
                    } catch (e) {
                      setState(() {
                        _pickImageError = e;
                      });
                    }
                  },
                  heroTag: 'image2',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.photo_library),
                ))),
        Expanded(
            child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  backgroundColor: PageAppTheme.nearlyDarkBlue,
                  onPressed: () async {
                    try {
                      final pickedFile = await _picker.pickImage(
                        source: ImageSource.camera,
                      );

                      setState(() {
                        _imageFile = pickedFile;
                      });
                    } catch (e) {
                      setState(() {
                        _pickImageError = e;
                      });
                    }
                  },
                  heroTag: 'image2',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                )))
      ],
    );
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _imageFileList = response.files;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Container(
        width: 200,
        height: 150,
        color: Colors.white,
        child:
        Image.file(File(_imageFileList![0].path), width: 200, height: 150),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Hình ảnh lỗi: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/fitness_app/no-image.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: null);
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
