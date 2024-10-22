##
import matplotlib.pyplot as plt

im1 = [[4,7,1],[3,4,-2],[5,3,0]]

def sym(image):
    n = len(image)
    p = len(image[0])
    imageSym = [[0]*p for _ in range(n)]
    for i in range(n):
        for j in range(p):
            imageSym[i][j] = image[i][abs(j-len(image[i])+1)]
    return imageSym

plt.imshow(sym(im1))
plt.show
##
