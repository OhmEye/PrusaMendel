include <configuration.scad>
use <z-motor-mount.scad>
use <rod-clamp.scad>

for (i=[-1,1])
translate([24*i,0,0])
translate([-5,0,5])
rotate([0,90,0])
rodclamp();

for (i=[-1,1])
translate([9*i,0,30]) 
rotate([0,90,0])
zmotormount();