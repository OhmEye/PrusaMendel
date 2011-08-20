include <configuration.scad>
use <frame-vertex.scad>
use <z-motor-mount.scad> 
use <rod-clamp.scad>
use <gregs-ybrac-t.scad> 

%square([190,190],center=true);


{
translate([40,20,0])
vertex(true);

for (i=[0])
mirror()
translate([40,20,0])
vertex(true);
}

mirror([0,1,0])
{
translate([40,20,0])
vertex(true);

for (i=[0])
mirror()
translate([40,20,0])
vertex(true);
}

translate([65,0,0])
rodclamp(); 

mirror ()
translate([65,0,0])
rodclamp(); 

*translate([-64,-58,0])
import_stl ("builders-plate4.stl");

translate([-62,-93,0]) 
rotate(0)
vertex(false);

translate([17,30,0]) 
rotate(60)
vertex(false);

translate([-27,18,0])
{translate([54,0,8]) 
zmotormount();

translate([0,0,8]) 
rotate(180)
zmotormount();
}

translate([51,-30,0]) 
rotate(187)
ybract(); 

