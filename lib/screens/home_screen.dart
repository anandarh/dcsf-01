import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:storyapp/models/story.dart';
import 'package:storyapp/services/story_service.dart';
import 'package:storyapp/services/token_service.dart';
import 'package:storyapp/utils/constants.dart';
import 'package:storyapp/widgets/loading_spinner.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Story>?> stories;

  @override
  void initState() {
    stories = getAllStories();
    super.initState();
  }

  void _logout(BuildContext context) async {
    await TokenService.deleteToken();
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stories'),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder(
        future: stories,
        builder: (context, snapshoot) {
          if (snapshoot.hasData) {
            return ListView.builder(
              itemCount: snapshoot.data?.length,
              itemBuilder: (context, index) {
                final story = snapshoot.data?[index];

                return Card(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => StoryDetailScreen(story: stories[index]),
                      //   ),
                      // );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CachedNetworkImage(
                          imageUrl: story?.photoUrl ?? placholderUrl,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                story?.name ?? 'Unknown Name',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                story?.description ?? '-',
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Created at: ${DateFormat('EEE, dd-MM-yyyy HH:mm').format(story!.createdAt)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (snapshoot.hasError) {
            return Center(
              child: Text(snapshoot.error.toString()),
            );
          }
          return const Center(
            child: LoadingSpinner(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your code to handle the camera button press here
        },
        child: const Icon(Icons.camera),
      ),
    );
  }

  Future<List<Story>?> getAllStories() async {
    final response = await StoryService.allStories();
    return response.listStory;
  }
}
