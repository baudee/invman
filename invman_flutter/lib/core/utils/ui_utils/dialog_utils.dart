import 'package:flutter/material.dart';

class PromptDialog {
  static Future<String?> show({
    required BuildContext context,
    required String title,
    required String labelText,
    String? Function(String?)? validator,
    bool obscureText = false,
    String? cancelText,
    String? confirmText,
    String initialValue = "",
    bool destructive = false,
    bool readOnly = false,
    bool multiline = false,
    bool onlyDigits = false,
  }) async {
    final GlobalKey<FormState> formKey = GlobalKey();

    final TextEditingController controller = TextEditingController(text: initialValue);

    final value = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
          ),
          title: Text(title),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  autofocus: true,
                  readOnly: readOnly,
                  minLines: multiline ? 3 : 1,
                  maxLines: multiline ? 3 : 1,
                  keyboardType: onlyDigits ? TextInputType.number : TextInputType.text,
                  decoration: InputDecoration(
                    label: Text(
                      labelText,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  validator: validator,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: Text(cancelText ?? "Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                final value = controller.value.text;

                Navigator.of(context).pop(value);
              },
              child: Text(confirmText ?? "Submit"),
            ),
          ],
        );
      },
    );

    return value?.toString();
  }
}
