(** {1 Hsluv and Hpluv conversion} *)

val hsluv_to_hex : float * float * float -> string
(** [hsluv_to_hex (h, s, l)] converts HSLuv color space values to a hex color string.
    
    Example: [hsluv_to_hex (260.0, 100.0, 50.0)] *)

val hsluv_from_hex : string -> float * float * float
(** [hsluv_from_hex hex] converts a hex color string to HSLuv color space values.

    Example: [hsluv_from_hex "#ff00ff"] *)

val hsluv_to_rgb : float * float * float -> float * float * float
(** [hsluv_to_rgb (h, s, l)] directly converts HSLuv color space values to RGB.

    Example: [hsluv_to_rgb (260.0, 100.0, 50.0)] *)

val hsluv_from_rgb : float * float * float -> float * float * float
(** [hsluv_from_rgb (r, g, b)] converts RGB color space values to HSLuv.

    Example: [hsluv_from_rgb (1.0, 0.0, 1.0)] *)

val hpluv_to_hex : float * float * float -> string
(** [hpluv_to_hex (h, s, l)] converts HPLuv color space values to a hex color string.

    Example: [hpluv_to_hex (260.0, 100.0, 50.0)] *)

val hpluv_from_hex : string -> float * float * float
(** [hpluv_from_hex hex] converts a hex color string to HPLuv color space values.

    Example: [hpluv_from_hex "#ff00ff"] *)

val hpluv_to_rgb : float * float * float -> float * float * float
(** [hpluv_to_rgb (h, s, l)] directly converts HPLuv color space values to RGB.

    Example: [hpluv_to_rgb (260.0, 100.0, 50.0)] *)

val hpluv_from_rgb : float * float * float -> float * float * float
(** [hpluv_from_rgb (r, g, b)] converts RGB color space values to HPLuv.

    Example: [hpluv_from_rgb (1.0, 0.0, 1.0)] *)

(** {1 Other Conversion Functions} *)

val conv_xyz_luv : float * float * float -> float * float * float
(** Converts XYZ color space values to Luv.

    Example: [conv_xyz_luv (0.4124, 0.2126, 0.0193)] *)

val conv_luv_xyz : float * float * float -> float * float * float
(** Converts Luv color space values to XYZ.

    Example: [conv_luv_xyz (100.0, 0.0, 0.0)] *)

val conv_luv_lch : float * float * float -> float * float * float
(** Converts Luv color space values to LCh.

    Example: [conv_luv_lch (100.0, 0.0, 0.0)] *)

val conv_lch_luv : float * float * float -> float * float * float
(** Converts LCh color space values to Luv.

    Example: [conv_lch_luv (100.0, 0.0, 0.0)] *)

val conv_hsluv_lch : float * float * float -> float * float * float
(** Converts HSLuv color space values to LCh.

    Example: [conv_hsluv_lch (360.0, 100.0, 100.0)] *)

val conv_lch_hsluv : float * float * float -> float * float * float
(** Converts LCh color space values to HSLuv.

    Example: [conv_lch_hsluv (100.0, 100.0, 360.0)] *)

val conv_hpluv_lch : float * float * float -> float * float * float
(** Converts HPLuv color space values to LCh.

    Example: [conv_hpluv_lch (360.0, 100.0, 100.0)] *)

val conv_lch_hpluv : float * float * float -> float * float * float
(** Converts LCh color space values to HPLuv.

    Example: [conv_lch_hpluv (100.0, 100.0, 360.0)] *)

val conv_rgb_hex : float * float * float -> string
(** Converts RGB color space values to a hex color string.

    Example: [conv_rgb_hex (1.0, 0.0, 0.0)] *)

val conv_hex_rgb : string -> float * float * float
(** Converts a hex color string to RGB color space values.

    Example: [conv_hex_rgb "#ff0000"] *)

val conv_xyz_rgb : float * float * float -> float * float * float
(** Converts XYZ color space values to RGB.

    Example: [conv_xyz_rgb (0.4124, 0.2126, 0.0193)] *)

val conv_rgb_xyz : float * float * float -> float * float * float
(** Converts RGB color space values to XYZ.

    Example: [conv_rgb_xyz (1.0, 0.0, 0.0)] *)

val conv_lch_rgb : float * float * float -> float * float * float
(** Converts LCh color space values to RGB.

    Example: [conv_lch_rgb (100.0, 100.0, 360.0)] *)

val conv_rgb_lch : float * float * float -> float * float * float
(** Converts RGB color space values to LCh.

    Example: [conv_rgb_lch (1.0, 0.0, 0.0)] *)

val conv_hsluv_rgb : float * float * float -> float * float * float
(** Converts HSLuv color space values to RGB.

    Example: [conv_hsluv_rgb (360.0, 100.0, 100.0)] *)

val conv_rgb_hsluv : float * float * float -> float * float * float
(** Converts RGB color space values to HSLuv.

    Example: [conv_rgb_hsluv (1.0, 0.0, 0.0)] *)
