# ocaml-hsluv

HSLuv human-friendly color space implementation in OCaml.

See https://www.hsluv.org/.

## Description

This OCaml package implements the HSLuv color space model, providing a perceptually uniform alternative to traditional HSL. It includes functions for converting between HSLuv/HPLuv and other color spaces like RGB, XYZ, and Luv.

The HSLuv color space is particularly beneficial in scenarios where perceptual uniformity and intuitive color manipulation are crucial:

1. **Design and Visualization**: Ideal for creating balanced and harmonious color palettes with consistent hues.

2. **Data Representation**: Useful in data visualization for accurate and non-misleading representations, such as in heatmaps and graphs.

3. **Accessibility in User Interfaces**: Helps in maintaining consistent contrast, crucial for users with visual impairments.

4. **Digital Art and Image Processing**: Offers fine-tuning of colors for subtle and precise adjustments.

In summary, HSLuv's appeal lies in its ability to provide visually consistent and natural-looking colors, making it suitable for design, data visualization, and artistic applications.

## Implementation Notes

This started as a port of the [Go implementation of hsluv.org](https://github.com/hsluv/hsluv-go).

The following color conversions are provided:

| From/To      | HSLuv            | HPLuv            | RGB                 | XYZ                 | LUV                 | LCH                 | HEX                 |
|--------------|------------------|------------------|---------------------|---------------------|---------------------|---------------------|---------------------|
| **HSLuv**    | -                | -                | `hsluv_to_rgb`      | -                   | -                   | `conv_hsluv_lch`    | `hsluv_to_hex`      |
| **HPLuv**    | -                | -                | `hpluv_to_rgb`      | -                   | -                   | `conv_hpluv_lch`    | `hpluv_to_hex`      |
| **RGB**      | `hsluv_from_rgb` | `hpluv_from_rgb` | -                   | `conv_rgb_xyz`      | -                   | `conv_rgb_lch`      | `conv_rgb_hex`      |
| **XYZ**      | -                | -                | `conv_xyz_rgb`      | -                   | `conv_xyz_luv`      | -                   | -                   |
| **LUV**      | -                | -                | -                   | `conv_luv_xyz`      | -                   | `conv_luv_lch`      | -                   |
| **LCH**      | `conv_lch_hsluv` | `conv_lch_hpluv` | `conv_lch_rgb`      | -                   | `conv_luv_lch`      | -                   | -                   |
| **HEX**      | `hsluv_from_hex` | `hpluv_from_hex` | `conv_hex_rgb`      | -                   | -                   | -                   | -                   |

In addition to the HSLuv and HPLuv conversion functions, this package also exposes
- color conversion functions between the various color spaces used to enable the HSLuv and HPluv conversions
- pretty printers `pp_hsluv`, `pp_hpluv`, etc.
- a library `hsluv.float_conv` for conversions between float triples and the provided color types

## Tests

The implementation is tested against the [hsluv snapshot (revision 4)](https://raw.githubusercontent.com/hsluv/hsluv/master/snapshots/snapshot-rev4.json). Tests for all conversion functions are included and can be run with

```
opam exec -- dune test
```

