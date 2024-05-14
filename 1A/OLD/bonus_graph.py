from numpy import sqrt
import matplotlib.pyplot as plt
import random as rd

""" ##
coords = []
for i in range(20) :
    coords.append([(rd.random()*10 - 5),(rd.random()*10 - 5)])

def distOne(i,j) :
    return sqrt((coords[j][0] - coords[i][0])**2 + (coords[j][1] - coords[i][1])**2)

for M in coords :
    plt.plot(M[0],M[1],marker="o",markerfacecolor="red")
    plt.pause(0.05)

for i in range(len(coords)) :
    for j in range(len(coords)) :
        x1 = [coords[i][0],coords[j][0]]
        y1 = [coords[i][1],coords[j][1]]
        plt.plot(x1,y1,"b-")
        plt.plot(coords[i][0],coords[i][1],marker="o",markerfacecolor="red")
        plt.plot(coords[j][0],coords[j][1],marker="o",markerfacecolor="red")
        plt.pause(0.01)
        plt.plot(x1,y1,"w-", linewidth=3)
        plt.plot(coords[i][0],coords[i][1],marker="o",markerfacecolor="red")
        plt.plot(coords[j][0],coords[j][1],marker="o",markerfacecolor="red")

plt.show() """

##
def listOfTirages(n):
    urne = [2,1]
    L = [0]
    S = 0
    for i in range(1,n+1):
        bouleTirée = rd.randint(1,urne[0]+urne[1]+1)
        bouleRouge = True if bouleTirée >= urne[0] else False
        if bouleRouge :
            S += 1
        L.append(S)
    return L

L = listOfTirages(20)
plt.plot(0,L[0],marker="o",markerfacecolor='red')
for i in range(1,len(L)) :
    plt.pause(0.05)
    plt.plot([i, i-1], [L[i], L[i-1]], "r-")
    plt.plot(i,L[i],marker="o",markerfacecolor='red')

L = listOfTirages(20)
plt.plot(0,L[0],marker="o",markerfacecolor='blue')
for i in range(1,len(L)) :
    plt.pause(0.05)
    plt.plot([i, i-1], [L[i], L[i-1]], "b-")
    plt.plot(i,L[i],marker="o",markerfacecolor='blue')

L = listOfTirages(20)
plt.plot(0,L[0],marker="o",markerfacecolor='green')
for i in range(1,len(L)) :
    plt.pause(0.05)
    plt.plot([i, i-1], [L[i], L[i-1]], "g-")
    plt.plot(i,L[i],marker="o",markerfacecolor='green')

L = listOfTirages(20)
plt.plot(0,L[0],marker="o",markerfacecolor='cyan')
for i in range(1,len(L)) :
    plt.pause(0.05)
    plt.plot([i, i-1], [L[i], L[i-1]], "c-")
    plt.plot(i,L[i],marker="o",markerfacecolor='cyan')

plt.show()