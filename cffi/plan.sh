python_name=cffi
pkg_name=python-cffi
pkg_origin=wheelhouse
pkg_version=1.9.1
pkg_dirname=${python_name}-${pkg_version}
pkg_source=https://pypi.org/packages/source/c/cffi/${pkg_dirname}.tar.gz
pkg_shasum=563e0bd53fda03c151573217b3a49b3abad8813de9dd0632e10090f6190fdaf8
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="Foreign Function Interface for Python calling C code."
pkg_upstream_url=http://cffi.readthedocs.org/
pkg_license=('MIT')
pkg_build_deps=(
  core/gcc
)
pkg_base_deps=(
  core/libffi
)
pkg_deps=(
  ${pkg_base_deps[@]}
  core/python
  wheelhouse/python-pycparser
)
pkg_python_dirs=(lib/python3.5/site-packages)

do_build() {
  python setup.py build
}

do_install() {
  python setup.py install \
    --prefix="$pkg_prefix" \
    --old-and-unmanageable # bypass egg install
}
