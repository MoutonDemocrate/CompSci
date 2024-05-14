##
from mpl_toolkits import mplot3d
import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import interp2d
import json

with open("compact.json",'r') as file :
    data = json.load(file)
fig = plt.subplots

x = [((p['vol']-50)*2)*(15/100) + 60 for p in list(data.values())]
y = [p['freq'] for p in list(data.values())]
z = [p['av'] for p in list(data.values())]

f = interp2d(x,y,z)

x_coords = np.arange(min(x),max(x)+1)
y_coords = np.arange(min(y),max(y)+1)
Z = f(x_coords,y_coords)
fig = plt.imshow(Z, extent=[60,75,550,1000],origin="lower",aspect="auto")
fig.axes.set_autoscale_on(False)
plt.colorbar(fig)
#plt.contourf(xLine,yLine,zLine)
plt.show()
##
