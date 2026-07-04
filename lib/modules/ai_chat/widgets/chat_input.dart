import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/ai_chat_controller.dart';

class ChatInput extends GetView<AiChatController> {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(0.08)),
        ],
      ),

      child: Row(
        children: [
          const Icon(Icons.attach_file, size: 30),

          const SizedBox(width: 14),

          Expanded(
            child: TextField(
              controller: controller.messageController,

              decoration: InputDecoration(
                border: InputBorder.none,

                hintText: "Ask HydroPure AI about your crops",

                hintStyle: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
          ),

          GestureDetector(
            onTap: controller.sendMessage,

            child: Container(
              width: 58,
              height: 58,

              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(18),
              ),

              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
