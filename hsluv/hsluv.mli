(** 
    HSLuv and HPLuv color models as well as other common color spaces like RGB and XYZ, modeled as record types;
    provides conversion functions between the different color spaces and pretty-printers for all the color types.

    Colors are represented as record types, to ensure
    that no mistakes converting between colors can be made.

    In addition to the HSLuv and HPLuv color conversion
    functions, we also expose the color conversion
    functions that are used to implement the HSLuv and
    HPLuv conversions.

    Further, pretty printers are included for the color types.
*)

(** {1 Types} *)

type hsluv = { h : float; s : float; l : float }
(** [hsluv] represents the HSLuv color space, a human-friendly version of the HSL color model, where:
    - [h] is the hue component in degrees (0-360).
    - [s] is the saturation component as a percentage (0-100).
    - [l] is the lightness component as a percentage (0-100).

    This color space aims to provide more uniform color distribution and is suitable for accurate color balancing. *)

type hpluv = { h : float; p : float; l : float }
(** [hpluv] represents the HPLuv color space, a variant of HSLuv with constant perceived lightness, where:
    - [h] is the hue component in degrees (0-360).
    - [p] is a measure of chroma (similar to saturation) as a percentage (0-100).
    - [l] is the lightness component as a percentage (0-100).

    HPLuv is designed for applications requiring consistent perceptual lightness. *)

type rgb = { r : float; g : float; b : float }
(** [rgb] represents the RGB color space where:
    - [r] is the red component ranging from 0.0 to 1.0.
    - [g] is the green component ranging from 0.0 to 1.0.
    - [b] is the blue component ranging from 0.0 to 1.0.
 
    This color space is commonly used in digital imaging. *)

type xyz = { x : float; y : float; z : float }
(** [xyz] represents the CIE 1931 XYZ color space where:
    - [x] is the X component.
    - [y] is the Y component, representing luminance.
    - [z] is the Z component.

    This color space serves as a standard reference against which other color spaces are defined. *)

type luv = { l : float; u : float; v : float }
(** [luv] represents the CIE L*u*v* color space where:
    - [l] is the lightness component.
    - [u] and [v] are the color-opponent dimensions.

    This color space is designed to be perceptually uniform with regard to human color vision. *)

type lch = { l : float; c : float; h : float }
(** [lch] represents the L*C*h color space, a cylindrical representation of the CIE L*a*b* color space, where:
    - [l] is the lightness component.
    - [c] is the chroma component.
    - [h] is the hue component in degrees (0-360).

    This color space is useful for creating perceptually balanced color palettes. *)

(** {1 Hsluv and Hpluv Color Conversion} *)

val hsluv_to_hex : hsluv -> string
(** Converts HSLuv color space values to a hex color string. Example:
    {[
        hsluv_to_hex {h = 260.0; s = 100.0; l = 50.0}
    ]} *)

val hsluv_from_hex : string -> hsluv
(** Converts a hex color string to HSLuv color space values. Example:
    {[
        hsluv_from_hex "#ff00ff"
    ]} *)

val hsluv_to_rgb : hsluv -> rgb
(** Directly converts HSLuv color space values to RGB. Example:
    {[
        hsluv_to_rgb {h = 260.0; s = 100.0; l = 50.0}
    ]} *)

val hsluv_from_rgb : rgb -> hsluv
(** Converts RGB color space values to HSLuv. Example:
    {[
        hsluv_from_rgb {r = 1.0; g = 0.0; b = 1.0}
    ]} *)

val hpluv_to_hex : hpluv -> string
(** Converts HPLuv color space values to a hex color string. Example:
    {[
        hpluv_to_hex {h = 260.0; p = 100.0; l = 50.0}
    ]} *)

val hpluv_from_hex : string -> hpluv
(** Converts a hex color string to HPLuv color space values. Example:
    {[
        hpluv_from_hex "#ff00ff"
    ]} *)

val hpluv_to_rgb : hpluv -> rgb
(** Directly converts HPLuv color space values to RGB. Example:
    {[
        hpluv_to_rgb {h = 260.0; p = 100.0; l = 50.0}
    ]} *)

val hpluv_from_rgb : rgb -> hpluv
(** Converts RGB color space values to HPLuv. Example:
    {[
        hpluv_from_rgb {r = 1.0; g = 0.0; b = 1.0}
    ]} *)

(** {1 Other Color Conversion Functions} *)

val conv_xyz_luv : xyz -> luv
(** Converts XYZ color space values to Luv. Example:
    {[
        conv_xyz_luv { x = 0.4124; y = 0.2126; z = 0.0193 }
    ]} *)

val conv_luv_xyz : luv -> xyz
(** Converts Luv color space values to XYZ. Example:
    {[
        conv_luv_xyz { l = 100.0; u = 0.0; v = 0.0 }
    ]} *)

