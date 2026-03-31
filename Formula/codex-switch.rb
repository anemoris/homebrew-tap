class CodexSwitch < Formula
  desc "Manage multiple Codex accounts with isolated CODEX_HOME directories"
  homepage "https://github.com/anemoris/codex-switch"
  url "https://github.com/anemoris/codex-switch/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c18167b36656ab61668823f8aaa11d5496eac69a032832edb99b56436153c670"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build",
           "-ldflags", "-s -w -X main.version=#{version}",
           "-o", bin/"codex-switch",
           "./cmd/codex-switch"
  end

  test do
    ENV["CODEX_SWITCH_HOME"] = testpath/".codex-switch"
    system bin/"codex-switch", "add", "test", "--default"
    output = shell_output("#{bin}/codex-switch list")
    assert_match "test [default, auth=missing]", output
    assert_path_exists testpath/".codex-switch/config.json"
  end
end
