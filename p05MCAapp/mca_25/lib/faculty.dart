import 'package:flutter/material.dart';

class Faculty {
  final String name;
  final String position;
  final String imageUrl;
  final String qualification;
  final String additionalInfo;

  const Faculty({
    required this.name,
    required this.position,
    required this.imageUrl,
    required this.qualification,
    required this.additionalInfo,
  });
}

class FacultyPage extends StatelessWidget {
  const FacultyPage({Key? key}) : super(key: key);

  static const List<Faculty> _faculties = [
    Faculty(
      name: "Prof. Dr. Dhananjay Kalbande",
      position: "Head Of Department",
      imageUrl: "assets/images/ddk.jpeg",
      qualification: "Post-Doctorate (TISS), Ph.D.,M.E.(I.T.),",
      additionalInfo:
      "Senior Research Fellow (NCW-TISS Project,T.I.S.S., Mumbai)",
    ),
    Faculty(
      name: "Prof. Dr. Pooja Raundale",
      position: "Professor",
      imageUrl: "assets/images/dpr.jpg",
      qualification: "PH.D. (Comp. Sci. & Tech) SNDT Women’s University",
      additionalInfo: "Area of Interest: AI/ML, Data Science",
    ),
    Faculty(
      name: "Prof. Dr. Aarti Karande",
      position: "Assistant Professor",
      imageUrl: "assets/images/dak.png",
      qualification: "Ph.D (Computer engineering from S.P.I.T.)",
      additionalInfo:
      "Additional Qualifications: Agile Foundation Certified, COBIT 5 Certified",
    ),
    Faculty(
      name: "Prof. Harshil Kanakia",
      position: "Assistant Professor",
      imageUrl: "assets/images/HK.png",
      qualification: "Executive PG in Data Science (IIIT Bangalore)",
      additionalInfo:
      "Area of Interest: Data Structures & Algorithms, Automation Programming",
    ),
    Faculty(
      name: "Prof. Nikhita Mangaonkar",
      position: "Assistant Professor",
      imageUrl: "assets/images/nm.jpg",
      qualification: "Master in Computer Application",
      additionalInfo:
      "Area of Interest: Software Project Management, Software Testing & Quality Assurance",
    ),
    Faculty(
      name: "Prof. Sakina Shaikh",
      position: "Assistant Professor",
      imageUrl: "assets/images/ss.png",
      qualification: "M.E. Computers (DJSCOE)",
      additionalInfo:
      "Area of Interest: Cyber Security, User Experience Design",
    ),
    Faculty(
      name: "Prof. Pallavi Thakur",
      position: "Assistant Professor",
      imageUrl: "assets/images/pt.png",
      qualification: "M.E. IT",
      additionalInfo: "Area of Interest: Computer Networks, Web Technology",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _faculties.length,
            itemBuilder: (context, index) {
              return FacultyCard(faculty: _faculties[index]);
            },
          ),
        ),
      ],
    );
  }
}

class FacultyCard extends StatefulWidget {
  final Faculty faculty;

  const FacultyCard({required this.faculty, Key? key}) : super(key: key);

  @override
  _FacultyCardState createState() => _FacultyCardState();
}

class _FacultyCardState extends State<FacultyCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.faculty.imageUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.faculty.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.faculty.position,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.blue[700],
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 8),
              Text(
                "Qualification: ${widget.faculty.qualification}",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "Additional Info: ${widget.faculty.additionalInfo}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}