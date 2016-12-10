python_name=uwsgi
pkg_name=python-uwsgi
pkg_origin=wheelhouse
pkg_version=2.0.14
pkg_dirname=${python_name}-${pkg_version}
pkg_source=https://pypi.org/packages/source/u/uwsgi/${pkg_dirname}.tar.gz
pkg_shasum=21b3d1ef926d835ff23576193a2c60d4c896d8e21567850cf0677a4764122887
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="The uWSGI server"
pkg_upstream_url=http://projects.unbit.it/uwsgi
pkg_license=('GPL-2.0')
pkg_build_deps=(
  core/gcc
)
pkg_deps=(
  core/python
)

do_prepare() {
  pip install wheel
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
