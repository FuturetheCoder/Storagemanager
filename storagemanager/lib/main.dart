// import 'package:flutter/material.dart';
// import 'dart:io';
// import  'dart:async';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';
 
// void main() => runApp(MyApp());
 
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Storage Path',
//       debugShowCheckedModeBanner: false,
//       home: StoragePath(
//         storage: Storage(),
//       ),
//     );
//   }
// }


// class StoragePath extends StatefulWidget {
//  final Storage storage; 

//  StoragePath ({Key key, @required this.storage}) : super (key: key);

// @override
//   _StoragePathState createState() => _StoragePathState();
// }

// class _StoragePathState extends State<StoragePath> {
// TextEditingController controller= TextEditingController();
// String state;
// Future<Directory> _appDocDir;
//    @override
//    void initState() {
//      super.initState();
//      widget.storage.readData().then((String value){
//        setState(() {
//         state = value; 
//        });
//      });
//    }

//    Future<File> writeData()async {
//      setState(() {
//       state = controller.text;
//       controller.text= ''; 
//      });
//      return widget.storage.writeData(state);
//    }

//    void getAppDirectory(){
//      setState(() {
//       _appDocDir = getApplicationDocumentsDirectory(); 
//      });
//    }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("STORAGE MANAGER"),
//       ),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Text('${state ?? "file is empty"}'),
//             TextFormField(
//               controller: controller,
//             ),
//             MaterialButton(
//               onPressed: writeData,
//               child: Text('write to file'),
//             ),
//              MaterialButton(
//               onPressed: getAppDirectory,
//               child: Text('Get DIR path'),
//              ),
//              FutureBuilder<Directory>(
//                future: _appDocDir,
//                builder: (BuildContext context, AsyncSnapshot<Directory> snapshot){
//                  Text text = Text('');
//                  if(snapshot.connectionState == ConnectionState.done){
//                 if(snapshot.hasError){
//                   text = Text('Error: ${snapshot.error}');
//                 } else if (snapshot.hasData) {
//                    text = Text('Path: ${snapshot.data.path}');
//                 } else {
//                    text = Text('Unavailable');
//                 }
//                  }
//                  return new Container(
//                    child: text,
//                  );
//                }
//              )
//           ],
//         ),
//       ),
//     );
//   }
// }


// class Storage{
//   Future<String> get localPath async{
//     final dir = await getApplicationDocumentsDirectory();
//     return dir.path;
//   }



// Future<File> get localFile async {
//   final path = await localPath;
//   return File('$path/db.txt');
// }
  
// Future<String> readData() async{
//   try{
//     final file = await localFile;
//     String body = await file.readAsString();
//     return body;
//   }catch (e){
//     return e.toString();
//   }
// }

// Future<File> writeData (String data) async {
//   final file = await localFile;
//   return file.writeAsString('$data');
// }
// }
 




  









// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:file_picker/file_picker.dart';

// void main() => runApp(new MaterialApp(
//    routes:  <String, WidgetBuilder>{
     
//    },
//   debugShowCheckedModeBanner: false,
//   home: FilePickerDemo(),
// ));

// class FilePickerDemo extends StatefulWidget {
//   @override
//   _FilePickerDemoState createState() => new _FilePickerDemoState();
// }

// class _FilePickerDemoState extends State<FilePickerDemo> {
//   String _fileName;
//   String _path;
//   Map<String, String> _paths;
//   String _extension;
//   bool _multiPick = true;
//   bool _hasValidMime = false;
//   FileType _pickingType;
//   TextEditingController _controller = new TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() => _extension = _controller.text);
//   }

//   void _openFileExplorer() async {
//     if (_pickingType != FileType.CUSTOM || _hasValidMime) {
//       try {
//         if (_multiPick) {
//           _path = null;   
//           _paths = await FilePicker.getMultiFilePath(
//               type: _pickingType, fileExtension: _extension);
//         } else {
//           _paths = null;
//           _path = await FilePicker.getFilePath(
//               type: _pickingType, fileExtension: _extension);
//         }
//       } on PlatformException catch (e) {
//         print("Unsupported operation" + e.toString());
//       }
//       if (!mounted) return;

