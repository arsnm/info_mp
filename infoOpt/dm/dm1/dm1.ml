(*DM1 - Arsène MALLET*)
type etat = {value : int} ;;
let initial = {value = 1} ;;
let suivants x = 
  [{value = x.value+1}; {value = 2*x.value}] ;;
let final x = 
  x.value = 42 ;;
let bfs () =
  let rec dissimulatewhile a b p=
    match a with
    |[] -> (match b with
          |[] -> -1
          |_ -> dissimulatewhile b [] p+1)
    |h::t -> if final h then p else dissimulatewhile t (List.append (suivants(h)) b) p
in dissimulatewhile [initial] [] 0 ;;

print_int(bfs ()) ;;

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
