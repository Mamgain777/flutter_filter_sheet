import 'package:filter_sheet/screens/filter_sheet.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {

  final String title;
  
  const MainScreen({
    required this.title,
    super.key
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Map filters = {
    'price': {'type': 'radio', 'options': [50.0, 100.0, 150.0], 'values': 50.0},
    'color': {'type': 'check', 'options': ['black', 'green', 'orange'], 'values': ['black']},
    
  };

  

  void applyFilters(Map newFilters){
    setState(() {
      filters = newFilters;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: Container(
        margin: const EdgeInsets.only(top: 24.0),
        child: Row(
          children: [
            // Text("${filters['price']}"),
            ElevatedButton(
                onPressed: (){
                  showModalBottomSheet(
                    context: context, 
                    builder: (context) {
                      return FilterSheet(
                        filters: filters,
                        applyFilters: applyFilters,
                      );
                    }
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                child: const Text("Filters", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),),
              ),
          ],
        ),
        ),
    );
  }
}