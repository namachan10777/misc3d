let () =
    let oc = open_out "geta.scad" in
    Scad_ml.Util.write oc @@ Geta_DKS_4K65DG3.Shape.model
