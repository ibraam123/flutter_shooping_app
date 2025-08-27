import 'package:flutter/material.dart';
import 'package:flutter_shooping_app/view/sign_in_view.dart';
import 'package:flutter_shooping_app/view/sign_up_view.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Roma Shop',
          style: TextStyle(
            fontFamily: 'Suwannaphum-Regular',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Roma Shop!',
              style: TextStyle(
                fontFamily: 'Suwannaphum-Regular',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120, // Adjust size as needed
                  height: 120, // Adjust size as needed
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/download.jpeg',
                      ), //  Replace with your local image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 120, // Adjust size as needed
                  height: 120, // Adjust size as needed
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.network(
                      'https://picsum.photos/seed/picsum/120/120', // Replace with your online image URL, adjusted size
                      fit: BoxFit.cover,
                      loadingBuilder:
                          (
                            BuildContext context,
                            Widget child,
                            ImageChunkEvent? loadingProgress,
                          ) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                      errorBuilder:
                          (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                          ) {
                            return const Text('Failed to load image');
                          },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpView(),
                      ),
                    );
                  },
                  child: const Text('Sign-up'),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInView(),
                      ),
                    );
                  },
                  child: const Text('Sign-in'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
