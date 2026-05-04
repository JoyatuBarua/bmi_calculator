import 'package:flutter/material.dart';
import 'package:bmi_calculator/Presentation/UI/utils/extension_utils.dart';

// ignore: must_be_immutable
class BMICalculatorRow extends StatefulWidget {
  final Map<String, double> conversionTypes;
  final GlobalKey<FormState> formKey;
  final Function setTypesForValueControllers;
  final bool activeTopController;
  final TextEditingController valueController;
  String selectedUnit;
  final ValueChanged<String> onUnitChanged;
  final VoidCallback onTap;
  final int position;

  BMICalculatorRow({
    super.key,
    required this.conversionTypes,
    required this.formKey,
    required this.setTypesForValueControllers,
    required this.activeTopController,
    required this.valueController,
    required this.selectedUnit,
    required this.onUnitChanged,
    required this.onTap,
    required this.position,
  });

  @override
  State<BMICalculatorRow> createState() => _BMICalculatorRowState();
}

class _BMICalculatorRowState extends State<BMICalculatorRow> {
  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    bool currentActiveRow =
        (widget.position == 0 && widget.activeTopController == true) ||
        (widget.position == 1 && widget.activeTopController == false);
    Color textHighlight = currentActiveRow
        ? const Color.fromARGB(255, 255, 115, 34)
        : const Color.fromRGBO(199, 199, 199, 1);

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: (devicewidth <= 450)
            ? MainAxisAlignment.center
            : MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              // old width
              // width: devicewidth * .4,
              width: devicewidth * .35,
              child: DropdownButton<String>(
                underline: Container(),
                barrierDismissible: true,
                borderRadius: BorderRadius.circular(20),
                value: widget.selectedUnit,

                // used to show the selected item from the DownDown menu when it's closed
                selectedItemBuilder: (context) {
                  return widget.conversionTypes.keys
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item.split(' ').last,
                            textAlign: .left,
                            style: TextStyle(
                              fontSize: 18,
                              color: const Color.fromRGBO(199, 199, 199, 1),
                            ),
                          ),
                        ),
                      )
                      .toList();
                },

                // used to show all the items that can be selected from the DropDown menu when the menu is open
                items: widget.conversionTypes.keys
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item.replaceAll(' ${item.split(' ').last}', ''),
                          textAlign: .left,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),

                onChanged: (value) => {
                  setState(() {
                    widget.selectedUnit = value!;
                    widget.onUnitChanged(value);
                    widget.setTypesForValueControllers(
                      widget.activeTopController,
                      widget.selectedUnit,
                    );
                  }),
                },
              ),
            ),
          ),
          SizedBox(
            // old width
            // width: devicewidth * .45,
            width: devicewidth * .5,
            child: Column(
              crossAxisAlignment: .end,
              children: [
                TextFormField(
                  // maxLines: 1,
                  showCursor: false,
                  readOnly: true,
                  style: TextStyle(color: textHighlight, fontSize: 28),
                  onTap: widget.onTap,

                  onChanged: (value) => {
                    widget.setTypesForValueControllers(
                      widget.activeTopController,
                      widget.selectedUnit,
                    ),
                  },
                  textAlign: .right,
                  controller: widget.valueController,
                  keyboardType: .none,

                  decoration: InputDecoration(border: .none),
                ),
                Text(
                  textAlign: .right,
                  widget.selectedUnit.replaceAll(
                    ' ${widget.selectedUnit.split(' ').last}',
                    '',
                  ),
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ).withPadding(10),
        ],
      ),
    );
  }
}
