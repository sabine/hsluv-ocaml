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

5. **Color Grading in Film and Photography**: Facilitates harmonious color transitions and adjustments.

In summary, HSLuv's appeal lies in its ability to provide visually consistent and natural-looking colors, making it suitable for design, data visualization, and artistic applications.

## Implementation 

This is a mostly faithful port of the Go implementation of hsluv.org at https://github.com/hsluv/hsluv-go.

## Tests

The implementation is tested against the [hsluv snapshot (revision 4)](https://raw.githubusercontent.com/hsluv/hsluv/master/snapshots/snapshot-rev4.json). Test cases are included and can be run with

```
opam exec -- dune test
```

