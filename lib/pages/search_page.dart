import 'package:bored_api_test/api/activities_service.dart';
import 'package:bored_api_test/widget/appbar_title.dart';
import 'package:bored_api_test/widget/grey_line.dart';
import 'package:flutter/material.dart';

import '../model/activity_model.dart';
import '../model/search_button_model.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final activityService = ActivitiesServices();
  late Future<Activity> activity;
  List<String> favoriteActivities = [];

  @override
  void initState() {
    super.initState();
    activity = activityService.getActivity();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          centerTitle: true,
          title: AppBarTitle(),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    const Text(
                      'Your activity of the day is:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 36),
                    FutureBuilder<Activity>(
                      future: activity,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          final String activity = snapshot.data!.activity;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                favoriteActivities.add(activity);
                              });
                            },
                            // Contenitore bianco sfumato che mostra attività
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 20,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Text(
                                activity,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // In attesa di ricevere l'Attività appare Loading...
                          return const Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    const SizedBox(height: 48),
                    GreyLine(),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 24,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Favorite activities:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Text('(click to add)'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Lista delle Attività preferite
                    Expanded(
                      child: ListView.builder(
                        itemCount: favoriteActivities.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 8,
                            ),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child: Text(
                              favoriteActivities[index],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GreyLine(),
                    // Pulsante utilizzato per ottenere attività casuali
                    SearchButtonModel(
                      titleButton: 'Random Activity',
                      colorButton: Colors.green,
                      functionButton: () {
                        setState(() {
                          activity = activityService.getActivity();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
