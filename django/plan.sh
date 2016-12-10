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
pkg_build_deps=(
  core/make
  core/python
)
pkg_deps=(
  core/tzdata
)

do_prepare() {
  pip install wheel

  build_line 'Patch hard coded zoneinfo paths'
  _zoneinfo="$(pkg_path_for core/tzdata)/share/zoneinfo"
  find . -type f -name '*.py' -exec \
    sed -i -- "s%/usr/share/zoneinfo%$_zoneinfo%g" {} +
  unset _zoneinfo
}

do_build() {
  make -f extras/Makefile bdist_wheel
}

do_check() {
  build_line 'Test install python wheel'
  pip install --no-index \
    --find-links="$HAB_CACHE_SRC_PATH/$pkg_dirname/dist" \
    "$python_name==$pkg_version"

  # TODO: execute runtests.py against installed version
  # https://docs.djangoproject.com/en/dev/internals/contributing/writing-code/unit-tests/#quickstart
}

do_install() {
  mkdir -p "$pkg_prefix/wheelhouse"
  cp -r dist/*.whl "$pkg_prefix/wheelhouse"
}
