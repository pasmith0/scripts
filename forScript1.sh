#!/bin/bash

#for f in `find . -name '*.o'` ; do echo $f ; sparc-elf-nm $f ; done > out
for f in `find . -name '*.o'` ; do echo [$f] ; sparc-elf-nm $f | grep builtin ; done
for f in `find . -name '*.o'` ; do echo [$f] ; sparc-coff-nm $f | grep builtin ; done > out
