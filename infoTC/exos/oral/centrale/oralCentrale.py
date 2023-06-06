import numpy as np


# Exercice 1


def diag(n):
    return np.diag(np.random.rand(n))


def matrice(A, B):
    return np.dot(A, B) - np.dot(B, A)


if __name__ == "__main__":
    n = 5
    A = diag(n)
    B = np.random.rand(n, n)
    print(matrice(A, B))

# Exercice 2

univers = [-1, 1]

def temps(a, b):
    n = -1
    S_n = 0
    while -a <= S_n <= b:
        S_n += univers[np.random.randint(0, 2)]
        n += 1
    return n

def moyenne(a, b):
    return np.average(np.array([temps(5, 7) for _ in range(10000)]))

if __name__ == "__main__":
    print(temps(5, 7))
    print(moyenne(5, 7))
