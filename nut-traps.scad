
include <configuration.scad>

fan_support_thickness=8;
fan_trap_width=3; 
fan_hole_height=4;

translate([14,0,0])
{
	rotate(30)
	difference()
	{
	cylinder(r=m4_nut_diameter, h=3,$fn=6);
	translate([0,0,1])
	cylinder(r=m4_nut_diameter/2,h=3,$fn=6);
	}
	
	translate([12,0,0])
	rotate(30)
	difference()
	{
	cylinder(r=m3_nut_diameter, h=3,$fn=6);
	translate([0,0,1])
	cylinder(r=m3_nut_diameter/2,h=3,$fn=6);
	}
}

difference()
{
	translate([0,0,fan_support_thickness/2])
	cube([fan_support_thickness+5,fan_support_thickness,fan_support_thickness],true);
	translate([0,0,fan_hole_height])
	{
		rotate([90,0,0])
		rotate(180/8)
		cylinder(r=m3_diameter/2,h=fan_support_thickness+2,
			center=true,$fn=8);
		translate([0,0,0])
		rotate([90,0,0])
		rotate([0,0,180/6])
		cylinder(r=(m3_nut_diameter-0.5)/2,h=fan_trap_width,
			center=true,$fn=6);

		translate([0,0,-(fan_hole_height+1)/2])
		cube([(m3_nut_diameter-0.5)*cos(30),fan_trap_width,
			fan_hole_height+1],center=true);

		translate([0,0,-fan_hole_height])
		cube([(m3_nut_diameter-0.5)*cos(30)+1,fan_trap_width+1,
			0.8],center=true);
	}

	translate([-(fan_support_thickness+5)/2-1,0,4])
	rotate([0,90,0])
	cylinder(r=m3_nut_diameter/2,h=3,$fn=6);
}
