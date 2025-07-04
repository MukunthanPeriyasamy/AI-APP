import 'package:ai_app/get_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController _controller = TextEditingController();

String resultText = '';

class _HomePageState extends State<HomePage> {
  void updateResult() async {
    final GPTresult = await getData(_controller.text);
    setState(() {
      resultText = GPTresult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI APP',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Wlcome to Flutter GPT', style: TextStyle(fontSize: 20)),
              Align(alignment: Alignment.center,child: Text('Your Personalized Assistent'),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onSubmitted: (value) => updateResult(),
                  controller: _controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: updateResult,
                      icon: Icon(Icons.send),
                    ),
                    hintText: 'Ask to chatGPT',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Text(
                        resultText,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
