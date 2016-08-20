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
DEBFOLDERNAME="../$DEBFOLDER-$DEBVERSION"

cd $DEBFOLDER

# Create your scripts source dir

# Copy your script to the source dir
cp $SOURCEBINPATH/ $DEBFOLDERNAME -r
cd $DEBFOLDERNAME

# Create the packaging skeleton (debian/*)
dh_make --single --createorig
echo "$CONTROL_FILE" > debian/control

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
