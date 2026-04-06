import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentapp/routing/app_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Image.asset('assets/onboarding.png'),
          Text(
            'Premium cars,\nAffordable prices',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 37,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),

          Text(
            'Premium cars for rent at affordable prices\nExperience the best car rental service with us',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          SizedBox(height: 50),

          ElevatedButton(
            onPressed: () {
              context.go(AppRoutes.authPath);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
            ),
            child: Text(
              'Explore Cars',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
