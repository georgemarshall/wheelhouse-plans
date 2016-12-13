python_name=libsourcemap
pkg_name=python-libsourcemap
pkg_origin=wheelhouse
pkg_version=0.5.0
pkg_dirname=${python_name}-${pkg_version}
#pkg_source=https://pypi.org/packages/source/l/libsourcemap/${pkg_dirname}.zip
#pkg_shasum=63627489b9d0bc2111751b2bdccff0bc91d029eefe58c3a2842c364fc4530808
# FIXME: Workaround for https://github.com/getsentry/libsourcemap/issues/5
pkg_source=https://github.com/getsentry/libsourcemap/archive/${pkg_version}.tar.gz
pkg_shasum=2b8e0a17b1af0d13496ca42d8fed61cdf11911c339f22b2f0288d4d7f4d0cf46
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="The Web framework for perfectionists with deadlines."
pkg_upstream_url=https://python-pillow.org/
pkg_license=('Standard PIL License')
pkg_build_deps=(
  core/gcc
  core/rust
  wheelhouse/python-cffi
)
pkg_deps=(
  core/gcc-libs
  core/python
)

do_prepare() {
  pip install pycparser wheel
  pip install --no-index \
    --find-links="$(pkg_path_for wheelhouse/python-cffi)/wheelhouse" \
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
