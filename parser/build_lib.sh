#!/bin/bash
x86_64-w64-mingw32-g++ --static -static-libstdc++ -static-libgcc -o ../backend/CaffBackend/CaffParser/parser.dll -shared -Iinclude/ src/caff.cpp src/ciff.cpp src/common.cpp
g++ -static-libstdc++ -static-libgcc -o ../backend/CaffBackend/CaffParser/parser.so -shared -Iinclude/  src/caff.cpp src/ciff.cpp src/common.cpp
