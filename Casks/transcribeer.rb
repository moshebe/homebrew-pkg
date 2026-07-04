cask "transcribeer" do
  version "0.2.0"
  sha256 "7af13d0139fb5fb6602f030f527fb3316cd65e21a4ef6e6a54bd80271e2072ea"

  url "https://github.com/moshebe/transcribeer/releases/download/v#{version}/Transcribeer-#{version}.dmg"
  name "Transcribeer"
  desc "Local-first meeting transcription and summarization for macOS"
  homepage "https://github.com/moshebe/transcribeer"

  depends_on macos: ">= :sequoia"
  depends_on arch: :arm64

  app "Transcribeer.app"

  zap trash: [
    "~/.transcribeer",
    "~/Library/Preferences/com.transcribeer.menubar.plist",
    "~/Library/LaunchAgents/com.transcribeer.dev.plist",
  ]
end
