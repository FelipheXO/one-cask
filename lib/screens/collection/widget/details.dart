import 'package:app/components/customButton.dart';
import 'package:app/models/item.dart';
import 'package:app/utils/assets.dart';
import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final ItemModel wines;
  final int index;
  const Details({super.key, required this.wines, required this.index});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int index = 0;

  String wineName = '';
  String yearOld = '';
  String code = '';

  @override
  void initState() {
    super.initState();
    processWineName(widget.wines.name ?? "");
  }

  void processWineName(String fullName) {
    setState(() {
      yearOld =
          (DateTime.now().year - int.parse(fullName.split(" ")[1])).toString();
      wineName = fullName.split(" ")[0];
      code = fullName.split(" ")[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            Assets.background,
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seção do título e status da garrafa
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.amber,
                            size: 12,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Genuine Bottle (Unopened)',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Hero(
                  tag: '${widget.wines.image}${widget.index}',
                  child: Image.asset(
                    widget.wines.image!,
                    height: 240,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        /*
                        
                        final List<Wines> bottles = [
    Wines(name: "Springbank 1992 #1234", image: "assets/img/bottle.png"),
    Wines(name: "Springbank 1995 #5678", image: "assets/img/bottle.png"),
    Wines(name: "Springbank 1998 #9101", image: "assets/img/bottle.png"),
    Wines(name: "Springbank 2000 #1121", image: "assets/img/bottle.png"),
    Wines(name: "Springbank 2003 #3141", image: "assets/img/bottle.png"),
    Wines(name: "Springbank 2006 #5161", image: "assets/img/bottle.png"),
    Wines(name: "Springbank 2009 #7181", image: "assets/img/bottle.png"),
    Wines(name: "Springbank 2012 #9202", image: "assets/img/bottle.png"),
    Wines(name: "Springbank 2015 #1223", image: "assets/img/bottle.png"),
    Wines(name: "Springbank 2018 #3242", image: "assets/img/bottle.png"),
  ];

*/
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Bottle 135/184',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: wineName,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' $yearOld Year old ',
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                code,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        CustomButton(
                          vertical: 0,
                          width: 300,
                          color: AppColors.primary,
                          fontSize: 12,
                          text: '+ Add to my collection',
                          onPressed: () {
                            //
                          },
                        ),

                        const SizedBox(height: 16),
                        //
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                vertical: 0,
                                width: 100,
                                color: index == 0
                                    ? AppColors.primary
                                    : Colors.transparent,
                                fontColor: index != 0 ? Colors.white54 : null,
                                fontSize: 12,
                                text: 'Details',
                                onPressed: () {
                                  setState(() {
                                    index = 0;
                                  });
                                },
                              ),
                              CustomButton(
                                vertical: 0,
                                width: 100,
                                color: index == 1
                                    ? AppColors.primary
                                    : Colors.transparent,
                                fontColor: index != 1 ? Colors.white54 : null,
                                fontSize: 12,
                                text: 'Comments',
                                onPressed: () {
                                  setState(() {
                                    index = 1;
                                  });
                                },
                              ),
                              CustomButton(
                                vertical: 0,
                                width: 100,
                                color: index == 2
                                    ? AppColors.primary
                                    : Colors.transparent,
                                fontColor: index != 2 ? Colors.white54 : null,
                                fontSize: 12,
                                text: 'History',
                                onPressed: () {
                                  setState(() {
                                    index = 2;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        //
                        index == 0
                            ? Column(
                                children: [
                                  _buildDetailRow('Distillery', 'Text'),
                                  _buildDetailRow('Region', 'Text'),
                                  _buildDetailRow('Country', 'Text'),
                                  _buildDetailRow('Type', 'Text'),
                                  _buildDetailRow('Age statement', 'Text'),
                                  _buildDetailRow('Filled', 'Text'),
                                  _buildDetailRow('Bottled', 'Text'),
                                  _buildDetailRow('Cask number', 'Text'),
                                  _buildDetailRow('ABV', 'Text'),
                                ],
                              )
                            : index == 1
                                ? Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: List.generate(5, (index) {
                                          return Icon(
                                            index < 4
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: Colors.amber,
                                            size: 26,
                                          );
                                        }),
                                      ),
                                      const SizedBox(height: 15),
                                      _buildComment("John Doe",
                                          "Amazing wine! Smooth and rich flavor."),
                                      _buildComment("Jane Smith",
                                          "Loved it! Perfect with steak."),
                                      _buildComment("Robert Johnson",
                                          "Nice balance, but a bit too dry for my taste."),
                                    ],
                                  )
                                : const Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "This bold California Cabernet Sauvignon boasts rich aromas of blackberries, cassis, and dark chocolate, with subtle hints of vanilla and toasted oak. On the palate, it delivers a full-bodied experience with velvety tannins and a lingering finish of ripe plum and espresso. Aged in French oak barrels, this wine pairs beautifully with grilled steak, aged cheeses, or hearty pasta dishes.",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildComment(String name, String comment) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          comment,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        const Divider(color: Colors.white24),
      ],
    ),
  );
}
