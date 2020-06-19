import 'package:flutter/material.dart';

class ItemProfile extends StatelessWidget {
  final Function onTap;
  final String text;
  final IconData icon;

  const ItemProfile({Key key, this.onTap, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(text, style: TextStyle(color: Colors.grey[500])),
        onTap: onTap,
      ),
    );
  }
}