val conv_luv_lch : luv -> lch
(** Converts Luv color space values to LCh. Example:
    {[
        conv_luv_lch { l = 100.0; u = 0.0; v = 0.0 }
    ]} *)

val conv_lch_luv : lch -> luv
(** Converts LCh color space values to Luv. Example:
    {[
        conv_lch_luv { l = 100.0; c = 0.0; h = 0.0 }
    ]} *)

val conv_hsluv_lch : hsluv -> lch
(** Converts HSLuv color space values to LCh. Example:
    {[
        conv_hsluv_lch { h = 360.0; s = 100.0; l = 100.0 }
    ]} *)

val conv_lch_hsluv : lch -> hsluv
(** Converts LCh color space values to HSLuv. Example:
    {[
        conv_lch_hsluv { l = 100.0; c = 100.0; h = 360.0 }
    ]} *)

val conv_hpluv_lch : hpluv -> lch
(** Converts HPLuv color space values to LCh. Example:
    {[
        conv_hpluv_lch { h = 360.0; p = 100.0; l = 100.0 }
    ]} *)

val conv_lch_hpluv : lch -> hpluv
(** Converts LCh color space values to HPLuv. Example:
    {[
        conv_lch_hpluv { l = 100.0; c = 100.0; h = 360.0 }
    ]} *)

val conv_rgb_hex : rgb -> string
(** Converts RGB color space values to a hex color string. Example:
    {[
        conv_rgb_hex { r = 1.0; g = 0.0; b = 0.0 }
    ]} *)

val conv_hex_rgb : string -> rgb
(** Converts a hex color string to RGB color space values. Example:
    {[
        conv_hex_rgb "#ff0000"
    ]} *)

val conv_xyz_rgb : xyz -> rgb
(** Converts XYZ color space values to RGB. Example:
    {[
        conv_xyz_rgb { x = 0.4124; y = 0.2126; z = 0.0193 }
    ]} *)

val conv_rgb_xyz : rgb -> xyz
(** Converts RGB color space values to XYZ. Example:
    {[
        conv_rgb_xyz { r = 1.0; g = 0.0; b = 0.0 }
    ]} *)

val conv_lch_rgb : lch -> rgb
(** Converts LCh color space values to RGB. Example:
    {[
        conv_lch_rgb { l = 100.0; c = 100.0; h = 360.0 }
    ]} *)

val conv_rgb_lch : rgb -> lch
(** Converts RGB color space values to LCh. Example:
    {[
        conv_rgb_lch { r = 1.0; g = 0.0; b = 0.0 }
    ]} *)

val conv_hsluv_rgb : hsluv -> rgb
(** Converts HSLuv color space values to RGB. Example:
    {[
        conv_hsluv_rgb { h = 360.0; s = 100.0; l = 100.0 }
    ]} *)

val conv_rgb_hsluv : rgb -> hsluv
(** Converts RGB color space values to HSLuv. Example:
    {[
        conv_rgb_hsluv { r = 1.0; g = 0.0; b = 0.0 }
    ]} *)

(** {1 Pretty-Printers} *)

val pp_rgb : ?full_precision:bool -> Format.formatter -> rgb -> unit
(** Pretty-printer for RGB color values. Example:
    {[
        let rgb_value = {r = 1.0; g = 0.5; b = 0.25} in
        Printf.printf "RGB: %a\n" pp_rgb rgb_value
    ]} *)

val pp_xyz : ?full_precision:bool -> Format.formatter -> xyz -> unit
(** Pretty-printer for XYZ color values. Example:
    {[
        let xyz_value = {x = 0.5; y = 0.3; z = 0.2} in
        Printf.printf "XYZ: %a\n" pp_xyz xyz_value
    ]} *)

val pp_luv : ?full_precision:bool -> Format.formatter -> luv -> unit
(** Pretty-printer for LUV color values. Example:
    {[
        let luv_value = {l = 70.0; u = 30.0; v = 40.0} in
        Printf.printf "LUV: %a\n" pp_luv luv_value
    ]} *)

val pp_lch : ?full_precision:bool -> Format.formatter -> lch -> unit
(** Pretty-printer for LCH color values. Example:
    {[
        let lch_value = {l = 70.0; c = 30.0; h = 60.0} in
        Printf.printf "LCH: %a\n" pp_lch lch_value
    ]} *)

val pp_hsluv : ?full_precision:bool -> Format.formatter -> hsluv -> unit
(** Pretty-printer for HSLuv color values. Example:
    {[
        let hsluv_value = {h = 120.0; s = 50.0; l = 70.0} in
        Printf.printf "HSLuv: %a\n" pp_hsluv hsluv_value
    ]} *)

val pp_hpluv : ?full_precision:bool -> Format.formatter -> hpluv -> unit
(** Pretty-printer for HPLuv color values. Example:
    {[
        let hpluv_value = {h = 240.0; p = 50.0; l = 70.0} in
        Printf.printf "HPLuv: %a\n" pp_hpluv hpluv_value
    ]} *)
