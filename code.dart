import 'package:flutter/material.dart';

class CodePage extends StatefulWidget {
  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> _linesOfCode = ['']; // Initialize with an empty line

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_updateLineNumbers);
  }

  void _updateLineNumbers() {
    final text = _textEditingController.text;
    final lines = text.split('\n');
    setState(() {
      _linesOfCode = lines.isNotEmpty ? lines : ['']; // Ensure at least one line is present
    });

    // Scroll to the end of the text field
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Code Editor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40, // Adjust the width as needed
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (int i = 0; i < _linesOfCode.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(top: 5.1),
                              // Add top padding
                              child: Text(
                                '${i + 1}.',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Add space between line numbers and text field
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Enter code',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        contentPadding: EdgeInsets.only(top: 12, bottom: 4, left: 5),
                        filled: true,
                        fillColor: Colors.black, // Set text field background color
                      ),
                      style: TextStyle(color: Colors.white70), // Set input text color to white70
                      onChanged: (_) => _updateLineNumbers(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16), // Add space between text field and submit button
            ElevatedButton(
              onPressed: () {
                // Add your submit logic here
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
