# Briefly.

A cross-platform news application built with Flutter that delivers bite-sized, categorized news updates. Designed with a clean, dark-themed UI to provide quick summaries across various topics like Tech, Sports, Politics, Crypto, and Design.

### Academic Submission Details

* **Group Number:** 5
* **Group Members:**
1. Syed Ali Imran
2. Abdul Rafay
3. Sibtain Ahmed
4. Mehmood Rashid

---

## Features

* **Categorized Feeds:** Filter news by domains (Tech, Sports, Politics, etc.).
* **Bite-sized Content:** Summarized news cards for quick reading.
* **Modern UI:** Dark mode interface with distinct category pills.
* **Cross-Platform:** Built with Flutter, supporting web and mobile deployment.

---

## Visuals

### App Interface

Below is a preview of the web application running locally, showcasing the Tech news feed.

<img width="1915" height="994" alt="image" src="https://github.com/user-attachments/assets/8560fa93-03e1-4b86-8d49-a52a012059e1" />

---

## Core Implementation

### Category State Management

```dart
class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<String> categories = ['Tech', 'Sports', 'Politics', 'Crypto', 'Design'];
  String selectedCategory = 'Tech';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: selectedCategory == categories[index],
              onSelected: (selected) {
                setState(() {
                  selectedCategory = categories[index];
                });
              },
            ),
          );
        },
      ),
    );
  }
}

```

### News Card UI Component

```dart
class NewsCard extends StatelessWidget {
  final String title;
  final String description;

  const NewsCard({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: const Color(0xFF1E1E2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

---

## Tech Stack

* **Framework:** Flutter
* **Language:** Dart

---

## Getting Started

To run this project locally:

1. Clone the repository:

```bash
git clone https://github.com/alivmran/briefly.git

```

2. Navigate to the project directory:

```bash
cd briefly

```

3. Install dependencies:

```bash
flutter pub get

```

4. Run the application:

```bash
flutter run

```
