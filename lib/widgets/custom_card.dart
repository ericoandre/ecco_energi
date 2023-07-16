import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final String sub_text;
  final String body_text;
  final Color backColor;

  const CustomCard(
      {super.key,
      required this.text,
      required this.sub_text,
      required this.body_text,
      required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: backColor,
          boxShadow: const [
            BoxShadow(
                blurRadius: 5, color: Color(0x23000000), offset: Offset(0, 2))
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: const AlignmentDirectional(0, 1),
        child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(text,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          sub_text,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0x9AFFFFFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Text(body_text,
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600))),
                  ]))
            ])));
  }
}
