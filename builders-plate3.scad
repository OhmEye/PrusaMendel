include <configuration.scad>
use <z-motor-mount.scad>
use <rod-clamp.scad>

for (i=[-1,1])
translate([25*i,33,0])
rotate(90)
rodclamp();

for (i=[-1,1])
translate([31*i,0,0]) 
rotate(90*(i+1))
zmotormount();