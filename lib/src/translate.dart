import 'package:flutter/material.dart';
import 'package:translated_text/src/jumping_dots.dart';
import 'package:translator/translator.dart';

// ignore: must_be_immutable
class TranslatedText extends StatefulWidget {
  /// A Stateful widget just like original [Text] widget.
  /// The string passed will translated into given language as
  /// [to:] parameter. Default is English ['en'].
  /// [from:] parameter specifies the input language
  /// can be used in localization but not recommended.


  /// String passed to [TranslatedText].
  final String data;

  /// language in which string will be translated.
  final String to;

  /// language from the string will be translated.
  final String from;

  /// An immutable style describing how to format and paint text.
  final TextStyle textStyle;

  /// Defines the strut, which sets the minimum height a line can be relative to the baseline.
  final StrutStyle strutStyle;

  /// Whether and how to align text horizontally.
  final TextAlign textAlign;

  /// A direction in which text flows.
  final TextDirection textDirection;

  /// An identifier used to select a user's language and formatting preferences.
  final Locale locale;

  /// How overflowing text should be handled.
  final TextOverflow textOverflow;

  /// A placeholder Widget to show while string is bieng translated
  Widget placeholder;

  final bool softWrap;

  /// Text Scale Factor to the string
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;

  /// The different ways of measuring the width of one or more lines of text.
  final TextWidthBasis textWidthBasis;

  /// Defines how the paragraph will apply [TextStyle.height] to the ascent of the first line and descent of the last line.
  final TextHeightBehavior textHeightBehavior;
  TranslatedText(
    this.data, {
    Key key,
    this.from = 'auto',
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    this.textOverflow,
    this.textScaleFactor,
    this.textStyle,
    this.to = 'en',
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.placeholder,
    this.strutStyle,
    this.locale,
    this.textWidthBasis,
  })  : assert(data != null),
        super(key: key);

  @override
  _TranslatedTextState createState() => _TranslatedTextState();
}

class _TranslatedTextState extends State<TranslatedText> {
  /// Object of [GoogleTranlator()]
  final translator = GoogleTranslator();

  String translation;
  @override
  void initState() {
    if (widget.placeholder == null)
      widget.placeholder = JumpingDotsProgressIndicator();
    translator
        .translate(widget.data, to: widget.to, from: widget.from)
        .then((value) {
      setState(() {
        translation = value.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return translation != null
        ? Text(
            '$translation',
            key: widget.key,
            textAlign: widget.textAlign,
            textDirection: widget.textDirection,
            textHeightBehavior: widget.textHeightBehavior,
            textWidthBasis: widget.textWidthBasis,
            textScaleFactor: widget.textScaleFactor,
            overflow: widget.textOverflow,
            semanticsLabel: widget.semanticsLabel,
            softWrap: widget.softWrap,
            strutStyle: widget.strutStyle,
            style: widget.textStyle,
            locale: widget.locale,
            maxLines: widget.maxLines,
          )
        : widget.placeholder;
  }
}
