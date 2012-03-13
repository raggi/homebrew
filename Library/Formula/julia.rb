require 'formula'

class Julia < Formula
  homepage 'http://julialang.org/'
  url 'https://github.com/JuliaLang/julia.git', :using => :git
  version '0-prerelease'
  md5 ''

  def install
    ENV.fortran

    ENV.deparallelize
    ENV.no_optimization
    ENV.gcc_4_2

    # Currently homebrew isn't adding an llvm fortran, but that'd have to go
    # too, if it was: FC F77
    bad_flags = %w[CC CFLAGS CXX CXXFLAGS LD FCFLAGS FFLAGS]
    bad_flags.each { |e| ENV.delete e }

    system "make PREFIX=#{prefix}"
    system "make PREFIX=#{prefix} install"
    system "install -d #{prefix}/include"
    system "install -d #{prefix}/bin"
    system "cp #{Dir.pwd}/src/julia.h #{prefix}/include/"
    system "ln -s #{prefix}/share/julia/julia #{prefix}/bin/julia"
  end

  def test
    system "make test"
  end
end
