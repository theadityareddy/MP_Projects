import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

class VissionMissionPage extends StatelessWidget {
  const VissionMissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildCard(
          "DEPARTMENT VISION",
          "To develop globally competent and ethical professionals in Computer Science and Engineering and enable them to contribute to society.",
        ),
        _buildCard(
          "DEPARTMENT MISSION",
          "- To provide high quality education.\n"
              "- To train the students to excel in cutting edge technologies that makes them industry ready.\n"
              "- To inculcate ethical and professional values in students for betterment of society.\n"
              "- To inculcate Entrepreneurial mindset in students to make them job creators.",
        ),
        _buildCard(
          "PEO OF THE DEPARTMENT",
          "- To recognize and adopt social and ethical issues in computing.\n"
              "- To become an effective presenter to work as a responsible team leader.\n"
              "- To apply knowledge in order to solve real world problems.",
        ),
        _buildCard(
          "PROGRAM OUTCOMES",
          "1. Computational Knowledge: Apply knowledge of computing fundamentals, computing specialization, mathematics, and domain knowledge appropriate for problem-solving technique to formulate solution for Information System.   \n"
              "2. Problem Analysis: Conceptualize knowledge and background to be able to analyze a problem and identify and define the computing requirements for its solution.   \n"
              "3. Design / Development of Solutions: Design a new system to meet certain specification.\n"
              "4. Conduct Investigations of complex computing problems: Conduct investigations of complex problems using analysis, modelling, interpretation of data, and synthesis of information in order to reach valid conclusions.\n"
              "5. Modern Tool Usage: Design, monitor, manage, test, control, evaluate an existing computer-based system, process, component or program and provide valid conclusions using software modeling, warehousing, mining and networking tools for application development.\n"
              "6. Professional Ethics: Apply ethical principles and adhere to professional ethics and responsibilities and norms of Application Development.   \n"
              "7. Life-long Learning: Recognize the need for and an ability to engage in lifelong learning.\n"
              "8. Project management and finance: Demonstrate knowledge and understanding of IT and management principles and apply these to one’s own work, as a member or a leader of the team, to manage IT projects.\n"
              "9. Communication Efficacy: Communicate effectively using classic and modern technology with the IT professionals and with society at large through report writing as well as technical presentations.\n"
              "10. Societal and Environmental Concern: Understand the impact of the applications and services in societal and environmental contexts, and exhibit the knowledge of, and need for sustainable development.\n"
              "11. Individual and Team Work: Function effectively as an individual, and as a member or leader of a team.\n"
              "12. Innovation and Entrepreneurship: Create an opportunity to produce successful Entrepreneurs.",
        ),
        _buildCard(
          "MCA PROGRAM SPECIFIC OUTCOMES",
          "Students will be able to Apply standard practices and strategies required for the industry.\nStudents will be able to Solve real-world problems using cutting-edge technology.",
        ),
        // Add a clickable link at the bottom
        const SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () {
              // Open the SPIT Vision and Mission webpage
              _launchUrl("https://mca.spit.ac.in/index.php/vision-mission-2/");
            },
            child: const Text(
              "Visit SPIT Vision & Mission Page",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String title, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700]),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Function to launch a URL
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}