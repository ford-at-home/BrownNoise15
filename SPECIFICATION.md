# Specification: BrownNoise15 App

This document outlines the architecture and technical specifications for **BrownNoise15**, an iOS app that plays a user-selected song followed by 15 minutes of brown noise.

---

## Overview

**Goal:**  
Allow the user to select a song from their Apple Music library. After the song finishes, automatically play a bundled 15-minute brown noise audio file. App must support background audio playback.

**Target Device:**  
iPhone (iOS 16+)

**Tech Stack:**  
- **UI Framework:** SwiftUI  
- **Audio Engine:** AVFoundation  
- **Music Library Access:** MediaPlayer framework (`MPMediaPickerController`)  
- **Storage:** Local bundle resource (brown noise MP3)  
- **Background Playback:** Enabled via `Info.plist` + AVAudioSession

---

## App Flow

```

\[Start Screen]
↓
\[User taps Start]
↓
\[Media Picker appears]
↓
\[User selects song]
↓
\[Song plays via AVAudioPlayer]
↓
\[Upon song completion]
↓
\[Play bundled brown noise for 15 min]

````

---

## Core Components

### 1. `MainView.swift`
- SwiftUI entrypoint
- Displays a single "Start" button
- Shows current status (e.g. “Playing: Song”, “Now: Brown Noise”)

### 2. `AudioController.swift`
Handles all audio playback logic.

#### Responsibilities:
- Present `MPMediaPickerController`
- Play selected song with `AVPlayer` or `AVAudioPlayer`
- Detect when song finishes (observe end-of-track event)
- Play bundled brown noise file with `AVAudioPlayer`
- Stop playback after 15 minutes

### 3. `AppDelegate.swift` / `SceneDelegate.swift`
- Configure background audio playback

---

## Assets

### `/Assets/brown_noise.mp3`
- 15-minute brown noise MP3
- Looping not required
- Format: 44.1kHz, stereo, ~192kbps MP3

---

## Permissions & Config

### `Info.plist` additions:

```xml
<key>NSAppleMusicUsageDescription</key>
<string>This app requires access to your music library.</string>
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
</array>
````

---

## Audio Handling Details

### Music Playback

* Use `MPMediaPickerController` (UIKit wrapper in SwiftUI via `UIViewControllerRepresentable`)
* Retrieve `MPMediaItem`
* Use `AVPlayerItem` or `AVAudioPlayer` depending on access method

### Brown Noise Playback

* Load from `Bundle.main`
* Use `AVAudioPlayer` for simplicity
* Use timer to stop after 15 minutes

---

## State Management

Use an `@ObservableObject` view model (`PlaybackViewModel`) to:

* Track playback state
* Handle transitions from song to noise
* Notify view for status updates

---

## UX Considerations

* App should work with screen locked
* Show status like:

  * “Waiting for song selection”
  * “Playing: \[Song Name]”
  * “Now: Brown Noise (15:00 remaining)”
* No complex navigation
* No internet required

---

## Future Enhancements (Optional)

* Support brown noise looping
* Allow user to choose noise duration (5, 10, 15, 30 min)
* Include built-in ambient sound options
* Add dark/light mode theme

---

## Testing

* Unit test: `AudioController` behavior
* Manual test on-device:

  * Song selection and playback
  * Noise transition after song ends
  * App running in background
  * Behavior during phone lock
