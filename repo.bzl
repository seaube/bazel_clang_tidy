_clang_tidy_repo_build_file_contents = """
alias(
    name = "clang-tidy",
    visibility = ["//visibility:public"],
    actual = "{clang_tidy_path}",
)
"""

def _clang_tidy_repo_impl(rctx):
    clang_tidy_path = rctx.which("clang-tidy")
    if clang_tidy_path == None:
        fail("Cannot find clang-tidy in PATH")
    
    rctx.symlink(clang_tidy_path, "bin/" + clang_tidy_path.basename)
    rctx.file(
        "BUILD.bazel",
        _clang_tidy_repo_build_file_contents.format(
            clang_tidy_path = "bin/" + clang_tidy_path.basename,
        ),
    )

_clang_tidy_repo = repository_rule(
    implementation = _clang_tidy_repo_impl,
)

def clang_tidy_repo():
    _clang_tidy_repo(name = "clang_tidy")
