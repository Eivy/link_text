library link_text;

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatefulWidget {
  LinkText(this.text, {this.linkStyle, this.textStyle});

  final String text;
  final TextStyle linkStyle;
  final TextStyle textStyle;

  @override
  createState() => LinkTextState();
}

class LinkTextState extends State<LinkText> {
  List<GestureRecognizer> recList = new List<GestureRecognizer>();

  @override
  Widget build(BuildContext context) {

    var text = Theme.of(context).textTheme.body1.merge(widget.textStyle);
    var link = Theme.of(context).textTheme.body1
        .merge(TextStyle(inherit: true, color: Colors.blue, decoration: TextDecoration.underline))
        .merge(widget.linkStyle);

    var children = new List<TextSpan>();
    var matches = RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+').allMatches(widget.text).toList();
    var links = matches.map<TextSpan>((m) {
      var rec = TapGestureRecognizer()..onTap = () async {
        if (await canLaunch(m.group(0))) {
          await launch(m.group(0));
        }
      };
      recList.add(rec);
      return TextSpan(text: m.group(0), style: link, recognizer: rec);
    }
    ).toList();
    if (matches.length > 0) {
      for (var i = 0; i < matches.length; i++) {
        if (i == 0) {
          if (matches[i].start != 0) {
            children.add(TextSpan(text: widget.text.substring(0, matches[i].start), style: text));
          }
          children.add(links[i]);
          continue;
        }
        children.add(
            TextSpan(text: widget.text.substring(matches[i - 1].end, matches[i].start), style: text));
        children.add(links[i]);
      }
      if (matches.last.end != widget.text.length) {
        children.add(TextSpan(text: widget.text.substring(matches.last.end),
                style: text));
      }
    } else {
      children.add(TextSpan(text: widget.text, style: text));
    }
    return RichText(text: TextSpan(children: children));
  }

  @override
  dispose() {
    for (var i = recList.length-1; i >= 0; i--) {
      recList.removeAt(i);
    }
    super.dispose();
  }

}
