import 'package:filter_sheet/utils/checkbox_filters.dart';
import 'package:filter_sheet/utils/radio_filters.dart';
import 'package:flutter/material.dart';

class FilterSheet extends StatefulWidget {

  final Map filters;
  final Function applyFilters;
  
  
  const FilterSheet({
    required this.filters,
    required this.applyFilters,
    super.key}
  );

  @override
  State<FilterSheet> createState() => FilterSheetState();
}

class FilterSheetState extends State<FilterSheet> {

  String currentFilter = '';
  Widget currentFilterFunction = const Placeholder();
  Map sheetFilters = {};

  /// Update filter value fucntion to be passed to option widget for updating filter values in Bottom sheet
  void updateFilterValue(String key, Map kwargs){
    
    if(widget.filters[key]['type'] == "radio"){
      setState(() {
        sheetFilters[key]['values'] = kwargs['value'];
      });
    }
    else if(widget.filters[key]['type'] == "check"){
      if(kwargs['action']){
        setState(() {
          sheetFilters[key]['values'].add(kwargs['value']);
        });
      }
      else{
        setState(() {
          sheetFilters[key]['values'].remove(kwargs['value']);
        });
      }
    }
  }

  void setCurrentFilterFunction(){
    if(widget.filters[currentFilter]['type'] == 'radio'){
      currentFilterFunction = RadioFilters(
        filterName: currentFilter, 
        listOfOptions: widget.filters[currentFilter]['options'], 
        updateFilterValue: updateFilterValue, 
        selectedOption: sheetFilters[currentFilter]['values']
      );
    }
    else if(widget.filters[currentFilter]['type'] == 'check'){
      currentFilterFunction = CheckboxFilters(
        filterName: currentFilter, 
        listOfOptions: widget.filters[currentFilter]['options'], 
        updateFilterValue: updateFilterValue, 
        selectedOption: sheetFilters[currentFilter]['values']
      );
    }
  }
  
  void onEveryBuild(){
    setCurrentFilterFunction();
  }
  
  
  @override
  void initState() {
    sheetFilters = deepCopyMap(widget.filters);
    currentFilter = sheetFilters.keys.elementAt(0);
    // onEveryBuild();
    super.initState();
  }


  
  @override
  void dispose(){
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    onEveryBuild();
    return Row(
      children:[  
        Expanded(
          flex: 1,
          
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.black, 
                  width: 1.0, 
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: ListView.builder(
                itemCount: sheetFilters.length,
                itemBuilder: (context, index){
                  final key = sheetFilters.keys.elementAt(index);
                  return InkWell(
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          currentFilter = sheetFilters.keys.elementAt(index);
                        });
                      },
                      style: (currentFilter == key)?isCurrenFilter():isInactiveFilter(),
                      child: Text(key, style: const TextStyle(fontSize: 16.0),textAlign: TextAlign.left,),
                    ),
                  );
                },
              ),
            ),
          )
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: currentFilterFunction
              ),
              Expanded(
                flex: 1,
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  heightFactor: 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      // AppNavigator.pop();

                    },
                    style: ButtonStyle(
                      shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Set the radius to 10
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.red), // Set background color to red
                    ),
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        color: Colors.white, // Set text color to white
                        fontSize: 18, // Set font size to 16
                        fontWeight: FontWeight.w600, // Set font weight to 600
                      ),
                    ),
                  )
                ),
              )
            ],
          )
          
        )
      ]
    ); 
    // return const ;
  }
}

ButtonStyle isCurrenFilter(){
  return  ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.blueAccent), // Set the background color to accent blue
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // Set the radius to 0
      ),
    ),
    foregroundColor: MaterialStateProperty.all(Colors.white),
  );
}

ButtonStyle isInactiveFilter() {
  return ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.pinkAccent),
  );
}


/// Function to remove binding of object and copy its element
Map deepCopyMap(Map original) {
  Map copy = {};

  original.forEach((key, value) {
    if (value is Map) {
      // Recursively copy nested maps
      copy[key] = deepCopyMap(value);
    } else if (value is List) {
      // Create a new list and copy its elements
      copy[key] = List.from(value);
    } else {
      // For non-list, non-map values, assign directly
      copy[key] = value;
    }
  });

  return copy;
}
