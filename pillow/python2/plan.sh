source ../plan.sh

pkg_name=python2-pillow
pkg_deps=(
  ${pkg_base_deps[@]}
  core/python2
)
pkg_python_dirs=(lib/python2.7/site-packages)
