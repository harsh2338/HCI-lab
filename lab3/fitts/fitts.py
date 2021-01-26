import random
from pygame.locals import *
import pygame, sys, math
import pygame.gfxdraw
import time

pygame.init()
scr = pygame.display.set_mode((1500, 1000))
myfont1 = pygame.font.SysFont("Aerial", 15)
clock = pygame.time.Clock()
count = 1
startingTime = 0
def update_current_circle(current_circle):
    if pair_start == 1:
        if current_circle > math.ceil(num_of_circle / 2):
            return current_circle - math.ceil(num_of_circle / 2)
        else:
            return math.ceil(num_of_circle / 2) + current_circle
    else:
        while True:
            rand = random.randint(1, num_of_circle + 1)
            if rand != current_circle:
                break
        return rand
def game():
    global count
    global circle_radius
    global current_circle
    global distance
    global pair_start
    global initial
    global timing
    global startingTime
    while timing<=20:
        timing = time.time()-initial
        pygame.display.update()
        scr.fill((255, 255, 255))
        for i in range(1, num_of_circle + 1):
            pygame.gfxdraw.aacircle(scr, 750 + int(math.cos(math.pi * 2 / num_of_circle * i) * distance / 2),
                                    400 + int(math.sin(math.pi * 2 / num_of_circle * i) * distance / 2),
                                    circle_radius, (100, 100, 100))
    
        pygame.gfxdraw.filled_circle(scr, 750 + int(math.cos(math.pi * 2 / num_of_circle * current_circle) * distance / 2),
                                     400 + int(math.sin(math.pi * 2 / num_of_circle * current_circle) * distance / 2),
                                     circle_radius, (255, 0, 0))
        events = pygame.event.get()
        for event in events:
            if event.type == pygame.MOUSEBUTTONDOWN:
                click = scr.get_at(pygame.mouse.get_pos()) == (0, 255, 0)
                if click == 1:
                    current_circle = update_current_circle(current_circle)
                    if pair_start == 1:
                        startingTime = time.time()
                        pair_start = 0
                    else:
                        count += 1
                        pair_start = 1
            if event.type == QUIT:
                pygame.quit()
                sys.exit()
num_of_circle = 16
circle_radius = 22 
distance = 500 
current_circle = 1
pair_start = 1
initial = time.time()
timing =0 
game()
initial = time.time()
timing =0 
num_of_circle = 10
circle_radius = 22 
distance = 200
count=1
game()
initial = time.time()
timing =0 
num_of_circle = 6
circle_radius = 50
distance = 400
count=1
game()
initial = time.time()
timing =0 
num_of_circle = 9
circle_radius = 50
distance = 600
count=1
game()
