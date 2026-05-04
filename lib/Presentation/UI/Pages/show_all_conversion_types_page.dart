import 'package:flutter/material.dart';
import 'package:bmi_calculator/Presentation/UI/utils/extension_utils.dart';

class ShowAllConversionTypesPage extends StatelessWidget {
  final List<Map<String, dynamic>> allConverters;
  final Function redirect;
  const ShowAllConversionTypesPage({
    super.key,
    required this.allConverters,
    required this.redirect,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            padding: .zero,
            itemCount: allConverters.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (deviceWidth <= 500) ? 3 : 4,
            ),
            itemBuilder: (context, index) {
              final converter = allConverters[index];
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => {redirect(index)},
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .center,
                    children: [
                      Icon(converter['icon'], size: 30, color: Colors.white60),
                      20.hb,
                      Text(
                        "${converter['type']}",
                        textAlign: .center,
                        style: TextStyle(color: Colors.white38, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
