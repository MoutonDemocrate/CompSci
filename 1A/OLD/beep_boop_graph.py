##
import json
import time
import datetime
import copy

with open("tensionButGood.json","r") as file:
    tensionListButGood = json.load(file)
for timeFound in tensionListButGood:
    print(datetime.strftime(datetime.fromtimestamp(timeFound/1000),'%Y-%m-%d'))
##
import json
import time
from datetime import datetime
import copy

with open("tension.json","r") as file:
    tensionList = json.load(file)
fake = copy.deepcopy(tensionList)
for t in fake :
    newTime = datetime.fromisoformat("2022-05-19 " + t).timestamp()
    tensionList[newTime] = tensionList.pop(t)

with open("tensionButGood.json","w") as file:
    json.dump(tensionList,file)
##
import matplotlib.pyplot as plt
import json
import time
import datetime

with open("sounds.json","r") as file:
    sounds = json.load(file)
with open("tension.json","r") as file:
    tensionList = json.load(file)
tensionTime = [time.mktime(datetime.datetime.strptime(t, "%H:%M:%S.%f").timetuple()) for t in tensionList]
tension = [tensionList[t] for t in tensionList]
soundsList = [t for t in sounds]
soundsList.sort()

soundInc = 0
for value in tensionTime:
    if tensionTime[value] < soundsList[0] :
        print(value)

##
import matplotlib.pyplot as plt
import json
import time
from datetime import datetime

with open("sounds.json","r") as file:
    sounds = json.load(file)
with open("tensionButGood.json","r") as file:
    tensionList = json.load(file)

xTime = 0
temp = []
compact = {}
for teaTime in tensionList :
    if not float(teaTime) <= float(list(sounds.items())[0][0]) :
        if xTime == len(sounds) - 1 :
            if  float(teaTime) > float(list(sounds.items())[xTime][0]) and float(teaTime) <= float(list(sounds.items())[xTime][0])+1.1 :
                temp.append(float(tensionList[teaTime]))
            else :
                av = sum(temp) / len(temp)
            compact[list(sounds.items())[xTime][0]] = sounds[list(sounds.items())[xTime][0]].update({"av" : av})
            del temp
            break
        if float(teaTime) > float(list(sounds.items())[xTime][0]) and float(teaTime) <= float(list(sounds.items())[xTime + 1][0]) :
            temp.append(float(tensionList[teaTime]))
        else:
            av = sum(temp) / len(temp)
            compact[list(sounds.items())[xTime][0]] = (sounds[list(sounds.items())[xTime][0]] | {"av" : av})
            xTime += 1
            temp = [float(tensionList[teaTime])]

with open("compact.json","w") as file:
    json.dump(compact,file)
print("finished")


##
