require "formula"

class Kf5Knewstuff < Formula
  desc "Support for downloading application assets from the network"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/knewstuff-5.39.0.tar.xz"
  sha256 "3925f2417e35f5dfa9d2dc1d8059233467569af915b2c0266ea62d6fd2a6aeaa"

  head "git://anongit.kde.org/knewstuff.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kio"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
