python_name=lxml
pkg_name=python-lxml
pkg_origin=wheelhouse
pkg_version=3.6.4
pkg_dirname=${python_name}-${pkg_version}
pkg_source=https://pypi.org/packages/source/l/lxml/${pkg_dirname}.tar.gz
pkg_shasum=61d5d3e00b5821e6cda099b3b4ccfea4527bf7c595e0fb3a7a760490cedd6172
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="Pythonic XML processing library combining libxml2/libxslt with the ElementTree API."
pkg_upstream_url=http://lxml.de/
pkg_license=('BSD-3-Clause')
pkg_build_deps=(
  core/gcc
  wheelhouse/python-cython
)
pkg_deps=(
  core/libxml2
  core/libxslt
  core/python
)

do_prepare() {
  CFLAGS="-I$(pkg_path_for core/libxml2)/include/libxml2"

  pip install wheel
  pip install --no-index \
    --find-links="$(pkg_path_for wheelhouse/python-cython)/wheelhouse" \
    cython
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
