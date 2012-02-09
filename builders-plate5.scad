include <configuration.scad>
use <gregs-new-x-carriage.scad>
use <gregs-new-coupling.scad>
use <gregs-y-axis-holder.scad>

union ()
{
	rotate(180)
	carriage_clamps_and_ram();

	for (i=[0:2])
	translate([i*24-35,43,0])
	y_axis_holder();

	for(i=[0,1])
	translate([38+i*33,-28,0])
	coupling(); 

	for(i=[0,1])
	translate([55,20+i*35,0])
	coupling_cup ();
}