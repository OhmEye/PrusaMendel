// PRUSA Mendel  
// Filament Guide
// GNU GPL v2
// Greg Frost

include <configuration.scad>

/**
 * @name Filament Guide
 * @category Printed
 */ 
filament_guide();

module filament_guide()
{
	difference()
	{
		union ()
		{
			translate([0,0,1])
			cube([26,11,2],center=true);
			translate([0.5,0,5.5])
			cube([16,11,11],center=true);
		}

		translate([17/2-5.7,-11/2+4.2,-1])
		{
			cylinder(r=3.5/2,h=13);
			cylinder(r=7/2,h=7);
		}

		translate([0,11/2,2+6.4])
		rotate([0,90,0])
		cylinder(r=3.2/2,h=19,center=true);
	}
}
