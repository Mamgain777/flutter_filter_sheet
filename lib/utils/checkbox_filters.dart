import 'package:flutter/material.dart';

class CheckboxFilters extends StatefulWidget {

  final String filterName;
  final List listOfOptions;
  final dynamic selectedOption;
  final Function updateFilterValue;
  
  const CheckboxFilters({
    required this.filterName,
    required this.listOfOptions,
    required this.updateFilterValue,
    required this.selectedOption,
    super.key
  });

  @override
  State<CheckboxFilters> createState() => _CheckboxFiltersState();
}

class _CheckboxFiltersState extends State<CheckboxFilters> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: FractionallySizedBox(
        widthFactor: 0.8,
        // heightFactor: 0.8,
        child: ListView.builder(
          itemCount: widget.listOfOptions.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(widget.listOfOptions[index]),
              value: widget.selectedOption.contains(widget.listOfOptions[index]),
              onChanged: (action) {
                widget.updateFilterValue(widget.filterName, {'action': action, 'value': widget.listOfOptions[index]});
              },
            );
          },
        ),
      ),
    );
  }
}