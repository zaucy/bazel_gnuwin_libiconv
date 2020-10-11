
_build_file_contents = """
load("@rules_cc//cc:defs.bzl", "cc_library", "cc_import")

cc_import(
    name = "libiconv_dll",
    hdrs = ["include/iconv.h"],
    shared_library = "bin/libiconv2.dll",
)

cc_library(
    name = "libiconv",
    visibility = ["//visibility:public"],
    strip_include_prefix = "include",
    includes = ["include"],
    hdrs = ["include/iconv.h"],
    deps = [":libiconv_dll"],
)

cc_import(
    name = "libcharset_dll",
    hdrs = ["include/libcharset.h", "include/localcharset.h"],
    shared_library = "bin/libcharset1.dll",
)

cc_library(
    name = "libcharset",
    visibility = ["//visibility:public"],
    strip_include_prefix = "include",
    includes = ["include"],
    hdrs = ["include/libcharset.h", "include/localcharset.h"],
    deps = [":libcharset_dll"],
)
"""

def _gnuwin_libiconv_repository(rctx):
    lib_urls = [
        "https://iweb.dl.sourceforge.net/project/gnuwin32/libiconv/1.9.2-1/libiconv-1.9.2-1-lib.zip",
    ]

    bin_urls = [
        "https://cfhcable.dl.sourceforge.net/project/gnuwin32/libiconv/1.9.2-1/libiconv-1.9.2-1-bin.zip",
    ]

    rctx.download_and_extract(
        url = lib_urls,
        sha256 = "ed5050a701539d8075939222ff791513c0b2ebe40438e345a5854d67d050dfa7",
    )

    rctx.download_and_extract(
        url = bin_urls,
        sha256 = "66f494fb37d2ac9367ef8398071f19db4b670a3d2ea2361f970d65195c336bd9",
    )

    rctx.file("BUILD.bazel", _build_file_contents)

gnuwin_libiconv_repository = repository_rule(
    implementation = _gnuwin_libiconv_repository,
    attrs = {

    },
)
