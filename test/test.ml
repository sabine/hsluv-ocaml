open Ppx_yojson_conv_lib.Yojson_conv

type rgb = float * float * float [@@deriving yojson]
type xyz = float * float * float [@@deriving yojson]
type luv = float * float * float [@@deriving yojson]
type lch = float * float * float [@@deriving yojson]
type hsluv = float * float * float [@@deriving yojson]
type hpluv = float * float * float [@@deriving yojson]

type values = {
  rgb : rgb;
  xyz : xyz;
  luv : luv;
  lch : lch;
  hsluv : hsluv;
  hpluv : hpluv;
}
[@@deriving yojson]

let delta = 0.00000001
let is_close (a : float) (b : float) : bool = abs_float (a -. b) < delta

let compare_float_triplets (name : string) (input : string)
    (expected : float * float * float) (actual : float * float * float)
    (fail_count : int ref) =
  let e1, e2, e3 = expected in
  let a1, a2, a3 = actual in
  if not (is_close e1 a1 && is_close e2 a2 && is_close e3 a3) then (
    incr fail_count;
    Printf.printf
      "Failed: %s\nInput: %s\nExpected: (%f, %f, %f)\nGot: (%f, %f, %f)\n\n"
      name input e1 e2 e3 a1 a2 a3)

let compare_strings (name : string) (input : string) (expected : string)
    (actual : string) (fail_count : int ref) =
  if expected <> actual then (
    incr fail_count;
    Printf.printf "Failed: %s\nInput: %s\nExpected: %s\nGot: %s\n\n" name input
      expected actual)

let parse_json str =
  let open Yojson.Safe.Util in
  let json = Yojson.Safe.from_string str in
  json |> to_assoc
  |> List.map (fun (hex, value) -> (hex, values_of_yojson value))

let test_snapshot () =
  let fail_count = ref 0 in
  let snapshot = parse_json Hsluv_reference.json_string in

  List.iter
    (fun (hex, color_values) ->
      let hex_str = Printf.sprintf "\"%s\"" hex in

      compare_strings "hsluv_to_hex" hex_str hex
        (Hsluv.hsluv_to_hex color_values.hsluv)
        fail_count;
      compare_float_triplets "hsluv_from_hex" hex_str color_values.hsluv
        (Hsluv.hsluv_from_hex hex) fail_count;

      compare_float_triplets "hsluv_to_rgb" hex_str color_values.rgb
        (Hsluv.hsluv_to_rgb color_values.hsluv)
        fail_count;
      compare_float_triplets "hsluv_from_rgb" hex_str color_values.hsluv
        (Hsluv.hsluv_from_rgb color_values.rgb)
        fail_count;

      compare_strings "hpluv_to_hex" hex_str hex
        (Hsluv.hpluv_to_hex color_values.hpluv)
        fail_count;
      compare_float_triplets "hpluv_from_hex" hex_str color_values.hpluv
        (Hsluv.hpluv_from_hex hex) fail_count;

      compare_float_triplets "hpluv_to_rgb" hex_str color_values.rgb
        (Hsluv.hpluv_to_rgb color_values.hpluv)
        fail_count;
      compare_float_triplets "hpluv_from_rgb" hex_str color_values.hpluv
        (Hsluv.hpluv_from_rgb color_values.rgb)
        fail_count;

      (* testing internal functions *)
      compare_float_triplets "conv_lch_rgb" hex_str color_values.rgb
        (Hsluv.conv_lch_rgb color_values.lch)
        fail_count;
      compare_float_triplets "conv_rgb_lch" hex_str color_values.lch
        (Hsluv.conv_rgb_lch color_values.rgb)
        fail_count;

      compare_float_triplets "conv_xyz_luv" hex_str color_values.luv
        (Hsluv.conv_xyz_luv color_values.xyz)
        fail_count;
      compare_float_triplets "conv_luv_xyz" hex_str color_values.xyz
        (Hsluv.conv_luv_xyz color_values.luv)
        fail_count;

      compare_float_triplets "conv_luv_lch" hex_str color_values.lch
        (Hsluv.conv_luv_lch color_values.luv)
        fail_count;
      compare_float_triplets "conv_lch_luv" hex_str color_values.luv
        (Hsluv.conv_lch_luv color_values.lch)
        fail_count;

      compare_float_triplets "conv_hsluv_lch" hex_str color_values.lch
        (Hsluv.conv_hsluv_lch color_values.hsluv)
        fail_count;
      compare_float_triplets "conv_lch_hsluv" hex_str color_values.hsluv
        (Hsluv.conv_lch_hsluv color_values.lch)
        fail_count;

      compare_float_triplets "conv_hpluv_lch" hex_str color_values.lch
        (Hsluv.conv_hpluv_lch color_values.hpluv)
        fail_count;
      compare_float_triplets "conv_lch_hpluv" hex_str color_values.hpluv
        (Hsluv.conv_lch_hpluv color_values.lch)
        fail_count;

      compare_strings "conv_rgb_hex" hex_str hex
        (Hsluv.conv_rgb_hex color_values.rgb)
        fail_count;
      compare_float_triplets "conv_hex_rgb" hex_str color_values.rgb
        (Hsluv.conv_hex_rgb hex) fail_count;

      compare_float_triplets "conv_xyz_rgb" hex_str color_values.rgb
        (Hsluv.conv_xyz_rgb color_values.xyz)
        fail_count;
      compare_float_triplets "conv_rgb_xyz" hex_str color_values.xyz
        (Hsluv.conv_rgb_xyz color_values.rgb)
        fail_count;

      compare_strings "conv_rgb_hex" hex_str hex
        (Hsluv.conv_rgb_hex color_values.rgb)
        fail_count;
      compare_float_triplets "conv_hex_rgb" hex_str color_values.rgb
        (Hsluv.conv_hex_rgb hex) fail_count)
    snapshot;

  Printf.printf "Total tests failed: %d out of %d\n" !fail_count
    (List.length snapshot * 22);

  assert (!fail_count = 0)

let () = test_snapshot ()
