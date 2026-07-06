# Geo-Tagged Attendance Management App

A Flutter app where employees check in and check out using their current GPS
location. Each attendance record captures the date, time, latitude, longitude,
and type (check in / check out). Built for the Era Biz Flutter intern assessment.

## Features

- Home screen with employee name, live date & time, and attendance status
- Check In / Check Out with geo-tagged location capture
- Attendance history showing all records (type, date, time, GPS coordinates)
- Attendance details screen for a selected record
- State management with Riverpod across all screens

## Tech Stack

- Flutter (stable)
- Riverpod (`flutter_riverpod`) for state management
- `geolocator` for device GPS
- `intl` for date/time formatting
- `uuid` for unique record IDs

## Project Structure

```
lib/
├── models/       # AttendanceRecord and AttendanceType
├── services/     # LocationService abstraction (real geolocator + mock)
├── providers/    # Riverpod providers and AsyncNotifier
├── screens/      # Home, History, Details
├── widgets/      # Reusable UI components
├── utils/        # Constants and date formatter
└── main.dart
```

The UI reads state from Riverpod providers and calls actions on the notifier.
The notifier holds the business logic and talks to the location service through
an abstract `LocationService` contract. The UI never accesses the location
service or GPS APIs directly.

## Error Handling

GPS failures — location services disabled, permission denied, permission
permanently denied, and capture timeout — are thrown as typed
`LocationException`s from the service layer. The attendance notifier wraps
location capture in `AsyncValue.guard()`, so every failure becomes an explicit
error state that the UI surfaces to the user, while previously captured
records are preserved.

## Requirements

- Flutter 3.24 or higher (Dart SDK >= 3.5.0)
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

## Location Source (Real GPS vs Mock)

`GeolocatorLocationService` (real device GPS) is active by default.

The assessment allows mock GPS data, so a `MockLocationService` is included
for emulators or devices without reliable GPS. It returns a slightly jittered
coordinate near Colombo, Sri Lanka. To use it, open
`lib/providers/location_service_provider.dart` and swap:

```dart
final locationServiceProvider = Provider<LocationService>((ref) {
  return GeolocatorLocationService(); // real GPS (default)
  // return MockLocationService();    // mock coordinates for emulators
});
```

Because both implement the same `LocationService` contract, no other code
changes are needed.

## Permissions (already configured)

- Android: `ACCESS_FINE_LOCATION` and `ACCESS_COARSE_LOCATION` in
  `AndroidManifest.xml`

## Assumptions

- **Persistence:** Records are held in memory and reset when the app closes.
  No backend or local database is used, per the task notes. The layered
  structure means persistence (e.g. SharedPreferences or a local DB) could be
  added later without changing the UI or provider layers.
- **Check in / out logic:** The current status is derived from the most recent
  record. Before any record exists, the status defaults to "Checked Out", and
  only the Check In button is enabled.
- **Employee:** A single hard-coded employee name is used, as the task does
  not require authentication or multiple users.
- **Record order:** Attendance history shows the newest records first.