library link_text;

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
	LinkText(this.text, {this.linkStyle, this.textStyle});

	final String text;
	final TextStyle linkStyle;
	final TextStyle textStyle;

	@override
	Widget build(BuildContext context) {
		var children = new List<TextSpan>();
		var matches = RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+').allMatches(this.text).toList();
		var links = matches.map<TextSpan>((m) {
			 var rec = TapGestureRecognizer()..onTap = () async {
            if (await canLaunch(m.group(0))) {
              await launch(m.group(0));
            }
    };
        return TextSpan(text: m.group(0), style: linkStyle ?? TextStyle(inherit: true, color: Colors.blue, decoration: TextDecoration.underline), recognizer: rec);
				}
		).toList();
		if (matches.length > 0) {
      for (var i = 0; i < matches.length; i++) {
        if (i == 0) {
          if (matches[i].start != 0) {
            children.add(TextSpan(text: this.text.substring(0, matches[i].start), style: textStyle ?? TextStyle(inherit: true, color: Colors.black)));
          }
          children.add(links[i]);
          continue;
        }
        children.add(
            TextSpan(text: this.text.substring(matches[i - 1].end, matches[i].start), style: textStyle ?? TextStyle(inherit: true, color: Colors.black)));
        children.add(links[i]);
      }
      if (matches.last.end != this.text.length) {
        children.add(TextSpan(text: this.text.substring(matches.last.end),
            style: textStyle ?? TextStyle(inherit: true, color: Colors.black)));
      }
    } else {
		  children.add(TextSpan(text: this.text, style: textStyle ?? TextStyle(inherit: true, color: Colors.black)));
    }
		return RichText(text: TextSpan(children: children));
	}

}
