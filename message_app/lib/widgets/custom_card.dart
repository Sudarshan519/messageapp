import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsets margin, padding;
  final String title;
  final VoidCallback onPress;
  const CustomCard(
      {Key key,
      this.child,
      this.margin,
      this.padding,
      this.title,
      this.color,
      this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: margin ?? EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (title != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Container(
                  // color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // color: Colors.white,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
            ],
            Container(
              padding: padding ?? EdgeInsets.all(10),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
