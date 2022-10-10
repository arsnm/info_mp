---
title : TD - Représentations et Parcours de Graphes
subtitle : Arsène MALLET - MP*
---

# Exercice 1 - Représentations

1. **Méthode 1**  
$ A = 
\begin{pmatrix}
1 & 1 & 1 \\
0 & 1 & 1 \\
0 & 0 & 1
\end{pmatrix}$, donc
$A^{100} = (I_3 + J)^{100}$   
Or
$ J = \begin{pmatrix}
0 & 1 & 0 \\
0 & 0 & 1 \\
0 & 0 & 0
\end{pmatrix}
,
J^2 = \begin{pmatrix}
0 & 0 & 1 \\
0 & 0 & 0 \\
0 & 0 & 0
\end{pmatrix},
J^3 = (0)_3 $  
Donc 
$$\begin{align*}
A^{100} & = I_3^{100} + \binom{100}{1} J + \binom{100}{2}J^2 \\
  &= I_3^{100} + 100 J + 4950J^2  \\
  &= \begin{pmatrix}
    1 & 100 & 4950 \\
    0 & 1 & 100 \\
    0 & 0 & 1 
    \end{pmatrix}
\end{align*}$$
Il y a donc 4950 chemins de longeur 100 entre 0 et 2

**Méthode 2**  
Sur les 100 déplacements, il y en a 2 qui changent de sommets (et les autres qui restent). Une fois ces deux déplacements choisis, les autres sont forcés $\rightarrow \binom{100}{2} = 4950$

2. Tester si la ligne i n'a que des 0 et colonne i que des 1 :
```
i <- 0
Pour j = 0 à n-1:
    Si m.(i).(j) = 1:
        i <- j
```

3. - Determiner les racines
    - Calculer un tableau fils tq fils.(v) est la liste des fils de v
    - Construction récursive de l'arbre.



```ocaml
type 'a arb = N of 'a * 'a  arb list

let pere_to_arb pere =
    let r = ref (-1) in
    let i = ref (0) in
    while !r = -1 do
        if pere.(!i) = !i then
            r := !i
        else 
            incr i
    done;
    (* r contient la racine *)
    let n = Array.length pere in 
    let fils = Array.make n [] in
    for i = 0 to n-1 do
        if pere.(i) = i then r := i
        else fils.(pere.(i)) <- i::fils.(pere.(i))
    done;
    (* fils.(i) contient la liste des fils de i *)
    let rec aux i = (* renvoie la liste des fils de i *)
        N(i, List.map aux fils.(i)) in
    aux !r
```

## Exercice 2 - Distances

1. (c.f. cours parcours)  
2. 
```ocaml
let diametre g = 
    let n = Array.length g in
    let maxi = ref 0 in
    for i = 0 to n - 1 do
        maxi := max (exc g i) !maxi
    done;
    !maxi
 ```

3. 
```ocaml
let centre g = 
    let n = Array.length g in
    let c = ref 0 in
    let c_exc = ref (exc g 0) in
    for i = 1 to n - 1 do
        let a = exc g i in
        if c_exc < a then
            c_exc := a
```

4. 
```ocaml
(* diam t renvoie diamètre, hauteur *)
let rec diam t = 
    match t with
        |N(r,[]) -> (0,0)
        |N(r, a::q) -> let da, ha = diam a in
                       let dq, hq = diam (N(r,q)) in
                       (max da (max dq (1 + hq + ha)), max (ha + 1) hq)
```

`diam t` effectue un appel récursif par sommet $\rightarrow O(n)$

5. 