##
global D
global F
global V

D = [4,18,12,9,13,17,21,2]
F = [6,21,19,15,25,19,24,5]
V = [3,5,2,4,8,1,2,7]

def addZero(L):
    L.append(0)

addZero(F)
addZero(D)
addZero(V)

def tri():
    while True : 
        sorted = True
        for ind in range(1,len(F)) : 
            if F[ind-1] > F[ind] :
                F[ind-1],F[ind] = F[ind],F[ind-1]
                D[ind-1],D[ind] = D[ind],D[ind-1]
                V[ind-1],V[ind] = V[ind],V[ind-1]
                sorted = False
        if sorted == True :
            return

def computeP():
    n = len(F)
    P = [0]*n
    for j in range(n):
        highD = 0
        for i in range(0,j) :
            if F[i] <= D[j] :
                if i > highD :
                    highD = i
        P[j] = highD
    return P

def computeOPT():
    OPT=[0]
    n = len(F)

    for j in range(1,n):
        OPT.append(max(V[j] + OPT[P[j]], OPT[j-1]))
    return OPT

def reconstruct(j):
    if j == 0:
        return [0]
    elif V[j] + OPT[P[j]] >= OPT[j-1] :
        return reconstruct[OPT[j]]
    else :
        return [j,reconstruct(OPT[j])]

##
tri()
print(D)
print(F)
print(V)

P =  computeP()
print(P)

OPT = computeOPT()
print(OPT)

print(reconstruct(8))