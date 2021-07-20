import 'package:agenda_puntos/src/controler/input_punto_controller.dart';
import 'package:agenda_puntos/src/util/util.dart' as Util;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InputCantidades extends StatefulWidget {
  @override
  _InputCantidadesState createState() => _InputCantidadesState();
}

class _InputCantidadesState extends State<InputCantidades> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = Get.find<InputController>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 12,
              ),
              Expanded(
                //  width: _screamsize.width * 0.4,
                child: TextField(
                  obscureText: false,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: textController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: InputDecoration(
                    labelText: 'Cantidad',
                  ),
                  onChanged: (valor) {
                    setState(() {
                      final ct = num.tryParse(valor);
                      print('${ct}');
                      bloc.changeCantidad(ct.toDouble());
                    });
                  },
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          print(bloc.cantidad);
                          if (bloc.cantidad > 0.toDouble()) {
                            bloc.addCantidades(bloc.cantidad);
                          }
                          textController.clear();
                          bloc.changeCantidad(0.toDouble());
                        });
                      })),
            ],
          ),
          Divider(
            indent: 1.0,
            color: Colors.deepPurpleAccent,
          ),
          Container(
              margin: EdgeInsets.only(top: 8),
              height: 162.0,
              child: SafeArea(
                child: lista(bloc),
              )),
          Divider(
            indent: 1.0,
            color: Colors.deepPurpleAccent,
          ),
          Container(
              margin: EdgeInsets.only(top: 6),
              child: SafeArea(
                child: Text(
                  'Total : \$ ${valorTotal(bloc)}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              )),
        ],
      ),
    );
  }

  Widget lista(InputController bloc) {
    if (bloc.cantidades == null) {
      bloc.changeCantidades(List());
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: bloc.cantidades.length,
      itemBuilder: (context, i) => _items(bloc.cantidades[i], bloc),
    );
  }

  Widget _items(double it, InputController bloc) {
    final valor = num.tryParse(bloc.valor ?? '1');
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(11.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 8,
              ),
              Text('Mts: ${it}'.replaceAll('.0', '')),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Text(
                      'Precio:\$ ${Util.numberFormat(((valor ?? 1.0) * it))}')),
              Container(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(Icons.close_sharp, color: Colors.blue, size: 25.0),
                  onPressed: () {
                    setState(() {
                      bloc.cantidades.remove(it);
                    });
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String valorTotal(InputController bloc) {
    int valor = num.tryParse(bloc.valor ?? '1');
    double total = num.tryParse('0.0');
    for (double c in bloc.cantidades) {
      total += ((valor ?? 1.0) * c);
    }
    return '${Util.numberFormat(total)}';
  }
}