//       setState(() {
//         _fileName = _path != null
//             ? _path.split('/').last
//             : _paths != null ? _paths.keys.toString() : '...';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           title: const Text('File Picker'),
//         ),
//         body: new Center(
//             child: new Padding(
//           padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//           child: new SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: new Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 new Padding(
//                   padding: const EdgeInsets.only(top: 20.0),
//                   child: new DropdownButton(
//                       hint: new Text('LOAD PATH '),
//                       value: _pickingType,
//                       items: <DropdownMenuItem>[
//                         new DropdownMenuItem(
//                           child: Icon(Icons.audiotrack),
//                           value: FileType.AUDIO,
//                         ),
//                         new DropdownMenuItem(
//                           child: Icon(Icons.image),
//                           value: FileType.IMAGE,
//                         ),
//                         new DropdownMenuItem(
//                           child: Icon(Icons.video_label),
//                           value: FileType.VIDEO,
//                         ),
//                         new DropdownMenuItem(
//                           child: new Icon(Icons.android),
//                           value: FileType.ANY,
//                         ),
//                         new DropdownMenuItem(
//                           child: new Text('CUSTOM FORMAT'),
//                           value: FileType.CUSTOM,
//                         ),
//                       ],
//                       onChanged: (value) => setState(() {
//                             _pickingType = value;
//                             if (_pickingType != FileType.CUSTOM) {
//                               _controller.text = _extension = '';
//                             }
//                           })),
//                 ),
//                 new ConstrainedBox(
//                   constraints: BoxConstraints.tightFor(width: 100.0),
//                   child: _pickingType == FileType.CUSTOM
//                       ? new TextFormField(
//                           maxLength: 15,
//                           autovalidate: true,
//                           controller: _controller,
//                           decoration:
//                               InputDecoration(labelText: 'File extension'),
//                           keyboardType: TextInputType.text,
//                           textCapitalization: TextCapitalization.none,
//                           validator: (value) {
//                             RegExp reg = new RegExp(r'[^a-zA-Z0-9]');
//                             if (reg.hasMatch(value)) {
//                               _hasValidMime = false;
//                               return 'Invalid format';
//                             }
//                             _hasValidMime = true;
//                             return null;
//                           },
//                         )
//                       : new Container(),
//                 ),
//                 new ConstrainedBox(
//                   constraints: BoxConstraints.tightFor(width: 200.0),
//                   child: new SwitchListTile.adaptive(
//                     title: new Text('Pick multiple files',
//                         textAlign: TextAlign.right),
//                     onChanged: (bool value) =>
//                         setState(() => _multiPick = value),
//                     value: _multiPick,
//                   ),
//                 ),
//                 new Padding(
//                   padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
//                   child: new RaisedButton(
//                     onPressed: () => _openFileExplorer(),
//                     child: new Text("Open file picker"),
//                   ),
//                 ),
//                 new Builder(
//                   builder: (BuildContext context) =>
//                       _path != null || _paths != null
//                           ? new Container(
//                               padding: const EdgeInsets.only(bottom: 30.0),
//                               height: MediaQuery.of(context).size.height * 0.50,
//                               child: new Scrollbar(
//                                   child: new ListView.separated(
//                                 itemCount: _paths != null && _paths.isNotEmpty
//                                     ? _paths.length
//                                     : 1,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   final bool isMultiPath =
//                                       _paths != null && _paths.isNotEmpty;
//                                   final String name = 'File $index: ' +
//                                       (isMultiPath
//                                           ? _paths.keys.toList()[index]
//                                           : _fileName ?? '...');
//                                   final path = isMultiPath
//                                       ? _paths.values.toList()[index].toString()
//                                       : _path;

//                                   return new ListTile(
//                                     title: new Text(
//                                       name,
//                                     ),
//                                     subtitle: new Text(path),
//                                   );
//                                 },
//                                 separatorBuilder:
//                                     (BuildContext context, int index) =>
//                                         new Divider(),
//                               )),
//                             )
//                           : new Container(),
//                 ),
//               ],
//             ),
//           ),
//         )),
//       ),
//     );
//   }
// }
 




import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}