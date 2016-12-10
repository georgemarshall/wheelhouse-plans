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
pkg_deps=(
  core/libffi
  core/python
)

do_prepare() {
  pip install wheel
}

do_build() {
  python setup.py bdist_wheel
}

do_check() {
  pip install pycparser

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
