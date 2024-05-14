##
import numpy
import pygame
import time
import json

sampleRate = 44100
freq = 500

pygame.mixer.init(44100,-16,2,512)

def sine(freq=600,vol=75,delay=1):
    arr = numpy.array([4096 * numpy.sin(2.0 * numpy.pi * freq * x / sampleRate) for x in range(0, sampleRate)]).astype(numpy.int16)
    arr2 = numpy.c_[arr,arr]
    sound = pygame.sndarray.make_sound(arr2)
    sound.set_volume(vol/100)
    print(time.time(),vol,freq)
    sound.play(-1)
    pygame.time.delay(delay*1000)
    sound.stop()

data = {}
#time.sleep(10)
for vol in numpy.linspace(50,100,25) :
    for freq in numpy.linspace(550,1000,70):
        arr = numpy.array([4096 * numpy.sin(2.0 * numpy.pi * freq * x / sampleRate) for x in range(0, sampleRate)]).astype(numpy.int16)
        arr2 = numpy.c_[arr,arr]
        sound = pygame.sndarray.make_sound(arr2)
        sound.set_volume(vol/100)
        data[time.time()]={"vol":vol,"freq":freq}
        print(time.time(),vol,freq)
        sound.play(-1)
        pygame.time.delay(1000)
        sound.stop()
with open("sounds.json",'w') as file:
    json.dump(data,file)
