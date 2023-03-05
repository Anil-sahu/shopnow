import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class CorouleCard extends StatelessWidget {
  const CorouleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Colors.white, Colors.white]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Get the special discount",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Text(
                "50%",
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                "OFF",
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600"))),
              ),
              Icon(
                Icons.star,
                color: Theme.of(context).selectedRowColor,
              )
            ],
          )
        ],
      ),
    );
  }
}
