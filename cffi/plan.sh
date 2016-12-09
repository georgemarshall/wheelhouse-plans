pkg_name=cffi
pkg_origin=wheelhouse
pkg_version=1.9.1
pkg_source=https://pypi.org/packages/source/c/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
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
  core/python2
)

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
  pip2 install pycparser
  pip3 install pycparser

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
