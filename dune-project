(lang dune 3.7)

(name hsluv)

(documentation "https://ocaml.org/p/hsluv/latest")

(source (github sabine/hsluv-ocaml))

(license MIT)

(authors
"Sabine Schmaltz")

(maintainers
"Sabine Schmaltz")

(generate_opam_files true)

(package
 (name hsluv)
 (synopsis "HSLuv human-friendly color space implementation in OCaml")
 (description "This package implements the HSLuv color space model, providing a perceptually uniform alternative to traditional HSL. It includes functions for converting between HSLuv/HPLuv and other color spaces like RGB, XYZ, and Luv.")
 (depends 
 (ocaml (>= 4.08.0))
 dune
 (yojson :with-test)
 (ppx_yojson_conv :with-test)
 ))
 