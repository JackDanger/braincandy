from random import *
from math import sqrt

max = 10000
inside = 0
for n in xrange(max):
    x, y = random(), random()
    print sqrt(x*x + y*y)
    if sqrt(x*x + y*y) <= 1:
        inside += 1

print(inside * 4.0 / max)
