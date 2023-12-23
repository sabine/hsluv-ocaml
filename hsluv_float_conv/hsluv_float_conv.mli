val hsluv_of_float_triple : float * float * float -> Hsluv.hsluv
(** Converts a float triple (h, s, l) to an Hsluv.hsluv color space value. Example:
    {[
        hsluv_of_float_triple (260.0, 100.0, 75.0)
    ]} *)

val float_triple_of_hsluv : Hsluv.hsluv -> float * float * float
(** Converts an Hsluv.hsluv color space value to a float triple (h, s, l). Example:
    {[
        float_triple_of_hsluv { h = 180.0; s = 50.0; l = 60.0 }
    ]} *)

val hpluv_of_float_triple : float * float * float -> Hsluv.hpluv
(** Converts a float triple (h, p, l) to an Hsluv.hpluv color space value. Example:
    {[
        hpluv_of_float_triple (60.0, 25.0, 80.0)
    ]} *)

val float_triple_of_hpluv : Hsluv.hpluv -> float * float * float
(** Converts an Hsluv.hpluv color space value to a float triple (h, p, l). Example:
    {[
        float_triple_of_hpluv { h = 220.0; p = 80.0; l = 45.0 }
    ]} *)

val rgb_of_float_triple : float * float * float -> Hsluv.rgb
(** Converts a float triple (r, g, b) to an Hsluv.rgb color space value. Example:
    {[
        rgb_of_float_triple (1.0, 0.0, 0.0)
    ]} *)

val float_triple_of_rgb : Hsluv.rgb -> float * float * float
(** Converts an Hsluv.rgb color space value to a float triple (r, g, b). Example:
    {[
        float_triple_of_rgb { r = 0.5; g = 0.2; b = 0.8 }
    ]} *)

val xyz_of_float_triple : float * float * float -> Hsluv.xyz
(** Converts a float triple (x, y, z) to an Hsluv.xyz color space value. Example:
    {[
        xyz_of_float_triple (0.4124, 0.2126, 0.0193)
    ]} *)

val float_triple_of_xyz : Hsluv.xyz -> float * float * float
(** Converts an Hsluv.xyz color space value to a float triple (x, y, z). Example:
    {[
        float_triple_of_xyz { x = 0.5; y = 0.2; z = 0.8 }
    ]} *)

val luv_of_float_triple : float * float * float -> Hsluv.luv
(** Converts a float triple (l, u, v) to an Hsluv.luv color space value. Example:
    {[
        luv_of_float_triple (100.0, -25.0, 50.0)
    ]} *)

val float_triple_of_luv : Hsluv.luv -> float * float * float
(** Converts an Hsluv.luv color space value to a float triple (l, u, v). Example:
    {[
        float_triple_of_luv { l = 75.0; u = 10.0; v = 30.0 }
    ]} *)

val lch_of_float_triple : float * float * float -> Hsluv.lch
(** Converts a float triple (l, c, h) to an Hsluv.lch color space value. Example:
    {[
        lch_of_float_triple (75.0, 30.0, 220.0)
    ]} *)

val float_triple_of_lch : Hsluv.lch -> float * float * float
(** Converts an Hsluv.lch color space value to a float triple (l, c, h). Example:
    {[
        float_triple_of_lch { l = 50.0; c = 25.0; h = 180.0 }
    ]} *)
