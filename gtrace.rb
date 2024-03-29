# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Gtrace < Formula
  desc ""
  homepage "https://github.com/moshebe/gtrace"
  version "1.0.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/moshebe/gtrace/releases/download/v1.0.4/gtrace_1.0.4_Darwin_x86_64.tar.gz"
      sha256 "ec82c492ea6aacb4ab6d8a319caaa4bb1d0023316339ceb425067acaaf6347e9"

      def install
        bin.install "gtrace"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/moshebe/gtrace/releases/download/v1.0.4/gtrace_1.0.4_Darwin_arm64.tar.gz"
      sha256 "f39a41940a4e6e3dade5aaaff0cfe72c71551bb4f91b0631e1a029cb63e5ab9f"

      def install
        bin.install "gtrace"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/moshebe/gtrace/releases/download/v1.0.4/gtrace_1.0.4_Linux_arm64.tar.gz"
      sha256 "99e7384f3acb226881df9a3d5fe560d09734c7f4e37195e41530c25821366094"

      def install
        bin.install "gtrace"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/moshebe/gtrace/releases/download/v1.0.4/gtrace_1.0.4_Linux_x86_64.tar.gz"
      sha256 "118b3a5d8f5b3c9c9a5143224c0e07a58ca8975351f236e48e53034526c984f2"

      def install
        bin.install "gtrace"
      end
    end
  end
end
