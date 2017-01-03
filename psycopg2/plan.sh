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
pkg_base_deps=(
  core/postgresql
)
pkg_deps=(
  ${pkg_base_deps[@]}
  core/python
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
