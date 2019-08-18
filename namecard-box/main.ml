#use "../scad_ml/src/scad.ml"
open Util

let build scad filename = 
    let oc = open_out_gen [Open_wronly; Open_trunc; Open_creat] 0o666 filename in
    Scad.write oc scad;
    close_out oc

let namecard_size = (91., 55.)
let pocket_padding = 2.0
let wall_t = 5.0
let pocket_thin = 20.
let pocket_depth = 60.

let row_n = 2
let col_n = 3

let namecard_box =
    let base = Model.cube (
        (wall_t +. pocket_padding +. snd namecard_size) *. (float_of_int row_n) +. wall_t,
        (wall_t +. pocket_padding +. pocket_thin) *. (float_of_int col_n) +. wall_t,
        pocket_depth +. wall_t
    ) in
    let pocket = Model.cube (
        pocket_padding +. snd namecard_size,
        pocket_padding +. pocket_thin,
        pocket_depth
    ) in
    let row =
        List.init row_n (fun i -> pocket |>> ((wall_t +. pocket_padding +. snd namecard_size) *. float_of_int i, 0., 0.))
        |> Model.union in
    let pockets =
        List.init col_n (fun i -> row |>> (0., (wall_t +. pocket_padding +. pocket_thin) *. float_of_int i, 0.))
        |> Model.union in
    Model.difference base [
        pockets |>> (wall_t, wall_t, wall_t);
    ]
    
let () =
    build namecard_box "namecard-box.scad"
