module M = Scad_ml.Model

open Scad_ml.Util

let eps = 3.0

type wire_hall_confg_t = {
    d: float;
    h: float;
    y: float;
}

type depth_config_t = {
    front: float;
    back: float;
}

type groove_config_t = {
    w: float;
    h: float;
}

type config_t = {
    top: float;
    bottom: float;
    height: float;
    depth: depth_config_t;
    x_diff: float;
    groove: groove_config_t;
    wire_hall: wire_hall_confg_t;
}

(*
 *  0.001とか足したりしてるのは全てプレビューでの見やすさのためです。
 *)

let model_left cfg =
    let top_line = M.cube (cfg.top, eps, eps) in
    let bottom_line = M.cube (cfg.bottom, eps, eps) in
    let wall = M.hull [
        top_line |>> ((cfg.bottom -. cfg.top) /. 2., 0., cfg.height -. eps +. cfg.groove.h);
        bottom_line;
    ] in
    let groove_sec =
        M.cube (cfg.groove.w, 0.002 +. eps, 0.001 +. cfg.groove.h) |>> (0., -0.001, 0.0)
        |>> ((cfg.bottom -. cfg.groove.w) /. 2., 0., cfg.height) in
    let trace sec = M.union [
        M.hull [
            sec; sec |>> (cfg.x_diff, cfg.depth.front -. eps, 0.0);
        ];
        M.hull [
            sec |>> (cfg.x_diff, cfg.depth.front -. eps, 0.0);
            sec |>> (cfg.x_diff, cfg.depth.front +. cfg.depth.back -. eps, 0.0);
        ];
    ] in
    let wire_hall_w = cfg.bottom +. cfg.x_diff in
    let wire_hall = M.cube (2.0 +. wire_hall_w, cfg.wire_hall.d, cfg.wire_hall.h +. 0.001) |>> (-1., cfg.wire_hall.y, -0.001) in
    M.difference (trace wall) [trace groove_sec; wire_hall]

let model_right cfg =
    model_left cfg |> M.mirror (1, 0, 0)
