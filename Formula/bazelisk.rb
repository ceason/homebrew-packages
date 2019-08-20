class Bazelisk < Formula
  desc "User-friendly launcher for Bazel. Provides the 'bazelisk' command and symlinks 'bazel' to it as well."
  homepage "https://github.com/bazelbuild/bazelisk/"
  url "https://github.com/bazelbuild/bazelisk.git",
      :tag => "v1.0",
      :revision => "52085079a69f26c142e6dc9c948a7baa7a38c9c8"
  head "https://github.com/bazelbuild/bazelisk.git"

  depends_on "go" => :build

  def install
    system "go", "test"
    system "go", "build", "-o", bin / "bazelisk"
    system "ln", "-s", bin / "bazelisk", bin / "bazel"
  end

  test do
    assert_match /v#{version}/, shell_output("#{bin}/bazelisk version")

    # This is an older than current version, so that we can test that bazelisk
    # will target an explicit version we specify. This version shouldn't need to
    # be bumped.
    ENV["USE_BAZEL_VERSION"] = "0.26.0"
    assert_match /Build label: 0.26.0/, shell_output("#{bin}/bazelisk version")
  end
end