import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 700;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 500 : double.infinity,
            ),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                if (theme.brightness == Brightness.light)
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/invenza.png",
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 16),
                Text(
                  "Create your account",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: "Email",
                  isPassword: false,
                  onChanged: authController.updateEmail,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: "Password",
                  isPassword: true,
                  onChanged: authController.updatePassword,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: "Confirm Password",
                  isPassword: true,
                  onChanged: authController.updateConfirmPassword,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ).copyWith(
                      backgroundColor:
                          MaterialStatePropertyAll(colorScheme.primary),
                      foregroundColor:
                          MaterialStatePropertyAll(colorScheme.onPrimary),
                    ),
                    onPressed: () {
                      authController.signup();
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(thickness: 1),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "OR",
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Divider(thickness: 1),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        ref.read(authControllerProvider.notifier).signInWithGoogle();
                      },
                        child: _socialIcon(
                            const Icon(FontAwesomeIcons.google, size: 24), theme)),
                    const SizedBox(width: 16),
                    _socialIcon(const Icon(FontAwesomeIcons.apple, size: 24), theme),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(Icon icon, ThemeData theme) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: icon,
      ),
    );
  }
}
