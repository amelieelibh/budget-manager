import 'dart:html';


/// send data to server
sendDatas(dynamic data) {
  final req = new HttpRequest();
  req.onReadyStateChange.listen((Event e) {
    if (req.readyState == HttpRequest.DONE &&
        (req.status == 200 || req.status == 0)) {
      window.alert("upload complete");
    }
  });
  req.open("POST", "http://127.0.0.1:8080/upload");
  req.send(data);
}