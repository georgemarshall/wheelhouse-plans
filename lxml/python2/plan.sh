source ../plan.sh

pkg_name=python2-lxml
pkg_build_deps=(
  core/gcc
  wheelhouse/python2-cython
)
pkg_deps=(
  core/libxml2
  core/libxslt
  core/python2
)

do_prepare() {
  CFLAGS="-I$(pkg_path_for core/libxml2)/include/libxml2"

  pip install wheel
  pip install --no-index \
    --find-links="$(pkg_path_for wheelhouse/python2-cython)/wheelhouse" \
    cython
}
