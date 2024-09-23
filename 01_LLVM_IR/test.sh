#!/bin/bash

root_dir=$(pwd)
llvm_dir=$root_dir/llvm
asm_dir=$root_dir/asm
build_dir=$root_dir/build

# # 编译的四个阶段
# gcc $root_dir/main.c -E -o $llvm_dir/main.i # 获取预处理的文件
# gcc $root_dir/main.c -S -o $llvm_dir/main.s # 获取汇编文件
# gcc $root_dir/main.c -c -o $llvm_dir/main.o # 获取目标文件
# gcc $root_dir/main.c -o $llvm_dir/main # 获取可执行文件

# # 编译过程的中间文件
# clang -E -Xclang -dump-tokens $root_dir/main.c # 词法分析
# clang -E -Xclang -ast-dump $root_dir/main.c # 语法分析
# clang -S -emit-llvm $root_dir/main.c -o $llvm_dir/main.ll # 生成LLVM IR

# # LL编译为汇编文件以及汇编
# llc -filetype=obj $llvm_dir/test3.ll -o test3.o
# gcc test3.o -o test3 -pie

# 汇编文件编译为目标文件以及可执行文件
riscv64-unknown-elf-gcc -c $asm_dir/test1.s -o $build_dir/test/test1.o
riscv64-unknown-elf-gcc $build_dir/test/test1.o -o $build_dir/test/test1 -no-pie
riscv64-unknown-elf-gcc -c $asm_dir/test2.s -o $build_dir/test/test2.o
riscv64-unknown-elf-gcc $build_dir/test/test2.o -o $build_dir/test/test2 -no-pie
riscv64-unknown-elf-gcc -c $asm_dir/test3.s -o $build_dir/test/test3.o
riscv64-unknown-elf-gcc $build_dir/test/test3.o -o $build_dir/test/test3 -no-pie