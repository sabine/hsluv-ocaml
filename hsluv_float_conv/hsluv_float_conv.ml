let float_triple_of_hsluv (c : Hsluv.hsluv) : float * float * float =
  (c.h, c.s, c.l)

let hsluv_of_float_triple (f : float * float * float) : Hsluv.hsluv =
  let h, s, l = f in
  { h; s; l }

let float_triple_of_hpluv (c : Hsluv.hpluv) : float * float * float =
  (c.h, c.p, c.l)

let hpluv_of_float_triple (f : float * float * float) : Hsluv.hpluv =
  let h, p, l = f in
  { h; p; l }

let float_triple_of_rgb (c : Hsluv.rgb) : float * float * float = (c.r, c.g, c.b)

let rgb_of_float_triple (f : float * float * float) : Hsluv.rgb =
  let r, g, b = f in
  { r; g; b }

let float_triple_of_xyz (c : Hsluv.xyz) : float * float * float = (c.x, c.y, c.z)

let xyz_of_float_triple (f : float * float * float) : Hsluv.xyz =
  let x, y, z = f in
  { x; y; z }

let float_triple_of_luv (c : Hsluv.luv) : float * float * float = (c.l, c.u, c.v)

let luv_of_float_triple (f : float * float * float) : Hsluv.luv =
  let l, u, v = f in
  { l; u; v }

let float_triple_of_lch (c : Hsluv.lch) : float * float * float = (c.l, c.c, c.h)

let lch_of_float_triple (f : float * float * float) : Hsluv.lch =
  let l, c, h = f in
  { l; c; h }
