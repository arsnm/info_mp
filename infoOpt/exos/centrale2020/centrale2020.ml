open Printf

type candidat = int ;;
type bulletin = candidat list ;;
type urne = bulletin list ;;


let urne = [[2; 0; 1]; [2; 1; 0]; [1; 2; 0]] ;; 

let duel cand1 cand2 urne =
  let rec bulletin cand1 cand2 bul=
    match bul with
     |[] -> -1 (*Renvoie -1 si aucun des candidats n'est dans le bulletin : ne devrait pas arriver*)
     |h::t -> if h = cand1 || h = cand2 then h else (bulletin cand1 cand2 t) in
  let rec aux cand1 cand2 urne score = 
    match urne with
      |[] -> score
      |h::t -> let res = bulletin cand1 cand2 h in 
      if res = cand1 then 
        aux cand1 cand2 t (score + 1) 
      else 
        aux cand1 cand2 t (score - 1) in
  aux cand1 cand2 urne 0;;

let depouillement n urne = 
  let res = Array.make_matrix n n 0 in
  for cand1 = 0 to n-1 do
    for cand2 = 0 to n-1 do 
      if cand1 <> cand2 then
        res.(cand1).(cand2) <- duel cand1 cand2 urne
      done;
    done;
  res ;;

let depouille = depouillement 3 urne

let print_matrix_int matrix = 
  for i = 0 to (Array.length matrix.(0)) -1 do
    Array.iter (printf "%d ") matrix.(i);
    print_newline ()
  done; ;;

print_matrix_int depouille;;