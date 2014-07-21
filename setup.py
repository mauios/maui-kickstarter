#!/usr/bin/env python

import os, sys
from distutils.core import setup
try:
    import setuptools
    # enable "setup.py develop", optional
except ImportError:
    pass

version_file = 'VERSION'
if not os.path.isfile(version_file):
    print 'No %s file in topdir, abort' % (version_file)
    sys.exit(1)

try:
    # first line should be the version number
    version = open(version_file).readline().strip()
    if not version:
        print '%s file is invalid, abort' % (version_file)
        sys.exit(1)
except IOError:
    print 'WARNING: Cannot write version number file'



setup(name='maui-kickstarter',
      version = version,
      description='Kickstarter for Maui',
      author='Pier Luigi Fiorini',
      author_email='pierluigi.fiorini@maui-project.org',
      url='http://www.maui-project.org/',
      scripts=['tools/maui-kickstarter'],
      packages=['kickstart']
     )

