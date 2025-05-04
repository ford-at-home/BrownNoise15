# Contributing to BrownNoise15

Welcome! BrownNoise15 is a minimalist iOS app that plays one song followed by 15 minutes of brown noise. While the iOS app is the core product, the project also includes supporting infrastructure and tools to automate tasks, manage dependencies, and deploy metadata assets to AWS. This `CONTRIBUTING.md` outlines everything you need to know to work on the project effectively.

---

## Repo Structure

```

BrownNoise15/
├── ios/                  # SwiftUI app code
├── assets/               # Audio assets, screenshots, etc.
├── deploy/               # CDK stack and deployment scripts
├── scripts/              # Python helper scripts
├── Makefile              # Task automation
├── requirements.txt      # Python dependencies
├── specification.md      # App architecture
├── CONTRIBUTING.md       # This file
└── README.md             # Project overview

````

---

## Makefile Usage

All local dev tasks and deployments are automated via the `Makefile`.

### Common Commands

```bash
make setup           # Sets up Python environment and installs dependencies
make build-assets    # Optimizes and packages brown_noise.mp3
make deploy          # Deploys supporting stack to AWS (S3 bucket for audio assets, etc.)
make clean           # Deletes temp files and virtual env
make help            # Lists all available make commands
````

The `Makefile` uses standard shell commands plus Python scripts in `scripts/`. Feel free to add your own rules for repetitive tasks.

---

## Python Dependencies

We use Python primarily to:

* Process/validate brown noise assets
* Deploy assets to AWS (via `boto3`)
* Generate `metadata.json` for song files if needed

### `requirements.txt`

```
boto3>=1.28
pydub>=0.25.1
mutagen>=1.47.0
```

### Setup

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Key Scripts

* `scripts/upload_audio.py`: Uploads `brown_noise.mp3` to the S3 bucket and sets public-read ACL
* `scripts/validate_audio.py`: Confirms bit rate, duration, and format
* `scripts/gen_metadata.py`: Optional — generates searchable metadata if you later add a song catalog

---

## AWS Deployment Details

Though the iOS app is local-only, we deploy supporting resources to AWS:

### Stack Overview

* **S3 Bucket**: Stores audio assets (`brown_noise.mp3`)
* **CloudFront (Optional)**: Serves audio with global edge caching
* **IAM Policy**: Read-only public access for audio file

This lets you easily swap the bundled file for a CDN-hosted one if the app grows.

### CDK Stack (in `/deploy/`)

Uses AWS CDK with Python bindings. Example resources:

* `brownnoise15-assets` (S3 bucket)
* `brownnoise15-distribution` (CloudFront, optional)

To deploy:

```bash
cd deploy/
make bootstrap     # One-time CDK bootstrap
make deploy        # Deploys the full stack
```

---

## Environment Variables

We use `.env` to store config for AWS deployment:

```
AWS_REGION=us-east-1
S3_BUCKET=brownnoise15-assets
```

These are loaded by Python scripts and CDK commands via `python-dotenv`.

---

## Testing & Validation

### Audio Test

Before bundling, validate your audio:

```bash
make build-assets
```

This runs `validate_audio.py` to ensure:

* MP3 is 15 minutes
* Bitrate is 192kbps+
* Proper encoding

### Local App Test

1. Run app on physical iOS device via Xcode
2. Choose song from Apple Music library
3. Ensure brown noise plays after the song
4. Lock phone and confirm background playback works

---

## Contributions Welcome

If you're submitting a pull request:

* Follow existing Makefile/task automation conventions
* Keep audio files under 20MB unless CDN-hosted
* Write doc updates if behavior changes

For questions or to propose bigger changes, open an issue or start a discussion.

---

## Thanks

This is a chill, open-source project for sleep, focus, and peace. Let’s keep it simple and well-built.
