import math
from turtle import *

def heart1(a):
    return 15 * math.sin(a) ** 3

def heart2(a):
    return (12 * math.cos(a)
            - 5 * math.cos(2 * a)
            - 2 * math.cos(3 * a)
            - math.cos(4 * a))

speed(0)
bgcolor("black")
color("#f73487")

for i in range(10000):
    goto(heart1(i) * 20, heart2(i) * 20)
    goto(0, 0)

    if i % 20 == 0:
        update()
        delay(1)

done()