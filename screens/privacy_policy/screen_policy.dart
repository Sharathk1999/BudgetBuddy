import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenPolicy extends StatelessWidget {
  const ScreenPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy',style: GoogleFonts.mPlusCodeLatin(),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Text(
                    'Privacy Policy',
                    style: GoogleFonts.mPlusCodeLatin()
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'At Money Management App, we value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and disclose information when you use our app. By using our app, you consent to the terms of this Privacy Policy.',style: GoogleFonts.mPlusCodeLatin(fontSize: 12),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '1. Information Collection',
                    style:  GoogleFonts.mPlusCodeLatin(),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'We collect information that you provide to us when you sign up for an account, use our services, or communicate with us. This may include your name, email address, and other contact information.',style: GoogleFonts.mPlusCodeLatin(fontSize: 12)
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '2. Information Usage',
                    style:  GoogleFonts.mPlusCodeLatin(),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'We use the information we collect to provide, maintain, and improve our app and services. This may include personalizing your experience, sending you notifications, and analyzing usage patterns.',style: GoogleFonts.mPlusCodeLatin(fontSize: 12)
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '3. Information Sharing',
                    style:  GoogleFonts.mPlusCodeLatin(),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'We may share your information with third-party service providers who assist us in operating our app and providing services to you. We do not sell or rent your personal information to third parties without your consent, except as required by law.',style: GoogleFonts.mPlusCodeLatin(fontSize: 12)
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '4. Data Security',
                    style:  GoogleFonts.mPlusCodeLatin(),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'We take reasonable measures to protect your information from unauthorized access or disclosure. However, no data transmission over the internet or storage system can be guaranteed to be 100% secure.',style: GoogleFonts.mPlusCodeLatin(fontSize: 12)
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '5. Changes to this Policy',
                    style:  GoogleFonts.mPlusCodeLatin(),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes.',style: GoogleFonts.mPlusCodeLatin(fontSize: 12)
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '6. Contact Us',
                    style: GoogleFonts.mPlusCodeLatin()
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'If you have any questions or concerns about this Privacy Policy, please contact us at privacy@budgetbuddyapp.com.',style: GoogleFonts.mPlusCodeLatin(fontSize: 12)
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}