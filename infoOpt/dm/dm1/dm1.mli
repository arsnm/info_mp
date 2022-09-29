type etat = { value : int; }
val initial : etat
val suivants : etat -> etat list
val final : etat -> bool
val bfs : unit -> int
val ids : unit -> int
