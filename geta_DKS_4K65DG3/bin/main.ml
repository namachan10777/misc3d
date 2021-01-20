module S = Geta_DKS_4K65DG3.Shape

let cfg = {
    S.top = 40.0;
    S.bottom = 80.0;
    S.depth = {
        front = 140.0;
        back = 80.0;
    };
    S.height = 50.0;
    S.x_diff = 80.0;
    S.groove = {
        S.w = 20.0;
        S.h = 10.0;
    };
    wire_hall = {
        S.d = 50.0;
        S.h = 30.0;
        S.y = 60.0;
    };
}

let () =
    let oc = open_out "geta.scad" in
    Scad_ml.Util.write oc @@ Geta_DKS_4K65DG3.Shape.model cfg
