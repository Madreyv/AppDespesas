import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final double value;
  final double percentage;

  ChartBar({this.weekDay, this.value, this.percentage});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Container(
            height: 20,
            child: Text('${value}'),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 69,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            ],
          ),
        ),
        Text(weekDay),
      ],
    );
  }
}
