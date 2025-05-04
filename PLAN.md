# PLAN.md

## Project: BrownNoise15  
A minimalist iOS app that plays one user-selected song, followed by 15 minutes of brown noise. Built in SwiftUI using AVFoundation and MediaPlayer frameworks.

---

## 🎯 Objective

Create a simple, production-ready iOS app that:
- Lets the user select a song from their Apple Music library
- Plays the selected song once
- Immediately follows with 15 minutes of brown noise (local asset)
- Supports background playback
- Has a minimal, single-button interface with playback status

---

## 🧱 Architecture

See `specification.md` for details, but at a glance:

- **Frontend:** SwiftUI (`MainView.swift`)
- **Audio Logic:** `AudioController.swift` with AVFoundation
- **Permissions:** Apple Music access + background audio (`Info.plist`)
- **Assets:** Bundled `brown_noise.mp3` (15 min, 192kbps+)
- **Tooling:** Python scripts + Makefile for asset prep and AWS deploys
- **Infrastructure (optional):** S3 + CloudFront support via CDK (`deploy/`)

---

## ✅ Prerequisites

Before coding:
- [x] Create SwiftUI iOS app in Xcode
- [x] Add `brown_noise.mp3` to bundle
- [x] Add these to `Info.plist`:

```xml
<key>NSAppleMusicUsageDescription</key>
<string>This app needs access to your music library.</string>
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
</array>
````

* [x] Test on a real device (Apple Music library is unavailable on the simulator)
* [x] Set up Python virtual environment: `make setup`

---

## 👨‍💻 Developer Workflow

Use the following flow to collaborate or build features:

1. `make setup` — install Python tools for asset prep
2. `make build-assets` — validate and bundle brown noise MP3
3. `make deploy` — deploy brown noise file to AWS (optional)
4. Edit Swift files in `ios/` to build UI and logic
5. Use Cursor AI assistant to scaffold or debug code
6. Test on physical device for audio and background playback
7. Submit PRs with clear feature scope and rationale

---

## 💡 Cursor Prompt

Use this to instruct Cursor to begin writing the app:

```
You're now co-building an iOS app called BrownNoise15.

Goal: When the user taps "Start," they select a song from their Apple Music library. That song plays once, then the app automatically plays a bundled 15-minute brown noise MP3. The UI is minimal — a single button and status text. The app must support background playback.

Architecture is defined in `specification.md`, with deployment and tooling in `CONTRIBUTING.md`. Assets include a local `brown_noise.mp3` file.

Start by scaffolding the SwiftUI app, using AVFoundation and MediaPlayer frameworks. First deliver:
- `MainView.swift` with a Start button and basic playback status
- `AudioController.swift` that handles: song selection via `MPMediaPickerController`, playback of selected song, playback of bundled brown noise after that song ends

Assume background audio is configured via `Info.plist`.

Use @ObservableObject and bind it to the UI.
Don't worry about App Store polish yet — we're getting core functionality up.
```

---

## 🛣️ Milestones

* [ ] Scaffold `MainView.swift` with Start button and reactive status
* [ ] Implement `AudioController.swift`
* [ ] Confirm song selection + playback
* [ ] Confirm automatic brown noise playback after song
* [ ] Confirm background playback support
* [ ] Polish UI + loading state
* [ ] Package for TestFlight
* [ ] Submit to App Store

---

Let’s build.

