python_name=psycopg2
pkg_name=python-psycopg2
pkg_origin=wheelhouse
pkg_version=2.6.2
pkg_dirname=${python_name}-${pkg_version}
pkg_source=https://pypi.org/packages/source/p/psycopg2/${pkg_dirname}.tar.gz
pkg_shasum=70490e12ed9c5c818ecd85d185d363335cc8a8cbf7212e3c185431c79ff8c05c
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="Python-PostgreSQL Database Adapter"
pkg_upstream_url=http://initd.org/psycopg/
pkg_license=('LGPL-3.0')
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_deps=(
  core/postgresql
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
