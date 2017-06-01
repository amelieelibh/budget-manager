library budgetserver;

import 'dart:async';
import 'dart:io';

import 'package:http_server/http_server.dart';
import 'package:logging/logging.dart';
import 'package:rpc/rpc.dart';

//import 'package:server_code_lab/server/piratesapi.dart';

//final ApiServer _apiServer = new ApiServer(prettyPrint: true);

// Create a virtual directory used to serve our client code from
// the 'build/web' directory.
final String _buildPath =
    Platform.script.resolve('../build/web/').toFilePath();
final VirtualDirectory _clientDir = new VirtualDirectory(_buildPath);

Future main() async {
  // Add a bit of logging...
  Logger.root..level = Level.INFO
             ..onRecord.listen(print);

  // Set up a server serving the pirate API.
  /*
  _apiServer.addApi(new PiratesApi());
  */
  HttpServer server =
      await HttpServer.bind(InternetAddress.ANY_IP_V4, 8082);
  server.listen(requestHandler);
  print('Server listening on http://${server.address.host}:'
        '${server.port}');
}

Future requestHandler(HttpRequest request) async {
  if (request.uri.path.startsWith('/budget')) {
    // Handle the API request.
    //var apiResponse;
    try {
      //var apiRequest = new HttpApiRequest.fromHttpRequest(request);
      //apiResponse =
      //    await _apiServer.handleHttpApiRequest(apiRequest);
    } catch (error, stack) {
      /*var exception =
          error is Error ? new Exception(error.toString()) : error;
      apiResponse = new HttpApiResponse.error(
          HttpStatus.INTERNAL_SERVER_ERROR, exception.toString(),
          exception, stack);
      */
    }
    return sendApiResponse(apiResponse, request.response);
  } else if (request.uri.path == '/') {
    // Redirect to the piratebadge.html file. This will initiate
    // loading the client application.
    request.response.redirect(Uri.parse('/index.html'));
  } else {
    // Serve the requested file (path) from the virtual directory,
    // minus the preceeding '/'. This will fail with a 404 Not Found
    // if the request is not for a valid file.
    var fileUri = new Uri.file(_buildPath)
        .resolve(request.uri.path.substring(1));
    _clientDir.serveFile(new File(fileUri.toFilePath()), request);
  }
}