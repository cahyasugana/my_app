import "package:flutter/material.dart";

class TextContainer extends StatelessWidget {
  final String text;
  final Color color;

  const TextContainer({
    required this.text,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 100,
      height: 50,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  ExpandableText(this.text, {this.maxLines = 2});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  bool _isLongText = false;

  @override
  void initState() {
    super.initState();
    _isLongText = widget.text.split('\n').length > widget.maxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _isLongText
            ? AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: Text(
                  widget.text,
                  maxLines: widget.maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                secondChild: Text(
                  widget.text,
                  overflow: TextOverflow.visible,
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              )
            : Text(
                widget.text,
                maxLines: widget.maxLines,
                overflow: TextOverflow.ellipsis,
              ),
        if (_isLongText)
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _isExpanded
                    ? const Text(
                        'Show Less',
                        style: TextStyle(color: Colors.blue),
                      )
                    : const Text(
                        'Show More',
                        style: TextStyle(color: Colors.blue),
                      ),
              ],
            ),
          ),
      ],
    );
  }
}