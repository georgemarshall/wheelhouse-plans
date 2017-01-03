python_name=Django
pkg_name=python-django
pkg_origin=wheelhouse
pkg_version=1.10.4
pkg_dirname=${python_name}-${pkg_version}
pkg_source=https://pypi.org/packages/source/d/django/${pkg_dirname}.tar.gz
pkg_shasum=fff7f062e510d812badde7cfc57745b7779edb4d209b2bc5ea8d954c22305c2b
pkg_maintainer="George Marshall <george@georgemarshall.name>"
pkg_description="The Web framework for perfectionists with deadlines."
pkg_upstream_url=https://www.djangoproject.com/
pkg_license=('BSD-3-Clause')
pkg_deps=(
  core/python
)
pkg_bin_dirs=(bin)
pkg_python_dirs=(lib/python3.5/site-packages)

do_build() {
  python setup.py build
}

# TODO: execute runtests.py
#do_check() {
#   https://docs.djangoproject.com/en/dev/internals/contributing/writing-code/unit-tests/#quickstart
#}

do_install() {
  python setup.py install \
    --prefix="$pkg_prefix" \
    --old-and-unmanageable # bypass egg install
}
