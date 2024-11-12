import json
import os
import re
from unidecode import unidecode

## Create JSON tree of folders
#### YEAR
wd : str
tree : dict = {}
for year in (os.listdir('.')) :
	wd = "."
	if not os.path.isfile(os.path.join(wd, year)) :
		if re.search("(.+)A", year) :
			tree[year] = {}
			for course in (os.listdir(os.path.join(wd, year))) :
					if not os.path.isfile(os.path.join(wd, year, course)) :
						course_p = unidecode(course)
						if not course_p[0] in [' ','.'] :
							tree[year][course_p] = {}
							print(wd)
							for section in (os.listdir(os.path.join(wd, year, course))) :
								tree[year][course_p][section] = {}

print(json.dumps(tree, indent = 4))