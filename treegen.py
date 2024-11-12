import json
import os
import re
from unidecode import unidecode

## Create JSON tree of folders
#### YEAR
wd : str = "."
tree : dict = {}
for dirr in (os.listdir(wd)) :
	if not os.path.isfile(os.path.join(wd, dirr)) :
		if re.search("(.+)A", dirr) :
			tree[dirr] = {}

for key in tree.keys() :
	twd = os.path.join(wd, key)
	for dirr in (os.listdir(twd)) :
		if not os.path.isfile(os.path.join(twd, dirr)) :
			dirr = unidecode(dirr)
			tree[key][dirr] = {}

print(json.dumps(tree, indent = 4))