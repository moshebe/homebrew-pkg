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
    venv = libexec/"venv"

    # Create virtualenv inside the Homebrew prefix — brew uninstall cleans it all up
    system python, "-m", "venv", venv

    # Install package with all runtime extras
    system venv/"bin/pip", "install", "--no-cache-dir",
           ".[gui,resemblyzer,openai,anthropic]"

    # Install pre-built capture binary into libexec and codesign for screen recording
    (libexec/"bin").mkpath
    cp "capture-bin", libexec/"bin/capture-bin"
    chmod 0755, libexec/"bin/capture-bin"
    entitlements = buildpath/"capture/capture.entitlements.plist"
    if entitlements.exist?
      system "codesign", "--force", "--sign", "-",
             "--entitlements", entitlements, libexec/"bin/capture-bin"
    else
      system "codesign", "--force", "--sign", "-", libexec/"bin/capture-bin"
    end

    # Write wrapper scripts — transcribeer also bootstraps config on first run
    capture_bin_path = opt_libexec/"bin/capture-bin"

    (bin/"transcribeer").write <<~SH
      #!/bin/bash
      CONFIG="$HOME/.transcribeer/config.toml"
      if [[ ! -f "$CONFIG" ]]; then
        mkdir -p "$HOME/.transcribeer/sessions"
        cat > "$CONFIG" <<TOML
      [transcription]
      language = "auto"
      diarization = "resemblyzer"
      num_speakers = 0

      [summarization]
      backend = "ollama"
      model = "llama3"
      ollama_host = "http://localhost:11434"

      [paths]
      sessions_dir = "~/.transcribeer/sessions"
      capture_bin = "#{capture_bin_path}"
      TOML
      fi
      exec "#{venv}/bin/transcribeer" "$@"
    SH

    (bin/"transcribeer-gui").write <<~SH
      #!/bin/bash
      exec "#{venv}/bin/transcribeer-gui" "$@"
    SH

    chmod 0755, bin/"transcribeer"
    chmod 0755, bin/"transcribeer-gui"
  end

  service do
    run [opt_bin/"transcribeer-gui"]
    keep_alive true
    log_path var/"log/transcribeer.log"
    error_log_path var/"log/transcribeer.log"
  end

  def caveats
    capture_bin_path = opt_libexec/"bin/capture-bin"
    <<~EOS
      Transcribeer has been installed.

      To start on login (auto-restart):
        brew services start transcribeer

      A default config will be created at ~/.transcribeer/config.toml on first run,
      pointing capture-bin to:
        #{capture_bin_path}

      To change LLM backend (Ollama/OpenAI/Anthropic) or diarization, edit:
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
