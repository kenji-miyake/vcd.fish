# common
set -q VCSTOOL_SRC_DIR || set -U VCSTOOL_SRC_DIR src
set -q VCSTOOL_INSTALL_DIR || set -U VCSTOOL_INSTALL_DIR install

# vcd
set -q VCD_MODE || set -U VCD_MODE repos

# ccd
set -q CCD_DEFAULT_MODE || set -U CCD_DEFAULT_MODE src
