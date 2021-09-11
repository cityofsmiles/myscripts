#!/usr/bin/env python
# File name: randomize-student-names.py
# Description: Randomly select a student name given the class list.
# Author: Jonathan R. Bacolod
# Date: Sep. 12, 2021

import sys
import argparse
import logging
from logging import critical, error, info, warning, debug
from random import choice, shuffle
from os import get_terminal_size   

def parse_arguments():
    """Read arguments from a command line."""
    parser = argparse.ArgumentParser(description='Arguments get parsed via --commands')
    parser.add_argument('-l', '--list', metavar='list', type=str, default="student-names.txt",
        help='The class list')
    parser.add_argument('-v', metavar='verbosity', type=int, default=2,
        help='Verbosity of logging: 0 -critical, 1 -error, 2 -warning, 3 -info, 4 -debug')
 
	
    args = parser.parse_args()
    verbose = {0: logging.CRITICAL, 1: logging.ERROR, 2: logging.WARNING, 3: logging.INFO, 4: logging.DEBUG}
    logging.basicConfig(format='%(message)s', level=verbose[args.v], stream=sys.stdout)
    
    return args


def create_list(filename):
    with open(filename) as file_in:
        class_list = []
        for line in file_in:
            class_list.append(line)
    return class_list


def main(list):
    shuffle(list)
    chosen = choice(list)
    list.pop(list.index(chosen))
    new_list = list
    print("\n\n\n", chosen.center(get_terminal_size().columns), "\n\n\n\n")
    choose_again(new_list)


def choose_again(new_list):
    again = input("") or "y"

    if again.lower() == 'y':
        main(new_list)           
    elif again.lower() == 'q':
        quit()
    else:
        main(new_list)


if __name__ == '__main__':
    args = parse_arguments()
    class_list = create_list(args.list)
    chosen = main(class_list)
#    print(chosen)