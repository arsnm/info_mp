from copy import deepcopy

def afficher_bis(grid):
    symbols = [' ', 'X', 'O']
    string = ""
    for i in range(len(grid)):
        for j in range(len(grid[i])):
            if j == len(grid[i]) - 1:
                string += symbols[grid[i][j]] + '\n'
            else :
                string += symbols[grid[i][j]] + '|'
    return string

class L(list):
    def to_tuple(self):
        def aux(l):
            if isinstance(l, list):
                return tuple(map(aux, l))
            return l
        return aux(self)
    def __hash__(self):
        return hash(self.to_tuple())
    def __repr__(self) -> str:
        return afficher_bis(self)

def afficher(grid:L):
    symbols = [' ', 'X', 'O']
    for i in range(len(grid)):
        for j in range(len(grid[i])):
            if j == len(grid[i]) - 1:
                print(symbols[grid[i][j]])
            else :
                print(f'{symbols[grid[i][j]]}|', end= '')

def cases_libres(grid):
    return [(i, j) for i in range(len(grid)) for j in range(len(grid[i])) if grid[i][j] == 0]

def joueur(grid):
    return 2 if len(cases_libres(grid)) % 2 == 0 else 1

def gagnant(grid):
    # gagnant sur les lignes ou les colonnes
    for i in range(3):
        if grid[i][0] == grid[i][1] == grid[i][2] != 0:
            return grid[i][0]
        elif grid[0][i] == grid[1][i] == grid[2][i] != 0:
            return grid[0][i]
    # gagnant sur les diagonnales
    if (grid[0][0] == grid[1][1] == grid[2][2] != 0) or (grid[0][2] == grid[1][1] == grid[2][0] != 0):
        return grid[1][1]
    return 0

def successeurs(grid):
    j = joueur(grid)
    L = []
    for x,y in cases_libres(grid):
        new_grid = deepcopy(grid)
        new_grid[x][y] = j
        L.append(new_grid)
    return L

def attracteurs(g):
    d = {} # d[v] = True si la grille v est attracteur pour le joueur 1
    def aux(v):
        if v not in d:
            if gagnant(v) == 1:
                d[v] = True
            elif gagnant(v) == 2:
                d[v] = False
            else:
                j = joueur(v)
                attr = [aux(succ) for succ in successeurs(v)]
                if j == 1:
                    d[v] = any(attr)
                elif j == 2:
                    d[v] = all(attr)
        return d[v]
    aux(g)
    return [v for v in d if d[v]] # grilles v telles que d[v] == True

def strategie(g):
    d = {}
    def aux(v):
        if v not in d:
            attr = attracteurs(v)
            if gagnant(v) == 1:
                d[v] = True
            elif len(attr) == 0:
                d[v] = False
            else:
                for coup in successeurs(v):
                    if coup in attr and len(cases_libres(coup)) == len(cases_libres(v)) - 1:
                        d[v] = coup
                d[v] = d.get(v, False)
        for w in successeurs(v):
            aux(w)
    aux(g)
    return d

def jeu(g):
    d = strategie(g)
    while gagnant(g) == 0 and len(cases_libres(g)) != 0:
        if joueur(g) == 2:
            afficher(g)
            t = len(cases_libres(g))
            while len(cases_libres(g)) == t:
                i, j = map(int, input(f"Entrez les coordonnées de votre coup : ").split())
                if g[i][j] == 0:
                    g[i][j] = 2
                else:
                    print("Coup impossible, sélectionnez une case disponible")
        else:
            if d[g] == False:
                print("Pas de stratégie gagnante")
                return
            g = d[g]
    if gagnant(g) == 0 and len(cases_libres(g)) == 0:
        print("Egalité !")
    else:
        print("Le joueur", gagnant(g), "a gagné !")
    afficher(g)

if __name__ == "__main__":
    g_vide = L([[0, 0, 0], [0, 0, 0], [0, 0, 0]]) # grille initialement vide

    g1 = L([
    [1, 2, 0],
    [0, 0, 0],
    [0, 0, 0]
    ])

    jeu(g_vide)
    
    # g_test = L([[2, 1, 1], [1, 2, 2], [2, 1, 1]])
    # print(gagnant(g_test))
    # print(attracteurs(L([[0, 0, 1], [1, 2, 2], [2, 1, 1]])))