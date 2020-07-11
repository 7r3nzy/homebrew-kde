class Kf5Kpackage < Formula
  desc "Lets applications manage user installable packages"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.72/kpackage-5.72.0.tar.xz"
  sha256 "ec512226309be1f44c527cb940d6995214611617f12c49ec7b6c3aaa3786933a"
  head "https://invent.kde.org/frameworks/kpackage.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-karchive"
  depends_on "kde-ki18n"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Package REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
