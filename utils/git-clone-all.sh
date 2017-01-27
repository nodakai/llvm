#!/bin/sh

set -xe

if [ "$1" = llvm.org ]; then
    llvm_org=http://llvm.org/git
    clang_repo=$llvm_org/clang.git
    compiler_rt_repo=$llvm_org/compiler-rt.git
    clang_tools_extra_repo=$llvm_org/clang-tools-extra.git
    libomp_repo=$llvm_org/openmp.git
    libcxx_repo=$llvm_org/libcxx.git
    libcxxabi_repo=$llvm_org/libcxxabi.git
    lldb_repo=$llvm_org/lldb.git
    poly_repo=$llvm_org/polly.git
elif [ "$1" = "github" ]; then
    if [ -n "$2" ]; then
        github_user=$2
    else
        github_user=llvm-mirror
    fi
    github=https://github.com/$github_user
    clang_repo=$github/clang.git
    compiler_rt_repo=$github/compiler-rt.git
    clang_tools_extra_repo=$github/clang-tools-extra.git
    libomp_repo=$github/openmp.git
    libcxx_repo=$github/libcxx.git
    libcxxabi_repo=$github/libcxxabi.git
    lldb_repo=$github/lldb.git
    poly_repo=$github/polly.git
else
    "Usage: git-clone-all.sh ( llvm.org | github [your-account] )"
fi

thescript=$(readlink -f $0)  # llvm/utils/git-clone-all.sh
thescriptdir=${thescript%/*}  # llvm/utils
top_dir=${thescriptdir%/*}  # llvm
: $top_dir

test_and_clone() {
    repo=$1
    dir=$2
    if [ -e $dir ]; then
        ( git -C $dir fetch --all --prune )
    else
        git clone $repo $dir
    fi
    git -C $dir checkout origin/master
}

cd $top_dir/projects
test_and_clone "$compiler_rt_repo" compiler-rt
test_and_clone "$libomp_repo" openmp
test_and_clone "$libcxx_repo" libcxx
test_and_clone "$libcxxabi_repo" libcxxabi

cd $top_dir/tools
test_and_clone "$clang_repo" clang
test_and_clone "$lldb_repo" lldb
test_and_clone "$polly_repo" polly
cd clang/tools
test_and_clone "$clang_tools_extra_repo" extra

: "===================="
: "==    All done    =="
: "===================="
