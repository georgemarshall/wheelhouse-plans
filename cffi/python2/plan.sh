source ../plan.sh

pkg_name=python2-cffi
pkg_deps=(
  ${pkg_base_deps[@]}
  core/python2
  wheelhouse/python2-pycparser
)
pkg_python_dirs=(lib/python2.7/site-packages)
