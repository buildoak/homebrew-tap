# typed: false
# frozen_string_literal: true

class Gaal < Formula
  desc "Session observability CLI for AI coding agents"
  homepage "https://github.com/buildoak/gaal"
  url "https://github.com/buildoak/gaal/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "63072907ceb347da111e864ca1ba5dcfa9f61a27e56754dab704be15e0ea8270"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    ENV["HOME"] = testpath.to_s
    ENV["GAAL_HOME"] = (testpath/".gaal").to_s

    assert_match "gaal #{version}", shell_output("#{bin}/gaal --version")

    onboard = shell_output("#{bin}/gaal onboard --dry-run")
    assert_match "skill/references/first-run.md", onboard
    assert_match "gaal index backfill", onboard
    assert_match "does_not_install_scheduled_jobs", onboard
  end
end
