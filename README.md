# NomadGuide 🗺️✈️

**NomadGuide** is a modern, immersive, and premium travel companion application built with Flutter. It is designed specifically to guide travelers exploring the rich tourism destinations of India, featuring beautiful layouts, interactive route mapping, and personalized favorites tracking.

---

## ✨ Features

### 🎬 1. Cinematic Splash Screen
* **Stunning Background**: Full-screen atmospheric travel photography (via Unsplash).
* **Elegant Visuals**: Dynamic "Nomad Guide" logo styled with a premium gold-to-white gradient.
* **Fluid Gestures**: A custom interactive "Slide to Get Started" slider to enter the app seamlessly.

### 🔍 2. Modern Discover Screen
* **Taj Mahal Header**: A vibrant header background featuring the Taj Mahal overlaid with a subtle dark gradient for high readability.
* **Welcoming UI**: Personalized "Hello, Traveler" section with a clean floating search bar.
* **Tourism Search**: Interactive search engine to instantly pull up places across India.
* **"Bucket List" Grid**: Beautiful cards showcasing recommended destinations.

### 🗺️ 3. Interactive Map Screen (OpenStreetMap)
* **Route Mapping**: Automatically draws route paths from your current position/origin to the selected tourism destination.
* **Nearby Hotels**: Displays local hotels on the map near your chosen destination, enabling easy planning without relying on heavy paid APIs.
* **Custom Markers**: Clear, visible pins for user location, destination, and hotels.

### 👤 4. Professional Profile Screen
* **Scenic Avatar Backdrop**: A premium nature/adventure background behind the profile avatar.
* **Travel Stats Dashboard**: Tracks traveler progress with stats cards showing:
  * **Saved Places** count
  * **Visited Places** count
  * **Ranking Badge**
* **Postcard Favorites**: A custom grid of favorited places styled like collectible travel postcards.

### 🎨 5. Premium Styling & Themes
* **Vivid Blue Accent**: Tailored HSL color palette featuring Vivid Blue (`#0066CC`) and smooth gradient transitions.
* **Material 3 Design**: Card elevation, rounded corners, clean icons, and modern typography using the latest Flutter components.

---

## 🛠️ Project Structure

```text
lib/
├── core/
│   ├── constants/       # API keys and constants
│   └── theme/           # Premium AppTheme configuration
├── models/              # Country and destination data structures
├── providers/           # Favorites and State management (ChangeNotifier)
├── services/            # Custom API client and country data service
├── widgets/             # Reusable UI components (CountryCard, etc.)
└── screens/
    ├── splash/          # Cinematic Splash Screen
    ├── home/            # App Shell with bottom navigation
    ├── discover/        # Search and place discovery
    ├── map/             # Map screen and route tracking
    └── profile/         # Professional user profile
```

---

## 🚀 Getting Started

### Prerequisites
Make sure you have the following installed on your machine:
* [Flutter SDK](https://docs.flutter.dev/get-started/install) (version ^3.22.0 or higher)
* [Dart SDK](https://dart.dev/get-started) (version ^3.8.1)
* [Git](https://git-scm.com/)

### Installation & Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/pavanidurga2a9/NomadGuide.git
   cd NomadGuide
   ```

2. **Fetch the dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app on a connected device/emulator:**
   ```bash
   flutter run
   ```

---

## 📦 Dependencies

This app uses these popular Dart packages:
* `flutter_map` - For OpenStreetMap integration.
* `latlong2` - For map coordinates calculations.
* `http` - For network requests.
* `url_launcher` - For opening maps and web links.
* `shared_preferences` - For persistent local storage of favorites.

---

## 🤝 License

This project is open-source. Feel free to use and modify it for your own travel adventures!
```
