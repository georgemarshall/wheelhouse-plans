pkg_name=simplejson
pkg_origin=wheelhouse
pkg_version=3.10.0
pkg_source=https://pypi.org/packages/source/s/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=953be622e88323c6f43fad61ffd05bebe73b9fd9863a46d68b052d2aa7d71ce2
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="Simple, fast, extensible JSON encoder/decoder for Python"
pkg_upstream_url=http://github.com/simplejson/simplejson
pkg_license=('MIT' 'AFL-2.1')
pkg_build_deps=(
  core/gcc
)
pkg_deps=(
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
