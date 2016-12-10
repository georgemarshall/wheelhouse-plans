pkg_name=cython
pkg_origin=wheelhouse
pkg_version=0.25.2
pkg_source=https://pypi.org/packages/source/c/${pkg_name}/Cython-${pkg_version}.tar.gz
pkg_shasum=f141d1f9c27a07b5a93f7dc5339472067e2d7140d1c5a9e20112a5665ca60306
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="The Cython compiler for writing C extensions for the Python language."
pkg_upstream_url=http://cython.org/
pkg_license=('Apache-2.0')
pkg_build_deps=(
  core/gcc
)
pkg_deps=(
  core/python
  core/python2
)
pkg_dirname=Cython-${pkg_version}

do_prepare() {
  pip2 install wheel
  pip3 install wheel
}

do_build() {
  build_line 'Build python2 wheel'
  python2 setup.py bdist_wheel

  build_line 'Build python3 wheel'
  python3 setup.py bdist_wheel
}

do_check() {
  build_line 'Test install python2 wheel'
  pip2 install --no-index \
    --find-links="$HAB_CACHE_SRC_PATH/$pkg_dirname/dist" \
    "$pkg_name==$pkg_version"

  build_line 'Test install python3 wheel'
  pip3 install --no-index \
    --find-links="$HAB_CACHE_SRC_PATH/$pkg_dirname/dist" \
    "$pkg_name==$pkg_version"

  # TODO: Run module unit tests
}

do_install() {
  mkdir -p "$pkg_prefix/wheelhouse"
  cp -r dist/*.whl "$pkg_prefix/wheelhouse"
}
