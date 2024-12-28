#!/usr/bin/env python
"""This module contains setup instructions for pytube."""
import codecs
import os

from setuptools import setup

here = os.path.abspath(os.path.dirname(__file__))

with codecs.open(os.path.join(here, "README.md"), encoding="utf-8") as fh:
    long_description = "\n" + fh.read()

with open(os.path.join(here, "pytube", "version.py")) as fp:
    exec(fp.read())

setup(
    name="pytube",
    version=__version__,  # noqa: F821
    packages=["pytube", "pytube.contrib"],
    url="https://github.com/pytube/pytube",
    include_package_data=True,
    zip_safe=True
)
