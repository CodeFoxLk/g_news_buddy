import 'dart:convert';
import 'dart:io';
import 'package:g_news_buddy/utils/logger.dart';
import 'package:http/http.dart';

class NetworkErrorHandler{
   NetworkErrorMessage? handleRequest(Response response){
      final int statusCode = response.statusCode;
      NetworkErrorMessage? errorMessage;
      if(statusCode < 299){
        return errorMessage;
      }else if(statusCode < 399 ){
        //redirect error
        errorMessage =  NetworkErrorMessage(response);
        
      }else if(statusCode < 499 ){
        //Client error
        errorMessage =  NetworkErrorMessage(response);
      }else{
        //server error
        errorMessage =  NetworkErrorMessage(response);
      }
      
      return errorMessage;
      //throw errorMessage;
  } 
}


class NetworkErrorMessage extends IOException{

    NetworkErrorMessage(this.response, {
        this.statusCode,
        this.errorId,
        this.error,
    }){
      decodeMessage(response);
    }

    String? statusCode;
    String? errorId;
    String? error;
    final Response response;
  
    @override
    String toString() {
       return "error - $error  statusCode - $statusCode path - ${response.request!.url}  ";
    }

     void decodeMessage(Response response){
       Map<String, dynamic>? decodeJson;
        try{
          decodeJson = json.decode(response.body);
          statusCode = decodeJson!["status_code"] ??  response.statusCode as String?;
          errorId = decodeJson["error_id"];
          error = decodeJson["error"];
        }catch(e){
          logger.e(e);
        }
       }
}
