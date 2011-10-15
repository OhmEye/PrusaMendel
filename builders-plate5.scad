include <configuration.scad>
use <gregs-x-carriage.scad>
use <gregs-new-coupling.scad>
use <gregs-y-axis-holder.scad>

union ()
{
	rotate(180)
	gregs_x_carriage();

	for (i=[-1,1]) 
	translate([0,i*(13.15),0])
	belt_clamp();
	
	belt_clamp_channel();

	for (i=[0:2])
	translate([i*24-35,50,0])
	y_axis_holder();

	translate([-53,-18,0])
	coupling(); 

	translate([-53,15,0])
	coupling(); 

	translate([-55,50,0])
	coupling_cup(); 

	translate([55,0,0])
	coupling_cup ();
}