type 'a arb = V | N of 'a * 'a arb * 'a arb ;;

let rotd treap = match treap with
    |N(r, N(gr, gg, gd), d) -> N(gr, gg, N(r, gd, d))
    |_ -> treap
;;

let rotg treap = match treap with
  |N(gr, gg, N(r, gd, d)) -> N(r, N(gr, gg, gd), d)
  |_ -> treap
;;

let prio tree = match tree with
|V -> max_int
|N((_, p), _, _) -> p
;;

let rec add treap e = 
      let elem, _ = e in
      match treap with
      |V -> N(e, V, V)
      |N((x, p), g, d) -> if elem >= x then 
                              let d_upt = add d e in
                                  if (prio d_upt) < p then
                                    rotg (N((x,p), g, d_upt))
                                  else N((x,p), g, d_upt)
                          else 
                              let g_upt = add g e in
                                if (prio g_upt) < p then
                                  rotd (N((x,p), g_upt, d))
                                else N((x,p), g_upt, d)
                        ;;

let treap1 = N((4,1), 
          N((2,4), 
            N((1,6), V, V), V),
          N((7,6),
            N((5,8), V, V),
            N((9,9), V, V)))
          ;;        

let treap2 = add treap1 (6, 0) ;;


let rec del treap e = match treap with
    |V -> V
    |N((x,p), g, d) -> if e > x then
                        N((x,p), g, (del d e))
                      else if e < x then
                        N((x,p), (del g e), d)
                      else match g,d with
                        |V, V -> V
                        |V, f |f, V -> f
                        |_ -> if prio g > prio d then
                              let treap_rot = rotg(treap) in
                                del treap_rot e
                              else let treap_rot = rotd(treap) in
                                del treap_rot e
                            ;;

let treap3 = del treap2 6