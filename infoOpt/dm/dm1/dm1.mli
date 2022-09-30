type etat = { value : int; }
val initial : etat
val suivants : etat -> etat list
val final : etat -> bool
val bfs : unit -> int
val ids : unit -> int
val h : int -> int
type int_inf = 
    | Value of int 
    | Infinity
