.PHONY: test clean build generate

# Project name from project.yml
PROJECT_NAME = BrownNoise15

# Project and scheme names
PROJECT = $(PROJECT_NAME).xcodeproj
SCHEME = BrownNoise15Core

# Generate Xcode project using XcodeGen
generate:
	xcodegen generate

# Clean build artifacts
clean:
	rm -rf build
	rm -rf $(PROJECT_NAME).xcodeproj
	rm -rf $(PROJECT_NAME).xcworkspace
	rm -rf TestResults

# Build the project
build: generate
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		build

# Run unit tests (macOS)
test: generate
	xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=macOS' \
		-resultBundlePath TestResults

# Show test results in terminal
test-report: test
	xcbeautify --report junit < TestResults

# Default target
all: clean generate test

# Help command
help:
	@echo "Available commands:"
	@echo "  make generate   - Generate Xcode project using XcodeGen"
	@echo "  make clean     - Clean build artifacts"
	@echo "  make build     - Build the project"
	@echo "  make test      - Run unit tests"
	@echo "  make all       - Clean, generate, and test" 