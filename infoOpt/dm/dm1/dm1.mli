type etat = { value : int; }
val initial : etat
val suivants : etat -> etat list
val final : etat -> bool
val bfs : unit -> int
val ids : unit -> int
val h : int -> int
val grid : int array array
val h: int ref
val li : int ref
val lj : int ref
