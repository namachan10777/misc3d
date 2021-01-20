module M = Scad_ml.Model

open Scad_ml.Util

let top_w = 40.0
let bottom_w = 80.0
let h = 50.0
let eps = 3.0
let d_front = 140.0
let d_back = 80.0
let x_diff = 80.0
let groove_size = (20.0, 10.0)
let wire_hall_d = 50.0
let wire_hall_h = 30.0
let wire_hall_y = 60.

let model =
    let top_line = M.cube (top_w, eps, eps) in
    let bottom_line = M.cube (bottom_w, eps, eps) in
    let wall = M.hull [
        top_line |>> ((bottom_w -. top_w) /. 2., 0., h -. eps +. snd groove_size);
        bottom_line;
    ] in
    let groove_sec =
        M.cube (fst groove_size, 0.002 +. eps, 0.001 +. snd groove_size) |>> (0., -0.001, 0.0)
        |>> ((bottom_w -. fst groove_size) /. 2., 0., h) in
    let trace sec = M.union [
        M.hull [
            sec; sec |>> (x_diff, d_front -. eps, 0.0);
        ];
        M.hull [
            sec |>> (x_diff, d_front -. eps, 0.0);
            sec |>> (x_diff, d_front +. d_back -. eps, 0.0);
        ];
    ] in
    let wire_hall_w = bottom_w +. x_diff in
    let wire_hall = M.cube (2.0 +. wire_hall_w, wire_hall_d, wire_hall_h) |>> (-1., wire_hall_y, 0.) in
    M.difference (trace wall) [trace groove_sec; wire_hall]
