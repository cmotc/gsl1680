#! /bin/sh
# Configure your paths and filenames
SOURCEBINPATH=.
SOURCEBIN=gsl1680
SOURCEDOC=README.md
DEBFOLDER=gsl1680
DEBVERSION=$(date +%Y%m%d)
CONTROL_FILE="Source: gsl1680
Section: admin
Priority: optional
Maintainer: Sergio Costas Raster Software Vigo <raster@rastersoft.com>
Build-Depends: debhelper (>= 9)
Standards-Version: 3.9.5
Homepage: https://github.com/rastersoft/gsl1680
Vcs-Git: git@github.com:rastersoft/gsl1680
Vcs-Browser: https://github.com/rastersoft/gsl1680

Package: gsl1680
Architecture: any
Depends: \${misc:Depends}
Description: gsl1680 is a user-space driver for Silead gslx68x touch screen
 devices. It requires device firmware to function.
 .
 "
RULES_FILE='#!/usr/bin/make -f
# See debhelper(7) (uncomment to enable)
# output every command that modifies files on the build system.
#export DH_VERBOSE = 1


# see FEATURE AREAS in dpkg-buildflags(1)
#export DEB_BUILD_MAINT_OPTIONS = hardening=+all

# see ENVIRONMENT in dpkg-buildflags(1)
# package maintainers to append CFLAGS
#export DEB_CFLAGS_MAINT_APPEND  = -Wall -pedantic
# package maintainers to append LDFLAGS
#export DEB_LDFLAGS_MAINT_APPEND = -Wl,--as-needed


%:
	dh $@


# dh_make generated override targets
# This is example for Cmake (See https://bugs.debian.org/641051 )
#override_dh_auto_configure:
#	dh_auto_configure -- #	-DCMAKE_LIBRARY_PATH=$(DEB_HOST_MULTIARCH)

override_dh_strip:
        dh_strip -Xgsl
'
DEBFOLDERNAME="../$DEBFOLDER-$DEBVERSION"

cd $DEBFOLDER

# Create your scripts source dir

# Copy your script to the source dir
cp $SOURCEBINPATH/ $DEBFOLDERNAME -r
cd $DEBFOLDERNAME

# Create the packaging skeleton (debian/*)
dh_make --single --createorig
echo "$CONTROL_FILE" > debian/control
echo "$RULES_FILE" > debian/rules
# Remove make calls
#grep -v makefile debian/rules > debian/rules.new
#mv debian/rules.new debian/rules

# debian/install must contain the list of scripts to install
# as well as the target directory
#echo $DEBFOLDER usr/bin > debian/install
#echo $SOURCEDOC usr/share/doc/apt-git >> debian/install

# Remove the example files
rm debian/*.ex

# Build the package.
# You  will get a lot of warnings and ../somescripts_0.1-1_i386.deb
debuild -us -uc > ../log
