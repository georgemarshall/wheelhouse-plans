source ../plan.sh

pkg_name=python2-libsourcemap
pkg_build_deps=(
  core/gcc
  core/rust
  wheelhouse/python2-cffi
)
pkg_deps=(
  core/gcc-libs
  core/python2
)

do_prepare() {
  pip install pycparser wheel
  pip install --no-index \
    --find-links="$(pkg_path_for wheelhouse/python2-cffi)/wheelhouse" \
    cffi
}
