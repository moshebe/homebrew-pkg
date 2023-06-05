# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Gebug < Formula
  desc ""
  homepage "https://github.com/moshebe/gebug"
  version "1.0.7"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/moshebe/gebug/releases/download/v1.0.7/gebug_1.0.7_Darwin_x86_64.tar.gz"
      sha256 "f55d1a0cd12559e2eadb20f4bc3dbd485349824560f49df77c2121d9b65184d1"

      def install
        bin.install "gebug"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/moshebe/gebug/releases/download/v1.0.7/gebug_1.0.7_Darwin_arm64.tar.gz"
      sha256 "83f789c31590cf347c3d9de43193c76f32493f3986306050bac155537ae1c6c7"

      def install
        bin.install "gebug"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/moshebe/gebug/releases/download/v1.0.7/gebug_1.0.7_Linux_arm64.tar.gz"
      sha256 "7416843d50a5feba71dcb2f1b34c84889c3888737316b31455220b2546f29303"

      def install
        bin.install "gebug"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/moshebe/gebug/releases/download/v1.0.7/gebug_1.0.7_Linux_x86_64.tar.gz"
      sha256 "d206656e7961d82e601044f1ecb7b6df4895d9cd5cd54a58522af4f1e55dcb6b"

      def install
        bin.install "gebug"
      end
    end
  end
end
