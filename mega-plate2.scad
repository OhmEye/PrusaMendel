include <configuration.scad>

use <bar-clamp.scad>
use <ramps-holder.scad>
use <gregs-x-carriage.scad> 

use <x-end-motor.scad> 
use <x-end-idler.scad>
use <gregs-new-coupling.scad> 
use <gregs-y-axis-holder.scad>
use <gregs-wade-v3.scad> 
use <gregs-wadebits.scad>

use <gregs-endstop-holder.scad> 
//use <endstop-holder.scad> 

//translate([61,-66])
//endstop();

translate([-13,68])
endstop();

translate([-25,91])
rotate(180)
#endstop();


color([1,0,1])
translate([-16,51,0])
//rotate(180)
render()
xendmotor(endstop_mount=true,curved_sides=true,closed_end=true,luu_version=true);

color([1,0,1])
translate([-13,37,0])
rotate(180)
translate([-10,33,0]) 
rotate(180)
render()
xendidler(endstop_mount=false,curved_sides=true,closed_end=false,luu_version=true);

translate([91,-32,0])
rotate(90)
wade(hotend_mount=2);

translate([3,98,0])
rotate(90)
translate([-5,40,15.25]) 
rotate([0,-90,0])
wadeidler();

translate([60,60,0])
WadesL();

for (i=[0:1])
translate([44+17*i,-60,0]) 
rotate(90)
barclamp();

for (i=[0:3])
translate([45+16.5*i,-95])
rotate(90)
barclamp();

translate([-54,22])
rotate(-90)
barclamp();

#translate([-22,-42])
rotate(-90)
barclamp();


translate([-59,-55,0])
{
	rotate(180)
	gregs_x_carriage();
	
	for (i=[-1,1]) 
	translate([0,i*(13.4),0])
	belt_clamp();
	belt_clamp_channel();
}

rotate(90)
for (i=[0:2])
translate([i*23-95,-27,0])
y_axis_holder();

translate([-73,11,0])
coupling_cup(); 

translate([-68,46,0])
coupling_cup ();

%cube([190,190,1],true);
