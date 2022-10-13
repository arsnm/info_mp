(*DM1 - Arsène MALLET*)
type etat = {value : int} ;;
let initial = {value = 1} ;;
let suivants x = 
  [{value = x.value+1}; {value = 2*x.value}] ;;
let final x = 
  x.value = 42 ;;

type deplacement = 
|Gauche
|Bas
|Droite
|Haut

let h e = 
  if final e then 1 else 0
let bfs () =
  let rec dissimulatewhile a b p=
    match a with
    |[] -> (match b with
          |[] -> -1
          |_ -> dissimulatewhile b [] p+1)
    |h::t -> if final h then p else dissimulatewhile t ((suivants(h)) @ b) p
in dissimulatewhile [initial] [] 0 ;;

let ids () = 
  let rec dfs m e p = 
    if p>m then false 
    else if final e then true else
      let flag = ref false in
      let voisins = ref (suivants e) in
      while (!voisins <> []) && (!flag = false) do
        flag := dfs m (List.hd !voisins) (p+1);
        voisins := List.tl !voisins
      done;
      !flag
  in
    let m = ref 0 in
    while not (dfs !m initial 0) do
      m := !m + 1;
    done;
!m ;;

let min = ref 0 ;;

let rec dfsstar m e p =
  let c = p + (h e) in
  if c > m then 
    ((if c < !min then min := c) ; false) 
    else if (final e) then true else
      let flag = ref false in
      let voisins = ref (suivants e) in
      while (!voisins <> []) && (!flag = false) do
        flag := dfsstar m (List.hd !voisins) (p+1);
        voisins := List.tl !voisins
      done;
  !flag ;;

let idastar () = 
  let m = ref (h initial) in
  let flag = ref false in
  let m_final = ref !m in
  while !m <> max_int && not !flag do 
    begin
      min := max_int ;
      if dfsstar !m initial 0 then (flag := true ; m_final := !m);
      m := !min;
    end
  done;
  !m_final - 1 ;;

let grid = [| [|2; 3; 1; 6 |];
              [|14; 5; 8; 4 |];
              [|12; -1; 7; 9|];
              [|10; 13; 11; 0|]|]

(* let grid = [| [|0; 1; 2; 3 |];
              [|4; 5; 6; 7 |];
              [|8; 9; 10; 11|];
              [|12; 13; -1; 14|]|] *)

let li = ref 2
let lj = ref 1

let h_terme i j v =
  abs (i - v/4) +  abs (j - v mod 4) ;;

let calcul_h () = 
  let sum = ref 0 in
  for i = 0 to 3 do 
    for j = 0 to 3 do
      if not ((i = !li) && (j = !lj)) then
      sum := !sum + (h_terme i j (grid.(i).(j)))
    done;
  done;
  !sum
;;

let h = ref (calcul_h ()) ;;

let move i j = 
  let v = grid.(i).(j) in 
  begin
    grid.(!li).(!lj) <- grid.(i).(j) ; 
    grid.(i).(j) <- -1 ; (* Représentation de la case vide comme étant la case contenant -1*)
    h := !h - (h_terme i j v) + (h_terme !li !lj v);
    lj := j;
    li := i
  end;;


let haut () = move (!li + 1) !lj;;
let gauche () = move !li (!lj + 1);;
let bas () = move (!li - 1) !lj;;
let droite () = move !li (!lj - 1);;

let solution = ref []

let tente_gauche () = 
  match (!solution, !lj) with
    |_, 3 -> false
    |Droite::t, _ -> false
    |_ , _ -> solution := Gauche :: (!solution) ;
              gauche () ;
              true
;;

let tente_droite () = 
  match (!solution, !lj) with
    |_, 0 -> false
    |Gauche::t, _ -> false
    |_ , _ -> solution := Droite :: (!solution) ;
              droite () ;
              true
;;

let tente_haut () = 
  match (!solution, !li) with
    |_, 3 -> false
    |Bas::t, _ -> false
    |_ , _ -> solution := Haut :: (!solution) ;
              haut () ;
              true
;;

let tente_bas () = 
  match (!solution, !li) with
    |_, 0 -> false
    |Haut::t, _ -> false
    |_ , _ -> solution := Bas :: (!solution) ;
              bas () ;
              true
;;
let annule () =
  match !solution with
    |[] -> false
    |h::t -> begin 
              (match h with
              |Gauche -> droite ()
              |Droite -> gauche ()
              |Haut -> bas ()
              |Bas -> haut () );
              solution := t ;
              false
              end
            ;;

let rec dfs m p =
  let n = p + !h in
  if n > m then 
    begin
    if n < !min || !min = -1 then
    min := n ;
    false;
    end
  else 
    begin
    if !h = 0 then 
      true
    else
      (tente_droite() && (dfs m (p+1) || annule () )) ||
      (tente_gauche() && (dfs m (p+1) || annule () )) ||
      (tente_haut() && (dfs m (p+1) || annule () )) ||
      (tente_bas() && (dfs m (p+1) || annule () ));
    end
;;

let taquin () =
  let rec taquinstar m =
    if m = -1 then []
      else 
        begin
        min := -1 ;
        if dfs m 0 then !solution else taquinstar (!min)
        end ;
  in taquinstar (!h) ;;


let sol1 = taquin ();;

let rec print_deplacement_list l = 
  match l with
   |[] -> print_newline ()
   |h::t -> (match h with
   |Gauche -> print_string "Gauche"
   |Droite -> print_string "Droite"
   |Haut -> print_string "Haut"
   |Bas -> print_string "Bas") ; print_string " ; " ; print_deplacement_list t

;;

print_deplacement_list(sol1)