#!/usr/bin/python3

import os

def simplecount(filename):
    lines = 0
    for line in open(filename):
        lines += 1
    return lines

os.chdir('/home/jonathan/Documents/myscripts/sample/')
file = "sample-answer.txt"

f=open(file)
f_lines = f.readlines()
num_lines = simplecount(file)
j = 0
for i in range(0, num_lines):
    item = f_lines[i]
    item = item.split()
    #print(item)
    if item == []:
        j = i
        break
print(j)
#print(f_lines)
