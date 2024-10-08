import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const MenuItem({Key key, this.icon, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.deepOrange[700],
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            FittedBox(
                fit:  BoxFit.fitWidth,
                child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  //fontSize: 26,
                  fontFamily: 'Montserrat',
                  color: Colors.deepOrange[700],
                ),
              )
            )
            
          ],
        ),
      ),
    );
  }
}
