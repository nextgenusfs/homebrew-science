class Flexbar < Formula
  desc "Flexible barcode and adapter removal"
  homepage "https://github.com/seqan/flexbar"
  # tag "bioinformatics"

  url "https://github.com/seqan/flexbar/archive/v3.0.0.tar.gz"
  sha256 "60226d62d9617a7026bdae4b6f5f695ac2bc839b7d19e1d7d9ab63f85aa31a74"
  head "https://github.com/seqan/flexbar.git"

  depends_on "cmake" => :build
  # seqan is a header-only C++14 library
  depends_on "seqan" => :build
  depends_on "tbb"

  # Needs C++14 to build but this is not available yet
  # needs :cxx14

  def install
    # https://github.com/seqan/flexbar/issues/4
    inreplace "src/CMakeLists.txt", "std=c++11", "std=c++14"
    system "cmake", ".", *std_cmake_args
    system "make"
    bin.install "flexbar"
    pkgshare.install "test"
  end

  test do
    assert_match "reads.fq", shell_output("#{bin}/flexbar -h 2>&1", 0)
  end
end