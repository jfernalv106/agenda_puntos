import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  final _textStyle = TextStyle(fontSize: 14.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(17, 66, 0, 0.788235294117647),
            ),
            padding: EdgeInsets.all(2.0),
            child: _menuItem(context),
          ),
        ));
  }




  Widget _menuItem(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          child: Container(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/logo.png'),
                  fit: BoxFit.fitHeight)),
        ),
        ListTile(
          title: Text(
            'Puntos Almacenados',
            style: _textStyle,
          ),
          trailing: Icon(
            Icons.track_changes_rounded,
            color: Colors.white,
            size: 20,
          ),
          onTap: ()=>Navigator.pushNamed(context, 'puntos'),
        ),
        ListTile(
          title: Text(
            'Puntos Temporales',
            style: _textStyle,
          ),
          trailing: Icon(
            Icons.folder_shared_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
        ListTile(
          title: Text(
            'Nuevo Punto',
            style: _textStyle,
          ),
          trailing: Icon(
            Icons.open_in_new_outlined,
            color: Colors.white,
            size: 20,
          ),
          onTap: ()=>Navigator.pushNamed(context, 'nuevo_punto'),
        )
      ],
    );
  }
}
