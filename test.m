clear
clc

ToDeg = 180/pi;
ToRad = pi/180;

euler_init = [45;45;0]*ToRad;
R_init = eul2rot(euler_init)

result = rot2eul(R_init)*ToDeg
 