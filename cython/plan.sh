python_name=Cython
pkg_name=python-cython
pkg_origin=wheelhouse
pkg_version=0.25.2
pkg_dirname=${python_name}-${pkg_version}
pkg_source=https://pypi.org/packages/source/c/cython/${pkg_dirname}.tar.gz
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
)
pkg_bin_dirs=(bin)
pkg_python_dirs=(lib/python3.5/site-packages)

do_build() {
  python setup.py build
}

do_install() {
  python setup.py install \
    --prefix="$pkg_prefix" \
    --old-and-unmanageable # bypass egg install
}
