---
title: Centrale 2020 - Option Informatique MP
subtitle: Arsène MALLET - MP*
toc: false
toc-title: Sommaire
toc-depth: 2
papersize: a4
header-includes:
  - \usepackage{stmaryrd}
  - \usepackage{fancyhdr}
  - \usepackage{lastpage} 
  - \pagestyle{fancy}
  - \fancyhf{}
  - \renewcommand{\headrulewidth}{0pt}
  - \fancyfoot[R]{\thepage/\pageref{LastPage}} 
geometry: margin=30mm
---

## Question 1

```ocaml
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
```

## Question 2

$$
M =
\begin{pmatrix}
0 & 2 & 2\\
-2 & 0 & 0 \\
-2 & 0 & 0
\end{pmatrix}
$$

## Question 3

Une matrice $A \in \mathcal{M}_n (\mathbb{K})$ est antisymétrique si
$\forall (i,j) \ \in \llbracket 1,n \rrbracket^2 , a_{i,j} = - a_{j,i}$ où les ($a_{i,j}$) sont les coefficients de la matrice $A$.
Ici la matrice est antisymétrique puisque les résultats entre les candidats sont les mêmes au signe près du gagnant : soit $C_1,C_2 \in \llbracket 0,n \llbracket$ deux candidats. On suppose que $C_1$ remporte $q$ duel(s) ($0 \leq q \leq p$) contre $C_2$ . $C_2$ en  gagne donc $(p-q)$ face à $C_1$. Ainsi, en notant $a_{i,j}$ le score du score du candidats $i$ face au candidats $j$. Ainsi $a_{C_1,C_2} = q - (p - q) = 2q - p$ et $a_{C_2,C_1} = (p-q) - q = p - 2q = - a_{C_1,C_2}$ d'où l'antisymétrie de la matrice d'adjacence. On remarque également que $2q$ est pair, et donc la parité de tous les $a_{i,j}$ dépend enfaite uniquement de la parité de $p$ le nombre de bulletins$. Ainsi, tous les 

## Question 4

```ocaml
let depouillement n urne = 
  let res = Array.make_matrix n n 0 in
  for cand1 = 0 to n-1 do
    for cand2 = 0 to n-1 do 
      if cand1 <> cand2 then
        res.(cand1).(cand2) <- duel cand1 cand2 urne
      done;
    done;
  res ;;
  ```