import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_billing_app/features/ui/signup_screen.dart';
import '../../widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 700;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2074B5), Color(0xFFF59230)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              constraints:
              BoxConstraints(maxWidth: isDesktop ? 480 : double.infinity),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: isDesktop
                    ? Colors.white.withOpacity(0.1)
                    : theme.cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: isDesktop
                      ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                      : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width:200,
                          child:Image.asset("assets/invenza.png")
                        ),
                        Center(
                          child: Text(
                            "Welcome Back 👋",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Center(
                          child: Text(
                            "Login to continue",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const CustomTextField(
                          label: "Email Address",
                          isPassword: false,
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 16),
                        const CustomTextField(
                          label: "Password",
                          isPassword: true,
                          icon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                          //    ref.read(authControllerProvider.notifier).login();
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                              const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const SignupScreen()),
                              );
                            },
                            child: Text(
                              "Don't have an account? Sign up",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
