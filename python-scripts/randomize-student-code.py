#!/usr/bin/env python
# File name: format.py
# Description: Basic format for Python scripts
# Author: Louis de Bruijn
# Date: 19-05-2020

import sys
import argparse
import logging
from logging import critical, error, info, warning, debug
from random import choice, shuffle


def parse_arguments():
    """Read arguments from a command line."""
    parser = argparse.ArgumentParser(description='Arguments get parsed via --commands')
    parser.add_argument('-b', '--boys', metavar='boys', type=int, default=1,
        help='Number of boys in class')
    parser.add_argument('-g', '--girls', metavar='girls', type=int, default=1,
        help='Number of girls in class')
    parser.add_argument('-v', metavar='verbosity', type=int, default=2,
        help='Verbosity of logging: 0 -critical, 1 -error, 2 -warning, 3 -info, 4 -debug')
 
	
    args = parser.parse_args()
    verbose = {0: logging.CRITICAL, 1: logging.ERROR, 2: logging.WARNING, 3: logging.INFO, 4: logging.DEBUG}
    logging.basicConfig(format='%(message)s', level=verbose[args.v], stream=sys.stdout)
    
    return args

def create_list(gender, r1, r2):
  
    # Testing if range r1 and r2 
    # are equal
    if (r1 == r2):
        return r1
  
    else:
  
        # Create empty list
        res = []
  
        # loop to append successors to 
        # list until r2 is reached.
        while(r1 < r2+1 ):
              
            res.append(gender + str(r1))
            r1 += 1
        return res

def create_student_codes(num_boys, num_girls):
    boys_list = create_list("B", 1, num_boys) 
    girls_list = create_list("G", 1, num_girls)    
    student_codes = boys_list + girls_list    
    
    return student_codes


def main(list):
    shuffle(list)
    chosen = choice(list)
    list.pop(list.index(chosen))
    new_list = list
    print(chosen)
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
    student_codes = create_student_codes(args.boys, args.girls)
    main(student_codes)
    