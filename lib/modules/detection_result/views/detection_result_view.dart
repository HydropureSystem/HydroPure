import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme/app_colors.dart';

import '../controllers/detection_result_controller.dart';
import '../widgets/recommendation_card.dart';

class DetectionResultView
    extends GetView<DetectionResultController> {

  const DetectionResultView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              /// HEADER
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "HydroPure",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  const Icon(
                    Icons.person_outline,
                    size: 30,
                  )
                ],
              ),

              const SizedBox(height: 24),

              /// DETECTION CARD
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(34),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    /// IMAGE
                    Stack(
                      children: [

                        ClipRRect(
                          borderRadius:
                              const BorderRadius.only(
                            topLeft:
                                Radius.circular(34),
                            topRight:
                                Radius.circular(34),
                          ),

                          child: Image.asset(
                            'assets/images/pest_bg.jpg',
                            width: double.infinity,
                            height: 260,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Positioned(
                          top: 18,
                          right: 18,

                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.circular(
                                      20),
                            ),

                            child: Row(
                              children: [

                                const Icon(
                                  Icons.warning_amber,
                                  color: Colors.white,
                                  size: 18,
                                ),

                                const SizedBox(width: 6),

                                Text(
                                  "Critical",
                                  style:
                                      GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.all(24),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            "DETECTION RESULT",
                            style: GoogleFonts.poppins(
                              letterSpacing: 2,
                              fontSize: 12,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                            children: [

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    Text(
                                      "Pest Detected:",
                                      style:
                                          GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight:
                                            FontWeight
                                                .w600,
                                      ),
                                    ),

                                    Text(
                                      controller
                                          .pestName.value,

                                      style:
                                          GoogleFonts.poppins(
                                        fontSize: 26,
                                        color: Colors.red,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: 64,
                                height: 64,

                                decoration:
                                    BoxDecoration(
                                  color:
                                      Colors.red.shade100,
                                  borderRadius:
                                      BorderRadius
                                          .circular(18),
                                ),

                                child: const Icon(
                                  Icons.bug_report,
                                  color: Colors.red,
                                  size: 34,
                                ),
                              )
                            ],
                          ),

                          const SizedBox(height: 18),

                          Text(
                            controller.description.value,

                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              height: 1.8,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 26),

              /// AI TREATMENT
              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green.shade300,
                  ),

                  borderRadius:
                      BorderRadius.circular(28),
                ),

                child: Column(
                  children: [

                    Row(
                      children: [

                        Container(
                          width: 58,
                          height: 58,

                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius:
                                BorderRadius.circular(
                                    16),
                          ),

                          child: const Icon(
                            Icons.smart_toy_outlined,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                "AI Treatment Strategy",

                                style:
                                    GoogleFonts.poppins(
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      AppColors.primary,
                                ),
                              ),

                              Text(
                                "Optimized for your specific reservoir pH levels",

                                style:
                                    GoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 18),

                    Container(
                      padding:
                          const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,

                        borderRadius:
                            BorderRadius.circular(20),
                      ),

                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          const Icon(
                            Icons.check_circle_outline,
                            color: AppColors.primary,
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Text(
                              "Organic Neem oil solution at 0.5% concentration recommended for your current growth stage.",

                              style:
                                  GoogleFonts.poppins(
                                fontSize: 16,
                                height: 1.7,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// CARE RECOMMENDATION
              Text(
                "Care Recommendations",

                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              RecommendationCard(
                title:
                    controller.recommendations[0]
                        ['title'],
                desc:
                    controller.recommendations[0]
                        ['desc'],
                icon: Icons.eco_outlined,
                bgColor: Colors.green.shade200,
              ),

              RecommendationCard(
                title:
                    controller.recommendations[1]
                        ['title'],
                desc:
                    controller.recommendations[1]
                        ['desc'],
                icon: Icons.water_drop_outlined,
                bgColor: Colors.green.shade200,
              ),

              RecommendationCard(
                title:
                    controller.recommendations[2]
                        ['title'],
                desc:
                    controller.recommendations[2]
                        ['desc'],
                icon: Icons.cleaning_services_outlined,
                bgColor: Colors.grey.shade300,
              ),

              const SizedBox(height: 34),

              /// BUTTONS
              Row(
                children: [

                  Expanded(
                    child: SizedBox(
                      height: 62,

                      child: ElevatedButton.icon(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.primary,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    20),
                          ),
                        ),

                        onPressed: () {},

                        icon: const Icon(
                          Icons.save_alt,
                          color: Colors.white,
                        ),

                        label: Text(
                          "Save Result",

                          style:
                              GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: SizedBox(
                      height: 62,

                      child: OutlinedButton.icon(
                        style:
                            OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    20),
                          ),
                        ),

                        onPressed: () {},

                        icon: const Icon(
                          Icons.chat_bubble_outline,
                          color: AppColors.primary,
                        ),

                        label: Text(
                          "Consult AI",

                          style:
                              GoogleFonts.poppins(
                            color: AppColors.primary,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}