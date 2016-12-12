source ../plan.sh

pkg_name=python2-pillow
pkg_build_deps=(
  core/gcc
)
pkg_deps=(
  core/freetype
  core/lcms2
# TODO: Create PR for core/libimagequant
  core/libjpeg-turbo
  core/libtiff
  core/libwebp
  core/openjpeg
  core/python2
  core/zlib
)
