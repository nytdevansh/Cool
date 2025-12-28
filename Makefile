.PHONY: help install debug release quick run clean

help:
	@echo "Cool Wallpaper App - Build Commands"
	@echo ""
	@echo "  make install  - Build Release and install to /Applications"
	@echo "  make debug    - Build Debug configuration"
	@echo "  make release  - Build Release configuration"
	@echo "  make quick    - Fast rebuild (Release, no icons)"
	@echo "  make run      - Build Release and launch app"
	@echo "  make clean    - Remove build artifacts"
	@echo ""

install: release
	@rm -rf /Applications/Cool.app 2>/dev/null || true
	@cp -r build/Release/Cool.app /Applications/
	@ln -sf /Applications/Cool.app ~/Desktop/Cool.app 2>/dev/null || true
	@echo "✅ Cool.app installed to /Applications/ and ~/Desktop/"

debug:
	@cd build && xcodebuild -configuration Debug

release:
	@cd build && xcodebuild -configuration Release -quiet
	@echo "✅ Release build complete"

quick: release
	@echo "✅ Build ready at: build/Release/Cool.app"

run: release
	@open /Applications/Cool.app || open build/Release/Cool.app

clean:
	@rm -rf build/build build/Debug build/Release
	@echo "✅ Build artifacts removed"
