open Types

let pp_rgb ?(full_precision = false) fmt { r; g; b } =
  if full_precision then Format.fprintf fmt "{ r = %f; g = %f; b = %f }" r g b
  else Format.fprintf fmt "{ r = %.2f; g = %.2f; b = %.2f }" r g b

let pp_xyz ?(full_precision = false) fmt { x; y; z } =
  if full_precision then Format.fprintf fmt "{ x = %f; y = %f; z = %f }" x y z
  else Format.fprintf fmt "{ x = %.2f; y = %.2f; z = %.2f }" x y z

let pp_luv ?(full_precision = false) fmt { l; u; v } =
  if full_precision then Format.fprintf fmt "{ l = %f; u = %f; v = %f }" l u v
  else Format.fprintf fmt "{ l = %.2f; u = %.2f; v = %.2f }" l u v

let pp_lch ?(full_precision = false) fmt { l; c; h } =
  if full_precision then Format.fprintf fmt "{ l = %f; c = %f; h = %f }" l c h
  else Format.fprintf fmt "{ l = %.2f; c = %.2f; h = %.2f }" l c h

let pp_hsluv ?(full_precision = false) fmt { h; s; l } =
  if full_precision then Format.fprintf fmt "{ h = %f; s = %f; l = %f }" h s l
  else Format.fprintf fmt "{ h = %.2f; s = %.2f; l = %.2f }" h s l

let pp_hpluv ?(full_precision = false) fmt { h; p; l } =
  if full_precision then Format.fprintf fmt "{ h = %f; p = %f; l = %f }" h p l
  else Format.fprintf fmt "{ h = %.2f; p = %.2f; l = %.2f }" h p l
