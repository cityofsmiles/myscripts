#!/usr/bin/env python

# python3 '/home/jonathan/Documents/laptop/scripts/Python-Scripts/check-answers-2cols.py' 

import PySimpleGUI as sg      
import os
from csv import writer
from pathlib import Path


def get_input(): 
    temp_file = "temp.txt"
    temp_dir = "/home/jonathan/.temp_dir"
    
    left_col = [[sg.Text('Grading Period', size=(15, 1)), sg.InputText(key='PERIOD')],
                [sg.Text('Assessment Type', size=(15, 1)), sg.InputText(key='ASSESSMENT')],
                [sg.Text('Enter student\'s infos and answers.')],      
                 [sg.Multiline(size=(60,20), key='answers', autoscroll=True)],      
                 [sg.Submit(), sg.Cancel()]]   
    
    right_col = [[sg.Text('Results:')],      
                 [sg.Multiline(size=(40,25), key='-OUTPUT-', autoscroll=True)]]

    layout = [[sg.Column(left_col, element_justification='c'), sg.VSeperator(),sg.Column(right_col, element_justification='c')]]
    
    window = sg.Window('Test Auto-Checker', layout, resizable=True)    

    while True:
        event, values = window.read()  
        if event in (None, 'Cancel'):
            break
        if event == "Submit":
            if os.path.isdir(temp_dir) == False:
                os.mkdir(temp_dir) 
            os.chdir(temp_dir)
            student_input = values['answers']
            f= open(temp_file,"w+")
            f.write(student_input)
            f.close()
            grading_period = values['PERIOD']
            grading_period = grading_period + "-Grading"
            assessment_type = values['ASSESSMENT']
            checked_items = check_answers(temp_file, temp_dir, grading_period, assessment_type)
            window['-OUTPUT-'].update(checked_items)
            window['answers'].update('')
            
            
def parse_infos(temp_file, temp_dir):
    os.chdir(temp_dir)
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


def create_output_file(grading_period, assessment_type, student_code, student_lastname, student_firstname, section):
    output_dir = os.path.join('/home/jonathan/Old-Docs/excel/shs/20-21/Class-Records', section, 'Quiz-and-Test-Scores', grading_period, assessment_type)
    output_file = student_code + "-" + student_lastname + ".txt"
    os.chdir(output_dir)
    f= open(output_file,"w+")
    f.write(student_lastname + ", " + student_firstname + "\n")
    f.write(section + "\n")
    f.write(student_code + "\n\n")
    f.close()
    return output_dir, output_file
    
    
def simplecount(filename):
    lines = 0
    for line in open(filename):
        lines += 1
    return lines


def check_items(temp_dir, temp_file, output_dir, grading_period, assessment_type, output_file):  
    os.chdir(temp_dir)
    num_lines = simplecount(temp_file)
    file_temp = open(temp_file)
    os.chdir(output_dir)
    anskey_filename = assessment_type + "-Answer-Key.txt"
    answer_key = os.path.join('/home/jonathan/Old-Docs/excel/shs/20-21/Tests-and-Quizzes', grading_period, anskey_filename)
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
        
        f.write(item_num + ". " + item_answer + " (" + correct_answer + ") " + comment + "\n")
    total_items = score + mistake
    f.write("\n\nScore = " + str(score) + "\n")
    f.write("Mistake = " + str(mistake) + "\n")
    f.write("Total = " + str(total_items))
    return score, total_items
    

def clean_up(temp_file, output_dir, temp_dir, student_code, student_lastname, output_file, score):
    os.chdir(output_dir)
    new_output_file = student_code + "-" + student_lastname + "-" + str(score) + ".txt"
    os.rename(output_file, new_output_file) 
    os.chdir(temp_dir)
    os.remove(temp_file)
    return new_output_file


def append_list_as_row(file_name, list_of_elem):
    # Open file in append mode
    with open(file_name, 'a+', newline='') as write_obj:
        # Create a writer object from csv module
        csv_writer = writer(write_obj)
        # Add contents of list as last row in the csv file
        csv_writer.writerow(list_of_elem)
        
    
def record_score(output_dir, assessment_type, student_code, score, total_items):
    record_csv = assessment_type + '-Scores.csv'
    os.chdir(output_dir)
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


def read_output(output_dir, new_output_file):
    os.chdir(output_dir)
    checked_items = Path(new_output_file).read_text()
    return checked_items
    

def check_answers(temp_file, temp_dir, grading_period, assessment_type):
    student_code, student_lastname, student_firstname, section = parse_infos(temp_file, temp_dir)

    output_dir, output_file = create_output_file(grading_period, assessment_type, student_code, student_lastname, student_firstname, section)
    
    score, total_items = check_items(temp_dir, temp_file, output_dir, grading_period, assessment_type, output_file)
    
    new_output_file = clean_up(temp_file, output_dir, temp_dir, student_code, student_lastname, output_file, score)
    
    record_score(output_dir, assessment_type, student_code, score, total_items)
    
    checked_items = read_output(output_dir, new_output_file)
    
    return checked_items


if __name__ == '__main__':
    get_input()
    
    
    
    
    
    
    
    
    
    
    
    
    
