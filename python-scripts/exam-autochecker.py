#!/usr/bin/env python

# python3 '/home/jonathan/Documents/myscripts/Python-Scripts/check-answers-2cols.py' 

import PySimpleGUI as sg      
import os
from csv import writer
#from pathlib import Path
import io


def get_input():     
    left_col = [[sg.Text('Outputs Folder:', size=(13, 1)), sg.InputText(key='OUTDIR')],
                [sg.Text('Answer Key:', size=(13, 1)), sg.InputText(key='ANSKEY')],
                [sg.Text('Enter the student\'s infos and answers.')],      
                 [sg.Multiline(size=(60,20), key='ANSWERS', autoscroll=True)],      
                 [sg.Submit(), sg.Cancel()]]   
    
    right_col = [[sg.Text('Results:')],      
                 [sg.Multiline(size=(40,25), key='-OUTPUT-', autoscroll=True)]]

    layout = [[sg.Column(left_col, element_justification='c'), sg.VSeperator(),sg.Column(right_col, element_justification='c')]]
    
    window = sg.Window('Exam Auto-Checker', layout, resizable=True)    

    while True:
        event, values = window.read()  
        if event in (None, 'Cancel'):
            break
        if event == "Submit":
            output_dir = values['OUTDIR']
            ans_key = values['ANSKEY']
            student_input = values['ANSWERS']
            checked_items = check_answers(output_dir, ans_key, student_input)
            window['-OUTPUT-'].update(checked_items)
            window['ANSWERS'].update('')
           
           
def save_student_input(output_dir, student_input):    
    if os.path.isdir(output_dir) == False:
        os.makedirs(output_dir) 
    os.chdir(output_dir)
    temp_file = "temp.txt"
    f= open(temp_file,"w+")
    f.write(student_input)
    f.close()
    return temp_file


def parse_infos(temp_file, output_dir):
    os.chdir(output_dir)
    f=open(temp_file, "r")
    student_name = str(f.readlines(1))
    student_lastname, student_firstname = student_name.split(',')
    student_lastname = student_lastname[2:]
    student_firstname = student_firstname[1:-4]
    section = str(f.readlines(2))
    section = section[2:-4]
    section = section.replace(" ", "")
    student_code = str(f.readlines(3))
    student_code = student_code[2:-4]
    student_code = student_code.replace(" ", "")
    assessment_type = str(f.readlines(4))
    assessment_type = assessment_type[2:-4]
    assessment_type = assessment_type.replace(" ", "")
    return student_code, student_lastname, student_firstname, section, assessment_type


def create_output_file(output_dir, student_code, student_lastname, student_firstname, section, assessment_type):
    output_file = student_code + "-" + student_lastname + ".txt"
    section_output_dir = os.path.join(output_dir, section, assessment_type)
    if os.path.isdir(section_output_dir) == False:
        os.makedirs(section_output_dir)
    os.chdir(section_output_dir)
    f= open(output_file,"w+")
    f.write(student_lastname + ", " + student_firstname + "\n")
    f.write(section + "\n")
    f.write(student_code + "\n")
    f.write(assessment_type + "\n\n")
    f.close()
    return section_output_dir, output_file


def simplecount(filename):
    lines = 0
    for line in open(filename):
        lines += 1
    return lines


def check_items(temp_file, ans_key, output_dir, assessment_type, section_output_dir, output_file):  
    os.chdir(output_dir)
    num_lines = simplecount(temp_file)
    file_temp = open(temp_file)
    try:
        answer_file = open(ans_key)
    except FileNotFoundError:
        print("Answer key does not exist!")
    all_lines = file_temp.readlines()
    answer_lines = answer_file.readlines()
    score = 0
    mistake = 0
    os.chdir(section_output_dir)
    f = io.open(output_file, "a+", encoding='utf8')
    for i in range(6, num_lines+1):
        j = i - 5
        item = all_lines[i - 1]
        item = item.replace(" ", "")
        if "." in item:
            item_num, item_answer = item.split('.')
        if ")" in item:
            item_num, item_answer = item.split(')')
        item_answer = item_answer[0:1]
        item_answer = item_answer.lower()
        answer = answer_lines[j - 1]
        answer = answer.replace(" ", "")
        if "." in answer:
            answer_num, correct_answer = answer.split('.')
        if ")" in answer:
            answer_num, correct_answer = answer.split(')')
        correct_answer = correct_answer[0:1]
        correct_answer = correct_answer.lower()
        
        if item_answer == correct_answer:
            comment = u'\u2713' 
            score += 1
        else:
            comment = u'\u2718' 
            mistake += 1
        
        f.write(item_num + ". " + item_answer + " (" + correct_answer + ") " + comment + "\n")
    total_items = score + mistake
    f.write("\n\nScore = " + str(score) + "\n")
    f.write("Mistake = " + str(mistake) + "\n")
    f.write("Total = " + str(total_items))
    return score, total_items


def clean_up(temp_file, output_dir, student_code, student_lastname, section_output_dir, output_file, assessment_type, score):
    os.chdir(section_output_dir)
    new_output_file = student_code + "-" + student_lastname + "-" + str(score) + ".txt"
    os.rename(output_file, new_output_file) 
    os.chdir(output_dir)
    os.remove(temp_file)
    return new_output_file


def append_list_as_row(file_name, list_of_elem):
    # Open file in append mode
    with open(file_name, 'a+', newline='') as write_obj:
        # Create a writer object from csv module
        csv_writer = writer(write_obj)
        # Add contents of list as last row in the csv file
        csv_writer.writerow(list_of_elem)


def record_score(section_output_dir, assessment_type, student_code, score, total_items):
    record_csv = assessment_type + '-Scores.csv'
    os.chdir(section_output_dir)
    try:
        f = open(record_csv)
    except IOError:
        f= open(record_csv,"w")
        f.write("Code," + str(total_items) + "\n")
        f.close()
    finally:
        f.close()
    row_contents = [student_code, score]
    append_list_as_row(record_csv, row_contents)
    

def read_output(section_output_dir, new_output_file):
    os.chdir(section_output_dir)
    #checked_items = Path(new_output_file).read_text(encoding='utf8')
    with io.open(new_output_file,'r',encoding='utf8') as f:
        checked_items = f.read()
    return checked_items


def check_answers(output_dir, ans_key, student_input):
    temp_file = save_student_input(output_dir, student_input)
    
    student_code, student_lastname, student_firstname, section, assessment_type = parse_infos(temp_file, output_dir)
    
    section_output_dir, output_file = create_output_file(output_dir, student_code, student_lastname, student_firstname, section, assessment_type)
    
    score, total_items = check_items(temp_file, ans_key, output_dir, assessment_type, section_output_dir, output_file)
    
    new_output_file = clean_up(temp_file, output_dir, student_code, student_lastname, section_output_dir, output_file, assessment_type, score)
    
    record_score(section_output_dir, assessment_type, student_code, score, total_items)
    
    checked_items = read_output(section_output_dir, new_output_file)
    
    return checked_items
    
    


if __name__ == '__main__':
    get_input()
    
    
    
    
    
    
    
    
    
    
    
    
    
