import 'dart:io';

File formatImage(String img) {
  // ** normal File image format = File('path');
  // ** path example = /data/user/0/com.example.personal_notepad/

  // current stringImage ='File: /data/user/0/com.example.personal_notepad/'
  // which is not suitable to convert into File tybe by doing File(stringImage)
  // now if we do this fileImage =File(stringImage) ;
  //it gives = File: 'File: /data/user/0/com.example.personal_notepad/'
  // so remove extra 'File: /data/.....' we split it . but we still have extra

  final stringImage = img.split(': ');
  //  string cotation =File:  ''/data/user/0/com.example.personal_notepad/''
  // so remove extra cotation we replaced it will empty .then we get normal file format path
  final fileImage = File(stringImage[1].replaceAll("'", ""));
  return fileImage;
}
