##
import numpy as np
import random as rd

def generate_vector():
    a = rd.random() - 0.5
    b = rd.random() - 0.5
    c = rd.random() - 0.5
    return (a,b,c)

def average(n):
    averageX = 0
    averageY = 0
    averageZ = 0
    for i in range(n):
        u = generate_vector()
        averageX += u[0]
        averageY += u[1]
        averageZ += u[2]
    averageX /= n
    averageY /= n
    averageZ /= n
    return (averageX,averageY,averageZ), np.sqrt(averageX**2+averageY**2+averageZ**2)

