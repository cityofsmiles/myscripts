#!/usr/bin/env python
# File name: recitation-manager.py
# Description: Randomly select a student name given the class list.
# Author: Jonathan R. Bacolod
# Date: Sep. 12, 2021

import sys
import argparse
import logging
from logging import critical, error, info, warning, debug
from random import choice, shuffle
import os 
import subprocess
import datetime


def parse_arguments():
    """Read arguments from a command line."""
    parser = argparse.ArgumentParser(description='Arguments get parsed via --commands')
    parser.add_argument('-d', '--dir', metavar='dir', type=str, default="Recitations",
        help='The folder path to save the results.')
    parser.add_argument('-s', '--section', metavar='section', type=str, default="Section",
        help='The class section')
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


def choose_name(list, file_path, section_dir):
    shuffle(list)
    chosen = choice(list)
    list.pop(list.index(chosen))
    new_list = list.copy()
    print_str(chosen)
    choose_again(chosen, new_list, file_path, section_dir)


def print_str(string):
    subprocess.Popen(['figlet', '-c', '-t', string])


def show_compliment():
    compliments = ["Great job!", "Incredible!", "Amazing!", "Excellent!", "Good job!", "Very good!"]
    shuffle(compliments)
    chosen_compliment = choice(compliments)
    print_str(chosen_compliment)


def create_file_path(section, main_dir):
    section_dir = os.path.join(main_dir, section)
    if os.path.isdir(section_dir) == False:
        os.mkdir(section_dir) 
    now = datetime.datetime.now()
    date_time_now = now.strftime('-%Y-%m-%d_%H-%M-%S')
    section_file = section + date_time_now + ".txt"
    file_path = os.path.join(section_dir, section_file)
    return file_path, section_dir


def record_recited(student_name, file_path):    
    with open(file_path, 'a') as fp:
        fp.write(student_name)


def choose_again(chosen, new_list, file_path, section_dir):
    again = input("") or "n"
    if again.lower() == 'c':
        show_compliment()
        record_recited(chosen, file_path)  
        choose_again(chosen, new_list, file_path, section_dir)         
    elif again.lower() == 'n':
        choose_name(new_list, file_path, section_dir)
    elif again.lower() == 'o':
        subprocess.Popen(['leafpad', file_path])
        choose_again(chosen, new_list, file_path, section_dir)
    elif again.lower() == 's':
        subprocess.Popen(['sh', 'summarize-recitation.sh', section_dir])
        results_file = os.path.join(section_dir, "results", "recitation_results.txt")
        subprocess.Popen(['leafpad', results_file])
        choose_again(chosen, new_list, file_path, section_dir)
    elif again.lower() == 'q':
        quit()
    else:
        choose_name(new_list, file_path)


def main():
    args = parse_arguments()
    class_list = create_list(args.list)
    file_path, section_dir = create_file_path(args.section, args.dir)
    choose_name(class_list, file_path, section_dir)


if __name__ == '__main__':
    main()