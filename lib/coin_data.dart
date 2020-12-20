import 'dart:convert';
import 'package:http/http.dart'as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const Coinapi='https://rest.coinapi.io/v1/exchangerate';
const ApiKey='9BDD0A22-0A6C-4FCE-B364-527CFBBA875D';
class CoinData {
  Future getcoindata(String selectcurrency)async{
    String requestUrl='$Coinapi/BTC/$selectcurrency?apikey=$ApiKey';
    http.Response response=await http.get(requestUrl);
    if(response.statusCode==200){
      var decodeData=jsonDecode(response.body);
      var latprice=decodeData['rate'];
      return latprice;
    }
    else{
      print(response.statusCode);
      throw 'problem with get request';
    }
  }
}
