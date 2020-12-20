import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io'show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency='USD';
  Widget androiddropdown(){
    List<DropdownMenuItem<String>>dropdownitem=[];
    for(String currency in currenciesList){
      var newitem=DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownitem.add(newitem);
    }

    return DropdownButton<String>(
        value:selectedCurrency ,
        items: dropdownitem,
        onChanged: (value){
          setState(() {
            selectedCurrency=value;
            getData();
          },);
        },
    );
  }
  CupertinoPicker iospicker(){
    List <Text> pickeritem=[];
    for(String Current in currenciesList){
      pickeritem.add(Text(Current));
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectindex){
          print(selectindex);
          setState(() {
            selectedCurrency=currenciesList[selectindex];
            getData();
          });
        },
        children: pickeritem,
    );
  }

  String bitconValueINUsd='?';
  void getData()async{
    try{
      double data=await CoinData().getcoindata(selectedCurrency);
      setState(() {
        bitconValueINUsd=data.toStringAsFixed(0);
      });
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC =$bitconValueINUsd $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS?iospicker():androiddropdown(),
          ),
        ],
      ),
    );
  }
}
