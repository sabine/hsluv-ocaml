(* Ported from https://github.com/hsluv/hsluv-go/blob/cff9eb7ee0694105b0250075bb56243b1651165e/hsluv.go *)

(* Constants *)
let pi = Float.pi

let m =
  [|
    [| 3.2409699419045214; -1.5373831775700935; -0.49861076029300328 |];
    [| -0.96924363628087983; 1.8759675015077207; 0.041555057407175613 |];
    [| 0.055630079696993609; -0.20397695888897657; 1.0569715142428786 |];
  |]

let m_inv =
  [|
    [| 0.41239079926595948; 0.35758433938387796; 0.18048078840183429 |];
    [| 0.21263900587151036; 0.71516867876775593; 0.072192315360733715 |];
    [| 0.019330818715591851; 0.11919477979462599; 0.95053215224966058 |];
  |]

let ref_u = 0.19783000664283681
let ref_v = 0.468319994938791
let kappa = 903.2962962962963
let epsilon = 0.0088564516790356308

(* OCaml Stdlib's mod_float seems to allow negative results
   since it exposes C's fmod, so we override it *)
let mod_float f1 f2 =
  let r = mod_float f1 f2 in
  if r < 0. then r +. 360. else r

let round f = if abs_float f < 0.5 then 0 else int_of_float (f +. copysign 0.5 f)

let dot_product a b =
  let len = Array.length a in
  let rec dot_product_aux i acc =
    if i >= len then acc else dot_product_aux (i + 1) (acc +. (a.(i) *. b.(i)))
  in
  dot_product_aux 0 0.0

let from_linear c =
  if c <= 0.0031308 then 12.92 *. c else (1.055 *. (c ** (1.0 /. 2.4))) -. 0.055

let to_linear c =
  let a = 0.055 in
  if c > 0.04045 then ((c +. a) /. (1.0 +. a)) ** 2.4 else c /. 12.92

let intersect_line_line x1 y1 x2 y2 = (y1 -. y2) /. (x2 -. x1)
let distance_from_pole x y = sqrt ((x ** 2.0) +. (y ** 2.0))

let length_of_ray_until_intersect theta x y =
  y /. (sin theta -. (x *. cos theta))

let get_bounds l =
  let sub1 = ((l +. 16.0) ** 3.0) /. 1560896.0 in
  let sub2 = if sub1 > epsilon then sub1 else l /. kappa in
  let ret = Array.make_matrix 6 2 0.0 in
  Array.iteri
    (fun i mi ->
      for k = 0 to 1 do
        let top1 = ((284517.0 *. mi.(0)) -. (94839.0 *. mi.(2))) *. sub2 in
        let top2 =
          ((838422.0 *. mi.(2)) +. (769860.0 *. mi.(1)) +. (731718.0 *. mi.(0)))
          *. l *. sub2
          -. (769860.0 *. float_of_int k *. l)
        in
        let bottom =
          (((632260.0 *. mi.(2)) -. (126452.0 *. mi.(1))) *. sub2)
          +. (126452.0 *. float_of_int k)
        in
        ret.((i * 2) + k).(0) <- top1 /. bottom;
        ret.((i * 2) + k).(1) <- top2 /. bottom
      done)
    m;
  ret

let max_safe_chroma_for_l l =
  let bounds = get_bounds l in
  Array.fold_left
    (fun min_length line ->
      let m1 = line.(0) in
      let b1 = line.(1) in
      let x = intersect_line_line m1 b1 (-1.0 /. m1) 0.0 in
      let dist = distance_from_pole x (b1 +. (x *. m1)) in
      if dist < min_length then dist else min_length)
    max_float bounds

let max_chroma_for_lh l h =
  let h_rad = h /. 360.0 *. 2.0 *. Float.pi in
  let bounds = get_bounds l in
  let min_length =
    Array.fold_left
      (fun minLength line ->
        let length = length_of_ray_until_intersect h_rad line.(0) line.(1) in
        if length > 0.0 && length < minLength then length else minLength)
      Float.max_float bounds
  in
  min_length

let y_to_l y =
  if y <= epsilon then y *. kappa else (116.0 *. (y ** (1.0 /. 3.0))) -. 16.0

let l_to_y l = if l <= 8.0 then l /. kappa else ((l +. 16.0) /. 116.0) ** 3.0

(* Conversions *)

let conv_xyz_luv (x, y, z) =
  if y = 0.0 then (0.0, 0.0, 0.0)
  else
    let l = y_to_l y in
    let var_u = 4.0 *. x /. (x +. (15.0 *. y) +. (3.0 *. z)) in
    let var_v = 9.0 *. y /. (x +. (15.0 *. y) +. (3.0 *. z)) in
    let u = 13.0 *. l *. (var_u -. ref_u) in
    let v = 13.0 *. l *. (var_v -. ref_v) in
    (l, u, v)

let conv_luv_xyz (l, u, v) =
  if l = 0.0 then (0.0, 0.0, 0.0)
  else
    let var_u = (u /. (13.0 *. l)) +. ref_u in
    let var_v = (v /. (13.0 *. l)) +. ref_v in
    let y = l_to_y l in
    let x =
      -.(9.0 *. y *. var_u) /. (((var_u -. 4.0) *. var_v) -. (var_u *. var_v))
    in
    let z =
      ((9.0 *. y) -. (15.0 *. var_v *. y) -. (var_v *. x)) /. (3.0 *. var_v)
    in
    (x, y, z)

let conv_luv_lch (l, u, v) =
  let c = sqrt ((u ** 2.0) +. (v ** 2.0)) in
  let h_rad = atan2 v u in
  let h =
    if c < 0.00000001 then 0.0
    else mod_float (h_rad *. 360.0 /. (2.0 *. pi)) 360.0
  in
  (l, c, h)

let conv_lch_luv (l, c, h) =
  let h_rad = h /. 360.0 *. 2.0 *. pi in
  let u = cos h_rad *. c in
  let v = sin h_rad *. c in
  (l, u, v)

let conv_hsluv_lch (h, s, l) =
  if l > 99.9999999 || l < 0.00000001 then (l, 0., h)
  else
    let max = max_chroma_for_lh l h in
    (l, max /. 100.0 *. s, h)

let conv_lch_hsluv (l, c, h) =
  if l > 99.9999999 || l < 0.00000001 then (h, 0., l)
  else
    let max = max_chroma_for_lh l h in
    (h, c /. max *. 100.0, l)

let conv_hpluv_lch (h, s, l) =
  if l > 99.9999999 || l < 0.00000001 then (l, 0., h)
  else
    let max = max_safe_chroma_for_l l in
    (l, max /. 100. *. s, h)

let conv_lch_hpluv (l, c, h) =
  if l > 99.9999999 || l < 0.00000001 then (h, 0., l)
  else
    let max = max_safe_chroma_for_l l in
    (h, c /. max *. 100.0, l)

let conv_rgb_hex (r, g, b) =
  let rV = round (max 0.0 (min r 1.0) *. 255.0) in
  let gV = round (max 0.0 (min g 1.0) *. 255.0) in
  let bV = round (max 0.0 (min b 1.0) *. 255.0) in
  Printf.sprintf "#%02x%02x%02x" rV gV bV

let conv_hex_rgb hex =
  let hex =
    if String.length hex > 0 && hex.[0] = '#' then
      String.sub hex 1 (String.length hex - 1)
    else hex
  in
  let rV = int_of_string ("0x" ^ String.sub hex 0 2) in
  let gV = int_of_string ("0x" ^ String.sub hex 2 2) in
  let bV = int_of_string ("0x" ^ String.sub hex 4 2) in
  (float_of_int rV /. 255.0, float_of_int gV /. 255.0, float_of_int bV /. 255.0)

let conv_xyz_rgb (x, y, z) =
  let r = from_linear (dot_product m.(0) [| x; y; z |]) in
  let g = from_linear (dot_product m.(1) [| x; y; z |]) in
  let b = from_linear (dot_product m.(2) [| x; y; z |]) in
  (r, g, b)

let conv_rgb_xyz (r, g, b) =
  let r = to_linear r in
  let g = to_linear g in
  let b = to_linear b in
  let x = dot_product m_inv.(0) [| r; g; b |] in
  let y = dot_product m_inv.(1) [| r; g; b |] in
  let z = dot_product m_inv.(2) [| r; g; b |] in
  (x, y, z)

let conv_lch_rgb (l, c, h) =
  conv_lch_luv (l, c, h) |> conv_luv_xyz |> conv_xyz_rgb

let conv_rgb_lch (r, g, b) =
  conv_rgb_xyz (r, g, b) |> conv_xyz_luv |> conv_luv_lch

let conv_hsluv_rgb (h, s, l) = conv_hsluv_lch (h, s, l) |> conv_lch_rgb
let conv_rgb_hsluv (r, g, b) = conv_rgb_lch (r, g, b) |> conv_lch_hsluv

(* Hsluv and Hpluv *)

let hsluv_to_hex (h, s, l) = conv_hsluv_rgb (h, s, l) |> conv_rgb_hex
let hsluv_from_hex hex = conv_hex_rgb hex |> conv_rgb_hsluv
let hsluv_to_rgb = conv_hsluv_rgb
let hsluv_from_rgb = conv_rgb_hsluv

let hpluv_to_hex (h, s, l) =
  (h, s, l) |> conv_hpluv_lch |> conv_lch_luv |> conv_luv_xyz |> conv_xyz_rgb
  |> conv_rgb_hex

let hpluv_from_hex hex =
  hex |> conv_hex_rgb |> conv_rgb_xyz |> conv_xyz_luv |> conv_luv_lch
  |> conv_lch_hpluv

let hpluv_to_rgb (h, s, l) =
  (h, s, l) |> conv_hpluv_lch |> conv_lch_luv |> conv_luv_xyz |> conv_xyz_rgb

let hpluv_from_rgb (r, g, b) =
  (r, g, b) |> conv_rgb_xyz |> conv_xyz_luv |> conv_luv_lch |> conv_lch_hpluv
