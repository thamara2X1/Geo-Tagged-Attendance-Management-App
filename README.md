# Geo-Tagged Attendance Management App

A Flutter app where employees check in and check out using their current GPS
location. Each attendance record captures the date, time, latitude, longitude,
and type (check in / check out). Built for the Era Biz Flutter intern assessment.

## Features

- Home screen with employee name, current date & time, and attendance status
- Check In / Check Out with geo-tagged location capture
- Attendance history showing all records (type, date, time, GPS coordinates)
- Attendance details screen for a selected record
- State management with Riverpod across all screens

## Tech Stack

- Flutter (stable)
- Riverpod (`flutter_riverpod`) for state management
- `geolocator` for real device GPS
- `intl` for date/time formatting
- `uuid` for unique record IDs

## Project Structure

```
lib/
├── models/       # AttendanceRecord and AttendanceType
├── services/     # Location service (mock + real geolocator)
├── providers/    # Riverpod state and notifier
├── screens/      # Home, History, Details
├── widgets/      # Reusable UI components
├── utils/        # Constants and date formatter
└── main.dart
```

The UI reads state from the Riverpod provider and calls actions on the notifier.
The notifier holds all business logic and talks to the location service. The UI
never accesses the location service directly.

## Requirements

- Flutter SDK 3.19.0 or higher (Dart >= 3.3.0)
- An Android emulator, iOS simulator, or physical device

## Setup

```bash
# 1. Clone the repository
git clone https://github.com/thamara2X1/Geo-Tagged-Attendance-Management-App.git
cd Geo-Tagged-Attendance-Management-App

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

## Assumptions

- **Location source:** A `MockLocationService` is active by default, returning a
  jittered coordinate near Colombo, Sri Lanka. This keeps demos reliable since
  emulator GPS can be inconsistent.
- **Persistence:** Records are held in memory and reset when the app closes. The
  model includes `toJson` / `fromJson` so persistence (e.g. SharedPreferences)
  can be added without changing other layers. No backend is used, per the task.
- **Check in / out logic:** The current status is derived from the most recent
  record. On first launch, before any record exists, the status shows
  "Not Marked Yet".
- **Employee:** A single hard-coded employee is used, as the task does not
  require authentication or multiple users.

## Real GPS Permissions

If switching to `GeolocatorLocationService`, the following are already set up:

- Android: `ACCESS_FINE_LOCATION` and `ACCESS_COARSE_LOCATION` in
  `AndroidManifest.xml`
- iOS: `NSLocationWhenInUseUsageDescription` in `Info.plist`