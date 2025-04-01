import 'package:app/components/customButton.dart';
import 'package:app/models/item.dart';
import 'package:app/utils/assets.dart';
import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Details extends StatefulWidget {
  final ItemModel wines;
  final int index;
  const Details({super.key, required this.wines, required this.index});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late YoutubePlayerController _youtubeController;

  @override
  void dispose() {
    _tabController.dispose();
    _youtubeController.dispose();
    super.dispose();
  }

  int index = 0;

  String wineName = '';
  String yearOld = '';
  String code = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'KPjrzhS17Vk',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
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
                            Fluttertoast.showToast(
                                msg: "+ Adding to my Collection",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
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
                                text: 'Description',
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
                                ? _buildDescriptionTab(_youtubeController)
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.black),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Title',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            const Text('Description',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white54)),
                                            const Text('Description',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white54)),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.attach_file)),
                                                const Text(
                                                  'Attachments',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white60,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                _buildAttachmentBox(),
                                                const SizedBox(width: 10),
                                                _buildAttachmentBox(),
                                                const SizedBox(width: 10),
                                                _buildAttachmentBox(),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Title',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            const Text(
                                              'Description',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white54),
                                            ),
                                            const Text('Description',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white54)),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.attach_file)),
                                                const Text(
                                                  'Attachments',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white60,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                _buildAttachmentBox(),
                                                const SizedBox(width: 10),
                                                _buildAttachmentBox(),
                                                const SizedBox(width: 10),
                                                _buildAttachmentBox(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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

Widget _buildDescriptionTab(YoutubePlayerController youtubeController) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: YoutubePlayer(
            controller: youtubeController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blue,
          ),
        ),
        const Text(
          'Tasting notes',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'by Charles MacLean MBE',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 16),

        // Nose
        const Text(
          'Nose',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Rich and fruity with a hint of smoke.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white54,
          ),
        ),
        const Text(
          'Notes of dried fruit and spice.',
          style: TextStyle(fontSize: 14, color: Colors.white54),
        ),
        const Text(
          'Subtle maritime influence.',
          style: TextStyle(fontSize: 14, color: Colors.white54),
        ),
        const SizedBox(height: 16),

        // Palate
        const Text(
          'Palate',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Full-bodied with peppery spice.',
          style: TextStyle(fontSize: 14, color: Colors.white54),
        ),
        const Text(
          'Sweet malt and dried fruit flavors.',
          style: TextStyle(fontSize: 14, color: Colors.white54),
        ),
        const Text(
          'Distinctive smoky character.',
          style: TextStyle(fontSize: 14, color: Colors.white54),
        ),
        const SizedBox(height: 16),

        // Finish
        const Text(
          'Finish',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white60,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Long and warming.',
          style: TextStyle(fontSize: 14, color: Colors.white54),
        ),
        const Text(
          'Peppery with lingering smoke.',
          style: TextStyle(fontSize: 14, color: Colors.white54),
        ),
        const Text(
          'Slightly sweet at the very end.',
          style: TextStyle(fontSize: 14, color: Colors.white54),
        ),
        const SizedBox(height: 16),

        // Your Notes
        const Text(
          'Your notes',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}

Widget _buildAttachmentBox() {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
  );
}
