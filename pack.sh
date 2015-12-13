#!/bin/bash
rm boot.zip
7z a -tzip -x!.git -x!*.zip -x!pack.sh boot.zip *
