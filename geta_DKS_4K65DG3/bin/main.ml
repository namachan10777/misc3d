module S = Geta_DKS_4K65DG3.Shape

let cfg = {
    S.top = 50.0;
    S.bottom = 80.0;
    S.depth = {
        front = 140.0;
        back = 80.0;
    };
    S.height = 30.0;
    S.x_diff = 80.0;
    S.groove = {
        S.w = 30.0;
        S.h = 10.0;
    };
    wire_hall = {
        S.d = 70.0;
        S.h = 20.0;
        S.y = 110.0;
    };
}

let () =
    let r_oc = open_out "geta-r.scad" in
    let l_oc = open_out "geta-l.scad" in
    Scad_ml.Util.write l_oc @@ Geta_DKS_4K65DG3.Shape.model_left cfg;
    Scad_ml.Util.write r_oc @@ Geta_DKS_4K65DG3.Shape.model_right cfg
