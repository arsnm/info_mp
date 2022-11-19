# DS1 - MP*

## I. Dictionnaire 

1. ```python
    d[69] = 2
2. ```python
    def somme(d:dict) -> float:
        counter = 0
        for dep in d:
            somme += d[dep]
        return counter
    ```
3. ```python
    def min_population(d:dict) -> float:
        min = (0,0)
        for keys in d:
            if min[0] > d[keys]:
                min = (d[keys], keys)
        return min[1]
    ```

## II. Coupe du monde 98

1. ```sql
    SELECT entraineur FROM equipe
    WHERE nom = "Brésil"
    ```
2. ```sql
    SELECT nom FROM joueur
    WHERE nom_equipe = "France"
    ```
3. ```sql
    SELECT id FROM match
    WHERE score_equipe1 = score_equipe2
    ```
4. ```sql
    SELECT age/COUNT(*) FROM joueur
    WHERE nom_equipe = "France"
    ```
5. ```sql
    SELECT minute FROM but
    WHERE minute = MIN(minute)
    ```
6. ```sql
    SELECT COUNT(*) FROM but JOIN joueur
    ON nom_joeur = joueur
    WHERE nom_equipe = "France"
    ```
7. ```sql
    SELECT nom_joueur FROM but JOIN match
    ON id_match = id WHERE stade = "Stade de France"
    ```
8. ```sql
    SELECT nom_joueur, COUNT(*) FROM but
    GROUP BY nom_joeur ORDER BY COUNT(*) DESC LIMIT 1;
    ```