class GhTools < Formula
  desc "GitHub productivity tools"
  homepage "https://github.com/pmatseykanets/gh-tools"
  version "0.9.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pmatseykanets/gh-tools/releases/download/v0.9.5/gh-tools_0.9.5_darwin_arm64.tar.gz"
      sha256 "5b0d9c2a8706e64f4c0e4f2b87ab0eafced1ffe1c084938dca612ab2e190425e"
    elsif Hardware::CPU.intel?
      url "https://github.com/pmatseykanets/gh-tools/releases/download/v0.9.5/gh-tools_0.9.5_darwin_amd64.tar.gz"
      sha256 "c991d80a66dc30c8c12a4d5ad1194c2d98679d6c0f5f60d13666cdf7617447b9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pmatseykanets/gh-tools/releases/download/v0.9.5/gh-tools_0.9.5_linux_arm64.tar.gz"
      sha256 "48e18b652f17ddf8f0532a69db2fb475124222f656baa7dda79c64bb5add09cd"
    elsif Hardware::CPU.intel?
      url "https://github.com/pmatseykanets/gh-tools/releases/download/v0.9.5/gh-tools_0.9.5_linux_amd64.tar.gz"
      sha256 "fb8748360476ed7e4dce9ace60ba275e19dbe0c87ebc8c5f7c86a020c19a951f"
    end
  end
  
  head do
    url "https://github.com/pmatseykanets/gh-tools.git"
    depends_on "go" => :build
  end

  def install
    if build.head?
      ENV["CGO_ENABLED"] = "0"
      system "go", "build", "-trimpath", "-ldflags", "-s -w -X github.com/pmatseykanets/gh-tools/version.Version=#{version}", "./cmd/gh-find" 
      system "go", "build", "-trimpath", "-ldflags", "-s -w -X github.com/pmatseykanets/gh-tools/version.Version=#{version}", "./cmd/gh-pr" 
      system "go", "build", "-trimpath", "-ldflags", "-s -w -X github.com/pmatseykanets/gh-tools/version.Version=#{version}", "./cmd/gh-watch" 
      system "go", "build", "-trimpath", "-ldflags", "-s -w -X github.com/pmatseykanets/gh-tools/version.Version=#{version}", "./cmd/gh-go-rdeps" 
      system "go", "build", "-trimpath", "-ldflags", "-s -w -X github.com/pmatseykanets/gh-tools/version.Version=#{version}", "./cmd/gh-purge-artifacts"   
    end

    bin.install "gh-find"
    bin.install "gh-pr"
    bin.install "gh-watch"
    bin.install "gh-go-rdeps"
    bin.install "gh-purge-artifacts"
  end

  test do
    system "#{bin}/gh-find -version"
    system "#{bin}/gh-pr -version"
    system "#{bin}/gh-watch -version"
    system "#{bin}/gh-go-rdeps -version"
    system "#{bin}/gh-purge-artifacts -version"
  end
end
