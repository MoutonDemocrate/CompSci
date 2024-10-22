##
import random as rand
from random import randint

def bubblesorting(T):
    L = T[0:]
    while True :
        isSorted = True
        for i in range(len(L)-1):
            if L[i + 1] < L[i]:
                L[i + 1] , L[i] = L[i] , L[i + 1]
                isSorted = False
        if isSorted == True:
            return L
##
