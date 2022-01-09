require_relative "../lib/cmake"

class Kf5Kxmlgui < Formula
  desc "User configurable main windows"
  homepage "https://api.kde.org/frameworks/kxmlgui/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.90/kxmlgui-5.90.0.tar.xz"
  sha256 "4f7bc9b305b49a304379d82037dcfe63ba89e6a4911cd4ac3c831dd3330f1be1"
  head "https://invent.kde.org/frameworks/kxmlgui.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  # https://bugs.kde.org/show_bug.cgi?id=446492
  # depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-attica"
  depends_on "kde-mac/kde/kf5-kglobalaccel"
  depends_on "kde-mac/kde/kf5-ktextwidgets"
  depends_on "qt@5"

  def install
    args = kde_cmake_args
    args << "-D BUILD_QCH=OFF" # https://bugs.kde.org/show_bug.cgi?id=446492

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    args = std_cmake_args
    args << "-Wno-dev"

    qt_modules = %w[
      DBus
      Network
      PrintSupport
      Svg
      Widgets
      Xml
    ]

    qt_modules.each do |qt_module|
      args << "-DQt5#{qt_module}_DIR=#{Formula["qt@5"].opt_prefix}/lib/cmake/Qt5#{qt_module}"
    end

    (testpath/"CMakeLists.txt").write("find_package(KF5XmlGui REQUIRED)")
    system "cmake", ".", *args
  end
end
