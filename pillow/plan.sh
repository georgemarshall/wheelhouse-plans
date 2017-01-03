python_name=Pillow
pkg_name=python-pillow
pkg_origin=wheelhouse
pkg_version=4.0.0
pkg_dirname=${python_name}-${pkg_version}
pkg_source=https://pypi.org/packages/source/p/pillow/${pkg_dirname}.tar.gz
pkg_shasum=ee26d2d7e7e300f76ba7b796014c04011394d0c4a5ed9a288264a3e443abca50
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="Python Imaging Library (Fork)"
pkg_upstream_url=https://python-pillow.org/
pkg_license=('Standard PIL License')
pkg_build_deps=(
  core/gcc
)
pkg_base_deps=(
  core/freetype
  core/lcms2
  core/libjpeg-turbo
  core/libtiff
  core/libwebp
  core/openjpeg
  core/zlib
)
pkg_deps=(
  ${pkg_base_deps[@]}
  core/python
)
pkg_bin_dirs=(bin)
pkg_python_dirs=(lib/python3.5/site-packages)

do_build() {
  # TODO: Add build for libimagequant
  python setup.py build
}

# FIXME: Requires nose to run
#do_check() {
#  python setup.py test
#}

do_install() {
  python setup.py install \
    --prefix="$pkg_prefix" \
    --old-and-unmanageable # bypass egg install
}
