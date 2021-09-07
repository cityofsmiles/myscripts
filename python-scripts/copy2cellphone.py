#!/usr/bin/env python
# coding: utf-8



import PySimpleGUI as sg      
import os
import subprocess

layout = [[sg.Text('Enter text to paste.')],      
                 [sg.InputText()],      
                 [sg.Submit(), sg.Cancel()]]      

window = sg.Window('Copy to Cellphone', layout)    

event, values = window.read()    
window.close()

text_input = values[0]    

os.chdir("/home/jonathan/Documents/laptop/scripts/bash-scripts/")

cmd = subprocess.check_call("./send-text-to-ssh-cp.sh '%s'" % text_input, shell=True)



