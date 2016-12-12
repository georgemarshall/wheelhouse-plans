python_name=Pillow
pkg_name=python-pillow
pkg_origin=wheelhouse
pkg_version=3.4.2
pkg_dirname=${python_name}-${pkg_version}
pkg_source=https://pypi.org/packages/source/p/pillow/${pkg_dirname}.tar.gz
pkg_shasum=0ee9975c05602e755ff5000232e0335ba30d507f6261922a658ee11b1cec36d1
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="The Web framework for perfectionists with deadlines."
pkg_upstream_url=https://python-pillow.org/
pkg_license=('Standard PIL License')
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
  core/python
  core/zlib
)

do_prepare() {
  pip install wheel
}

do_build() {
  python setup.py bdist_wheel
}

do_check() {
  build_line 'Test install python wheel'
  pip install --no-index \
    --find-links="$HAB_CACHE_SRC_PATH/$pkg_dirname/dist" \
    "$python_name==$pkg_version"

  # TODO: Run module unit tests
}

do_install() {
  mkdir -p "$pkg_prefix/wheelhouse"
  cp -r dist/*.whl "$pkg_prefix/wheelhouse"
}
