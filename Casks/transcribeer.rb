cask "transcribeer" do
  version "0.3.0"
  sha256 "e8bddaf9beaaf47916e811141b77d75e066a7af1de89ce0186f1cfaf16e3f28c"

  url "https://github.com/moshebe/transcribeer/releases/download/v#{version}/Transcribeer-#{version}.dmg"
  name "Transcribeer"
  desc "Local-first meeting transcription and summarization for macOS"
  homepage "https://github.com/moshebe/transcribeer"

  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "Transcribeer.app"

  zap trash: [
    "~/.transcribeer",
    "~/Library/Preferences/com.transcribeer.menubar.plist",
    "~/Library/LaunchAgents/com.transcribeer.dev.plist",
  ]
end
