cask "transcribeer" do
  version "0.1.1"
  sha256 :no_check  # placeholder — replaced by CI on first tagged release

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
