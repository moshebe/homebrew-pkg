class Transcribeer < Formula
  desc "Local-first meeting transcription and summarization for macOS"
  homepage "https://github.com/moshebe/transcribeer"
  url "https://github.com/moshebe/transcribeer/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "a92258f5eb1dec3cf3fe2588f7d41378d1bdf69090065556f94c6b45006c72c0"
  license "MIT"

  depends_on "ffmpeg"
  depends_on macos: :ventura
  depends_on "python@3.11"

  def install
    python = Formula["python@3.11"].opt_bin/"python3.11"

    # Set up virtualenv in libexec
    system python, "-m", "venv", libexec
    pip = libexec/"bin/pip"
    system pip, "install", "--quiet", "--upgrade", "pip"
    system pip, "install", "--quiet", ".[gui]"

    # Install pre-built capture binary and codesign for screen recording
    bin.install "capture-bin"
    entitlements = buildpath/"capture/capture.entitlements.plist"
    system "codesign", "--sign", "-", "--force", "--entitlements", entitlements, bin/"capture-bin" if entitlements.exist?

    # Wrap venv scripts into brew bin
    (bin/"transcribeer").write_env_script libexec/"bin/transcribeer", {}
    (bin/"transcribeer-gui").write_env_script libexec/"bin/transcribeer-gui", {}
  end

  service do
    run [opt_bin/"transcribeer-gui"]
    keep_alive true
    log_path var/"log/transcribeer.log"
    error_log_path var/"log/transcribeer.log"
  end

  def caveats
    <<~EOS
      Transcribeer has been installed.

      The menubar app has been started automatically.
      To start on login (auto-restart):
        brew services start transcribeer

      To configure your LLM backend (Ollama/OpenAI/Anthropic) and diarization:
        ~/.transcribeer/config.toml

      Note: The first transcription will download the Whisper model (~1.5 GB).
      This happens automatically on first use.

      Recording consent: You are responsible for complying with all applicable
      laws regarding recording of conversations in your jurisdiction.
    EOS
  end

  test do
    system "#{bin}/transcribeer", "--help"
  end
end
