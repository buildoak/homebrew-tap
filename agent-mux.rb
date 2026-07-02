# typed: false
# frozen_string_literal: true

class AgentMux < Formula
  desc "Cross-engine dispatch layer for AI coding agents"
  homepage "https://github.com/buildoak/agent-mux"
  url "https://github.com/buildoak/agent-mux/archive/refs/tags/agent-mux-v3.5.0.tar.gz"
  sha256 "f8cd83ef66d5c28261e00bc91c02b33fa5747afbeb5eb5743db616897905033e"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"agent-mux"), "./cmd/agent-mux"
  end

  test do
    ENV["HOME"] = testpath.to_s

    assert_match "agent-mux v#{version}", shell_output("#{bin}/agent-mux --version")

    onboard = shell_output("#{bin}/agent-mux onboard --dry-run")
    assert_match "skill/references/first-run.md", onboard
    assert_match "does_not_dispatch_workers", onboard

    engines = shell_output("#{bin}/agent-mux config engines --json")
    assert_match "\"engine\":\"codex\"", engines
  end
end
