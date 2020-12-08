#!/usr/bin/env python

# python3 '/home/jonathan/Documents/myscripts/Python-Scripts/check-answers.py' 

import PySimpleGUI as sg      
import os
import subprocess

status=0

def get_input(temp_file, output_dir): 
    layout = [[sg.Text('Enter student\'s infos and answers.')],      
                 [sg.Multiline(size=(70,20), key='answers', autoscroll=True)],      
                 [sg.Submit(), sg.Cancel()]]      

    window = sg.Window('Test Auto-Checker', layout, size=(400,400))    

    while True:
        event, values = window.read()  
        if event in (None, 'Cancel'):
            break
        if event == "Submit":
            os.chdir(output_dir)
            student_input = values['answers']
            f= open(temp_file,"w+")
            f.write(student_input)
            f.close()
            window.close()


def parse_infos(temp_file, output_dir):
    os.chdir(output_dir)
    f=open(temp_file, "r")
    student_name = str(f.readlines(1))
    student_lastname, student_firstname = student_name.split(',')
    student_lastname = student_lastname[2:]
    student_firstname = student_firstname[1:-4]
    section = str(f.readlines(2))
    section = section[2:-4]
    student_code = str(f.readlines(3))
    student_code = student_code[2:-10]
    return student_code, student_lastname, student_firstname, section

def create_output_file(temp_file, output_dir):
    student_code, student_lastname, student_firstname, section = parse_infos(temp_file, output_dir)
    output_file = student_code + "-" + student_lastname + ".txt"
    os.chdir(output_dir)
    f= open(output_file,"w+")
    f.write(student_lastname + ", " + student_firstname + "\n")
    f.write(section + "\n")
    f.write(student_code + "\n\n")
    f.close()
    return output_file, student_code, student_lastname
    
def simplecount(filename):
    lines = 0
    for line in open(filename):
        lines += 1
    return lines

def check_items(temp_file, answer_key, output_dir):  
    os.chdir(output_dir)
    output_file, student_code, student_lastname = create_output_file(temp_file, output_dir)
    num_lines = simplecount(temp_file)
    file_temp = open(temp_file)
    answer_file = open(answer_key)
    all_lines = file_temp.readlines()
    answer_lines = answer_file.readlines()
    score = 0
    mistake = 0
    f=open(output_file, "a+")
    for i in range(5, num_lines+1):
        j = i - 4
        item = all_lines[i - 1]
        item_num, item_answer = item.split('.')
        item_answer = item_answer[1:2]
        item_answer = item_answer.lower()
        answer = answer_lines[j - 1]
        answer_num, correct_answer = answer.split('.')
        correct_answer = correct_answer[1:2]
        correct_answer = correct_answer.lower()
        
        if item_answer == correct_answer:
            comment = u'\u2713'
            score += 1
        else:
            comment = u'\u2718'
            mistake += 1
        
        f.write(item_num + ". " + item_answer + "(" + correct_answer + ")" + comment + "\n")
    total_items = score + mistake
    f.write("\n\nScore = " + str(score) + "\n")
    f.write("Mistake = " + str(mistake) + "\n")
    f.write("Total = " + str(total_items))
    return score, output_file, student_code, student_lastname

def clean_up(temp_file, output_dir, answer_key):
    os.chdir(output_dir)
    score, output_file, student_code, student_lastname = check_items(temp_file, answer_key, output_dir)
    new_output_file = student_code + "-" + student_lastname + "-" + str(score) + ".txt"
    os.rename(output_file, new_output_file) 
    os.remove(temp_file)
    subprocess.Popen(['mousepad', new_output_file],shell=False)



if __name__ == '__main__':
    get_input("temp.txt", "/home/jonathan/Old-Docs/excel/shs/20-21/Class-Records/8-Hubble/Quiz-and-Test-Scores/1st-Grading/Quiz#1")
    clean_up("temp.txt", "/home/jonathan/Old-Docs/excel/shs/20-21/Class-Records/8-Hubble/Quiz-and-Test-Scores/1st-Grading/Quiz#1", "/home/jonathan/Old-Docs/excel/shs/20-21/Tests-and-Quizzes/1st-Grading/Quiz#1-Answer-Key.txt")
