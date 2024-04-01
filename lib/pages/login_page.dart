import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _infoController = TextEditingController();

  Future Add() async {
    await FirebaseFirestore.instance.collection('users').add({
      'info': _infoController.text.trim(),
      'timestamp': Timestamp.now(),
    });
  }

  @override
  void dispose() {
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 200),
                    Icon(Icons.person_rounded, color: Colors.grey[400], size: 115),
                    const SizedBox(height: 100),
                    const Text(
                      'HELLO',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Напиши любую информацию',
                      style: TextStyle(
                        fontSize: 19.5,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blueGrey[0]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextField(
                            controller: _infoController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Information',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => const HomePage()
                          )
                          );
                          Add();
                        },
                        child: Container(
                          padding:  const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blueGrey[100]
                          ),
                          child: Center(
                            child: Text(
                              'Продолжить',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          )
      ),
    );
  }
}