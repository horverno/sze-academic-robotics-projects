#!/usr/bin/python

import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)

# set up GPIO BUTTON input channel  
GPIO.setup(37, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(33, GPIO.IN, pull_up_down=GPIO.PUD_UP)
# set up GPIO LED output channel  
GPIO.setup(7,  GPIO.OUT)
GPIO.setup(11, GPIO.OUT)  
GPIO.setup(13, GPIO.OUT)  
GPIO.setup(15, GPIO.OUT) 

while True:
    input_state1 = GPIO.input(33)
    input_state2 = GPIO.input(37)

    if input_state2 == False:
        print('Button2 down')
        GPIO.output(15,GPIO.HIGH) 
        time.sleep(0.2)
    else:
        GPIO.output(15,GPIO.LOW)     

    if input_state1 == False:
        print('Button1 down')
        GPIO.output(7,GPIO.HIGH) 
        time.sleep(0.2)
    else:
        GPIO.output(7,GPIO.LOW)   