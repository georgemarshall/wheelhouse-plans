source ../plan.sh

pkg_name=python2-symsynd
pkg_build_deps=(
  core/cmake
  core/gcc
  core/make
  core/patch
  wheelhouse/python2-cffi
)
pkg_deps=(
  core/gcc-libs
  core/libffi
  core/python2
)

do_prepare() {
  export CC="$(pkg_path_for gcc)/bin/gcc"
  export CXX="$(pkg_path_for gcc)/bin/g++"

  patch -p0 -i "$PLAN_CONTEXT/../buildsh.patch"

  pip install pycparser wheel
  pip install --no-index \
    --find-links="$(pkg_path_for python2-cffi)/wheelhouse" \
    cffi
}
