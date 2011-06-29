include <configuration.scad>
use <bar-clamp.scad>
use <gregs_ybrac-t.scad>
use <pulley_ausxmods.scad>
use <gregs-endstop-holder.scad> 
use <ramps-holder.scad>

union ()
{
	translate([20,68,0]) 
	rotate(180)
	barclamp();

	translate([13,50,0]) 
	rotate(180)
	barclamp();

	translate([-10,15,0]) 
	rotate(180)
	barclamp();

	translate([-8,-2,0]) 
	rotate(180)
	barclamp();

	translate([4,32,0]) 
	rotate(180)
	barclamp();

	translate([89,35,0]) 
	rotate(180)
	barclamp();

	translate([89,55,0])
	rotate(180)
	barclamp();
	
	translate([89,15,0]) 
	rotate(180)
	barclamp();


//	translate([36,18,0]) 
//	ausxmods();
//
//	translate([50,60,0]) 
//	ausxmods();

	ybract();


	 for (i=[0:1]) 
	 translate([58,-18*i-15-4])
	 endstop();
	
	 translate([18,-43])
	 rampsholder();
}