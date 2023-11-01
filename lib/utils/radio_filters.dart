import 'package:flutter/material.dart';

class RadioFilters extends StatefulWidget {

  final String filterName;
  final List listOfOptions;
  final dynamic selectedOption;
  final Function updateFilterValue;
  
  const RadioFilters({
    required this.filterName,
    required this.listOfOptions,
    required this.updateFilterValue,
    required this.selectedOption,
    super.key
  });

  @override
  State<RadioFilters> createState() => _RadioFiltersState();
}

class _RadioFiltersState extends State<RadioFilters> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: FractionallySizedBox(
        widthFactor: 0.8,
        // heightFactor: 0.8,
        child: ListView.builder(
          itemCount: widget.listOfOptions.length,
          itemBuilder: (context, index){
            return  RadioListTile(
              title: Text('${widget.listOfOptions[index]}'),
              value: widget.listOfOptions[index],
              groupValue: widget.selectedOption,
              onChanged: (value) {
                widget.updateFilterValue(widget.filterName, {'value': value});
              },
              controlAffinity: ListTileControlAffinity.trailing,
            );
          }
        ),
      ),
    );
  }
}