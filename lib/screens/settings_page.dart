// pengaturan_page.dart
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifikasi = true;
  bool modeMalam = false;
  bool suara = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text("Pengaturan"),
        backgroundColor: Color(0xFF667eea),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            "Umum",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          SizedBox(height: 12),
          _buildSettingCard(
            "Notifikasi",
            "Terima notifikasi pembelajaran",
            Icons.notifications,
            Switch(
              value: notifikasi,
              onChanged: (value) {
                setState(() {
                  notifikasi = value;
                });
              },
              activeColor: Color(0xFF667eea),
            ),
          ),
          _buildSettingCard(
            "Mode Malam",
            "Aktifkan tema gelap",
            Icons.dark_mode,
            Switch(
              value: modeMalam,
              onChanged: (value) {
                setState(() {
                  modeMalam = value;
                });
              },
              activeColor: Color(0xFF667eea),
            ),
          ),
          _buildSettingCard(
            "Suara",
            "Efek suara aplikasi",
            Icons.volume_up,
            Switch(
              value: suara,
              onChanged: (value) {
                setState(() {
                  suara = value;
                });
              },
              activeColor: Color(0xFF667eea),
            ),
          ),
          SizedBox(height: 24),
          Text(
            "Akun",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          SizedBox(height: 12),
          _buildSettingItem(context, "Edit Profil", Icons.person, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilPage()),
            );
          }),
          _buildSettingItem(context, "Ganti Password", Icons.lock, () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Fitur Ganti Password"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }),
          _buildSettingItem(context, "Bahasa", Icons.language, () {
            _showLanguageDialog(context);
          }),
          _buildSettingItem(context, "Bantuan", Icons.help, () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Pusat Bantuan"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }),
          _buildSettingItem(context, "Tentang Aplikasi", Icons.info, () {
            _showAboutDialog(context);
          }),
          SizedBox(height: 12),
          _buildSettingItem(context, "Keluar", Icons.logout, () {
            _showLogoutDialog(context);
          }, isDestructive: true),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: 2,
          onTap: (index) {
            if (index == 0) {
              Navigator.pop(context);
            } else if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => KuisPage()),
              );
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF667eea),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz_rounded),
              label: "Kuis",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: "Pengaturan",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(
    String title,
    String subtitle,
    IconData icon,
    Widget trailing,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Icon(icon, color: Color(0xFF667eea)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12)),
        trailing: trailing,
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : Color(0xFF667eea),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDestructive ? Colors.red : Colors.black,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Pilih Bahasa"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Text("🇮🇩", style: TextStyle(fontSize: 24)),
                  title: Text("Bahasa Indonesia"),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Bahasa diubah ke Indonesia")),
                    );
                  },
                ),
                ListTile(
                  leading: Text("🇬🇧", style: TextStyle(fontSize: 24)),
                  title: Text("English"),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Language changed to English")),
                    );
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Tentang Aplikasi"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Education App",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text("Versi: 1.0.0"),
                SizedBox(height: 8),
                Text("Aplikasi pembelajaran interaktif untuk siswa"),
                SizedBox(height: 16),
                Text("© 2024 Education App"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Tutup"),
              ),
            ],
          ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Keluar"),
            content: Text("Apakah Anda yakin ingin keluar?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Batal"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Berhasil keluar"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Text("Keluar", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }
}

// Import classes untuk navigasi
class KuisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kuis")),
      body: Center(child: Text("Halaman Kuis")),
    );
  }
}

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil")),
      body: Center(child: Text("Halaman Profil")),
    );
  }
}
