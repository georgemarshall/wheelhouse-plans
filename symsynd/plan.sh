python_name=symsynd
pkg_name=python-symsynd
pkg_origin=wheelhouse
pkg_version=1.3.0
pkg_dirname=${python_name}-${pkg_version}
pkg_source=https://pypi.org/packages/source/s/symsynd/${pkg_dirname}.zip
pkg_shasum=c3b4f9e7a9fa3ef6c37a8d86ed0ebe15ffc15ecb3814cef0b2ba764a7b0e4b98
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="Helps symbolicating crash dumps."
pkg_upstream_url=http://github.com/getsentry/symsynd
pkg_license=('BSD-3-Clause')
pkg_build_deps=(
  core/cmake
  core/gcc
  core/make
  core/patch
  wheelhouse/python-cffi
)
pkg_deps=(
  core/gcc-libs
  core/libffi
  core/python
)

do_prepare() {
  export CC="$(pkg_path_for gcc)/bin/gcc"
  export CXX="$(pkg_path_for gcc)/bin/g++"

  patch -p0 -i "$PLAN_CONTEXT/buildsh.patch"

  pip install pycparser wheel
  pip install --no-index \
    --find-links="$(pkg_path_for python-cffi)/wheelhouse" \
    cffi
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
