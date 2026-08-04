class Oximg < Formula
  desc "Fast image compression and resizing: JPEG, PNG, WebP"
  homepage "https://github.com/oximg/oximg"
  url "https://github.com/oximg/oximg/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "3c44c9e37ed1677b59f7e7a3b11ea239284bff6b1af9c3cea2da1e39f4bbf453"
  license "Apache-2.0"
  head "https://github.com/oximg/oximg.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "nasm" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    port = free_port
    pid = spawn({ "PORT" => port.to_s, "IMAGES_DIR" => testpath.to_s }, bin/"oximg")
    sleep 2
    assert_match "ok", shell_output("curl -s http://127.0.0.1:#{port}/health")
  ensure
    Process.kill("TERM", pid)
  end
end
