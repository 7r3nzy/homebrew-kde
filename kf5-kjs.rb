require "formula"

class Kf5Kjs < Formula
  desc "Support for JS scripting in applications"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/portingAids/kjs-5.39.0.tar.xz"
  sha256 "36b365c9f3f41b8ca60d9816d58e6a67e32b2c83385a92d43d3237431118763a"

  head "git://anongit.kde.org/kjs.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "pcre"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
