import json
import os
import re
from unidecode import unidecode

## Create JSON tree of folders

def get_files(
	path : str, 
	r : bool = False, 
	ignore_case : bool = False
	) -> dict:

	if os.path.exists(path) :
		objs = os.listdir(path)
		dict = {}
		for obj in objs :
			if os.path.isfile(os.path.join(path, obj)) :
				name, ext = os.path.splitext(obj)
				if name[0] != "." or ignore_case:
					dict[name] = ext
			elif os.path.isdir(os.path.join(path, obj)) :
				if obj[0] != "." or ignore_case:
					dict[obj] = get_files(os.path.join(path, obj), r = True) if r else {}
		return dict
	else :
		raise Exception("This path is not a valid path !")

print(json.dumps(get_files(".", True), indent = 4))