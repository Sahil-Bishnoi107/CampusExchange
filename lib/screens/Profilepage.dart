import 'package:ecommerceapp/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(height: 1,color: const Color.fromRGBO(200, 200, 200, 1),)),
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final user = userProvider.user;

          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Container(width: double.infinity,height: 1,color: const Color.fromRGBO(200, 200, 200, 1),),
                // Profile Header
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 231, 244, 254),
                   // borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: user.profilePic != null && user.profilePic!.isNotEmpty
                                ? NetworkImage(user.profilePic!)
                                : null,
                            child: user.profilePic == null || user.profilePic!.isEmpty
                                ? const Icon(Icons.person, size: 50, color: Colors.grey)
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.username ?? 'User Name',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.university ?? 'University',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Personal Information Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Text(
                          'Personal Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name
                      _buildInfoRow(
                        'Name',
                        user.username ?? 'N/A',
                        showEdit: true,
                      ),
                      const Divider(height: 32, indent: 24, endIndent: 24),

                      // University
                      _buildInfoRow(
                        'University',
                        user.university ?? 'N/A',
                        showEdit: true,
                      ),
                      const Divider(height: 32, indent: 24, endIndent: 24),

                      // Email
                      _buildInfoRow(
                        'Email',
                        user.email ?? 'N/A',
                        showEdit: false,
                      ),
                      const Divider(height: 32, indent: 24, endIndent: 24),

                      // Phone
                      _buildInfoRow(
                        'Phone',
                        user.phone ?? 'N/A',
                        showEdit: false,
                      ),
                      const Divider(height: 32, indent: 24, endIndent: 24),

                      // Address
                      _buildInfoRow(
                        'Address',
                        user.address ?? 'N/A',
                        showEdit: false,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Account Settings Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildSettingsOption(
                        icon: Icons.lock_outline,
                        iconColor: const Color(0xFF9C27B0),
                        title: 'Change Password',
                        onTap: () {
                          // TODO: Implement change password
                        },
                      ),
                      const SizedBox(height: 8),

                      _buildSettingsOption(
                        icon: Icons.shield_outlined,
                        iconColor: const Color(0xFF9C27B0),
                        title: 'Privacy Settings',
                        onTap: () {
                          // TODO: Implement privacy settings
                        },
                      ),
                      const SizedBox(height: 8),

                      _buildSettingsOption(
                        icon: Icons.notifications_outlined,
                        iconColor: const Color(0xFF9C27B0),
                        title: 'Notifications',
                        onTap: () {
                          // TODO: Implement notifications
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // App Preferences Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Text(
                          'App Preferences',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildSettingsOption(
                        icon: Icons.settings_outlined,
                        iconColor: const Color(0xFF9C27B0),
                        title: 'General Settings',
                        onTap: () {
                          // TODO: Implement general settings
                        },
                      ),
                      const SizedBox(height: 8),

                      _buildSettingsOption(
                        icon: Icons.help_outline,
                        iconColor: const Color(0xFF9C27B0),
                        title: 'Help & Support',
                        onTap: () {
                          // TODO: Implement help & support
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Logout Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement logout
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B9D),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.logout, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Footer
               
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool showEdit = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (showEdit)
            TextButton(
              onPressed: () {
                // TODO: Implement edit functionality
              },
              child: const Text(
                'Edit',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}