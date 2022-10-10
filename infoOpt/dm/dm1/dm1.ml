(*DM1 - Arsène MALLET*)
type etat = {value : int} ;;
let initial = {value = 1} ;;
let suivants x = 
  [{value = x.value+1}; {value = 2*x.value}] ;;
let final x = 
  x.value = 42 ;;

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

print_int
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

let grid = [| [|0; 1; 2; 3 |];
              [|4; 5; 6; 7 |];
              [|8; 9; 10; 11|];
              [|12; 13; 14; -1|]|]

let h = ref 0
let li = ref 3
let lj = ref 3

let h_terme i j v =
  abs (i - v/4) +  abs (j - v mod 4)

let move i j = 
  let v = grid.(i).(j) in 
  begin
    grid.(!li).(!lj) <- grid.(i).(j) ; 
    grid.(i).(j) <- -1 ; (* Représentation de la case vide comme étant la case contenant -1*)
    h := !h - (h_terme i j v) + (h_terme !li !lj v);
    lj := j;
    li := i
  end

let tente_gauche () =
  if 