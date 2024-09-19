#!/bin/bash

root_dir=$(pwd)
llvm_dir=$root_dir/llvm

# 编译的四个阶段
gcc $root_dir/main.c -E -o $llvm_dir/main.i # 获取预处理的文件
gcc $root_dir/main.c -S -o $llvm_dir/main.s # 获取汇编文件
gcc $root_dir/main.c -c -o $llvm_dir/main.o # 获取目标文件
gcc $root_dir/main.c -o $llvm_dir/main # 获取可执行文件

# 编译过程的中间文件
clang -E -Xclang -dump-tokens $root_dir/main.c # 词法分析
clang -E -Xclang -ast-dump $root_dir/main.c # 语法分析
clang -S -emit-llvm $root_dir/main.c -o $llvm_dir/main.ll # 生成LLVM IR

# LL编译为汇编文件以及汇编
llc -filetype=obj $llvm_dir/test3.ll -o test3.o
gcc test3.o -o test3 -pie