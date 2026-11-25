import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/widget/responsive_font.dart';
import '../../../core/widget/screen_helper.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  // ✅ Added Instagram URLs to the data list
  final List<Map<String, String>> _listMember = const [
    {
      "name": "Shreyansh Gupta",
      "image": "assets/management/shiv.png",
      "designation": "Head Of Teacher",
      "instagram": "https://www.instagram.com/sh.reyansh7166?psln=Z2tmNGIzZTU1bmph"
    },
    {
      "name": "Krishnakant Jatav",
      "image": "assets/management/krish.jpeg",
      "designation": "Head Of Management",
      "instagram": "https://www.instagram.com/lm_krishnakant?dlrf=MXNqYWsyam5tcDJ3YQ=="
    },
    {
      "name": "Akshay Panika",
      "image": "assets/management/akshay.jpeg",
      "designation": "Developer",
      "instagram": "https://www.instagram.com/akshay_panika?mdxt=MWtyZ2d4em14dDJnYw=="
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 50,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: ScreenHelper.isMobile(context) ? 12 : 50),
            child: Row(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Navo',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextSpan(
                        text: 'Study',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: ' Team',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),

          // 🟢 CARDS WITH HOVER & TAP ANIMATION
          SizedBox(
            height: ScreenHelper.isMobile(context) ? 220 : 240,
            child: Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(_listMember.length, (index) {
                return _AnimatedTeamCard(
                  member: _listMember[index],
                  index: index,
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// =========================================================
// 🟢 NEW ANIMATED CARD WIDGET
// =========================================================
class _AnimatedTeamCard extends StatefulWidget {
  final Map<String, String> member;
  final int index;

  const _AnimatedTeamCard({
    required this.member,
    required this.index,
  });

  @override
  State<_AnimatedTeamCard> createState() => _AnimatedTeamCardState();
}

class _AnimatedTeamCardState extends State<_AnimatedTeamCard> {
  bool _isHovered = false;
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    double scale = 1.0;
    if (_isHovered && !_isTapped) {
      scale = 1.03;
    } else if (_isTapped) {
      scale = 0.97;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isTapped = true),
        onTapUp: (_) => setState(() => _isTapped = false),
        onTapCancel: () => setState(() => _isTapped = false),
        onTap: () {
          // Card par click karne ka logic (agar zarurat ho)
        },
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: ScreenHelper.isMobile(context) ? 320 : 380,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered
                    ? Colors.blue
                    : Colors.blue.withOpacity(0.15),
                width: _isHovered ? 1 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(_isHovered ? 0.2 : 0.08),
                  blurRadius: _isHovered ? 30 : 20,
                  spreadRadius: _isHovered ? 2 : 0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar with Edit (Pen) Badge
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: ScreenHelper.isMobile(context) ? 40 : 50,
                        backgroundColor: Colors.blue.shade50,
                        backgroundImage: AssetImage(widget.member['image']!),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 16),

                // Right Side Details
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        widget.member['name']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize:
                          RFont.size(context, 16, tablet: 18, desktop: 20),
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Designation
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.member['designation']!,
                          style: TextStyle(
                            fontSize:
                            RFont.size(context, 10, tablet: 12, desktop: 13),
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ✅ Social Icons with URLs
                      Row(
                        spacing: 10,
                        children: [
                          _buildSocialIcon(
                            FontAwesomeIcons.instagram,
                            url: widget.member['instagram'], // Passing Instagram URL
                          ),
                          _buildSocialIcon(FontAwesomeIcons.facebook),
                          _buildSocialIcon(FontAwesomeIcons.linkedin),
                          _buildSocialIcon(FontAwesomeIcons.globe),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // ✅ UPDATED URL / Link Button
                      InkWell(
                        onTap: () async {
                          // Yahan 'View Profile' par click karne se Instagram link open hoga
                          final url = widget.member['instagram'];
                          if (url != null && url.isNotEmpty) {
                            final Uri uri = Uri.parse(url);
                            if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                              debugPrint('Could not launch $url');
                            }
                          }
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.blue, width: 1.2),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.link,
                                  size: 14, color: Colors.blue),
                              const SizedBox(width: 6),
                              Text(
                                "View Profile",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: RFont.size(context, 11,
                                      tablet: 12, desktop: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Social Icon builder
  Widget _buildSocialIcon(FaIconData icon, {String? url}) {
    return InkWell(
      onTap: () async {
        if (url != null && url.isNotEmpty) {
          final Uri uri = Uri.parse(url);
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            debugPrint('Could not launch $url');
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: FaIcon(
          icon,
          size: 14,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}