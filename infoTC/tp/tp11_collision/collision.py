from dataclasses import dataclass
from random import random
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from matplotlib.patches import Circle
import numpy as np


@dataclass
class Particule:
    x: float
    y: float
    vx: float
    vy: float
    m: float
    r: float

    
p = Particule(x=0, y=0, vx=1, vy=1, m=1, r=1) # définir une particule
print(p.x) # accéder à la position suivant x
print(p.vx) # accéder à la vitesse suivant x
p.vx = 2 # modifier la vitesse suivant x

def aléatoire(a, b):
    return a + (b - a)*random()

def particules_aléatoires(n):
    return [Particule(x=aléatoire(0, 10), y=aléatoire(0, 10), vx=aléatoire(-1, 1), vy=aléatoire(-1, 1), m=aléatoire(1, 10), r=.5) for _ in range(n)]

def avance(p, dt):
    p.x += p.vx * dt
    p.y += p.vy * dt

def bord(p, h):
    if p.x - p.r < 0:
        p.vx *= - 1
    if p.x + p.r > h:
        p.vx *= - 1
    if p.y - p.r < 0:
        p.vy *= - 1
    if p.y + p.r > h:
        p.vy *= - 1

def etape(particules, h, dt):
    for part in particules:
        bord(part, h)
        avance(part, dt)

def collision(p1, p2):
    return (p2.x - p1.x)**2 + (p2.y - p1.y)**2 <= (p1.r + p2.r)**2

def vitesse_collision(p1, p2):
    v1_ = ((p1.m - p2.m) / (p1.m + p2.m)) * p1.vx + ((2*p2.m) / (p1.m + p2.m)) * p2.vx
    v2_ = ((p2.m - p1.m) / (p1.m + p2.m)) * p2.vx + ((2*p1.m) / (p1.m + p2.m)) * p1.vx
    p1.vx = v1_
    p2.vx = v2_

def etape(particules, h, dt):
    for i in range(len(particules)):
        for j in range(i + 1, len(particules)):
            part1, part2 = particules[i], particules[j]
            if collision(part1, part2):
                vitesse_collision(part1, part2)
    for part in particules:
        bord(part, h)
        avance(part, dt)

def vitesse_collision(p1, p2):
    c1, c2 = np.array([p1.vx, p1.vy]), np.array([p2.vx, p2.vy])
    v1, v2 = np.array([p1.vx, p1.vy]), np.array([p2.vx, p2.vy])
    p1.vx, p1.vy = v1 - 2 * p2.m / (p1.m + p2.m) * np.dot(v1 - v2, c1 - c2) / np.dot(c1 - c2, c1 - c2) * (c1 - c2)
    p2.vx, p2.vy = v2 - 2 * p1.m / (p1.m + p2.m) * np.dot(v2 - v1, c2 - c1) / np.dot(c2 - c1, c2 - c1) * (c2 - c1)

def avance(p, dt):
    p.vy -= .4 * dt
    p.x += p.vx * dt
    p.y += p.vy * dt 

def animation(particules, n=200):
    h = 10
    fig = plt.figure()
    ax = plt.axes(xlim=(0, h), ylim=(0, h))
    ax.set_aspect('equal', 'box')
    cercles = [Circle(xy=(p.x, p.y), radius=p.r) for p in particules]
    for c in cercles:
        ax.add_patch(c)
    def init():
        return cercles
    def animate(i):
        for _ in range(30):
            etape(particules, h, .01)
        for c, p in zip(cercles, particules):
            c.center = (p.x, p.y)
        return cercles
    anim = FuncAnimation(fig, animate, init_func=init, frames=n, interval=20, blit=True)
    plt.show()

if __name__ == "__main__":
    # animation(particules_aléatoires(50))
    # animation([Particule(x=3, y=5, vx=2, vy=0, m=1, r=.5), Particule(x=6, y=5, vx=0, vy=0, m=10, r=.5)])
    # animation(particules_aléatoires(5))
    animation(particules_aléatoires(3))