// OhmEye MendelMax derived from Gregs PRUSA Mendel  
// X-carriage
// Used for sliding on X axis
// GNU GPL v2
// Greg Frost
//https://github.com/GregFrost/PrusaMendel
// OhmEye
//https://github.com/OhmEye/Mendelmax

include <configuration.scad>

clearance=0.8;

sdp_diameter=15.5+clearance;
sdp_length=27+clearance;
sdp_support_thickness=3.2; 
sdp_end_diameter=m8_diameter+1.5;
sdp_end_base=1.5;

sdp_holder_width=sdp_diameter+2*sdp_support_thickness-1;
sdp_holder_length=sdp_length+sdp_support_thickness;
sdp_holder_height=sdp_diameter*0.75+sdp_support_thickness-3.5+sdp_end_base;
sdp_holder_gap=(lm8uu_holder_length-6*lm8uu_support_thickness)/2;

module sdp_bearing_holder(sdp_tweak=0)
{
	difference()
	{
		union() {
			cube([sdp_holder_width,sdp_holder_length+sdp_tweak,sdp_holder_height+1]);
			translate([sdp_holder_width/2,0,12.5+sdp_end_base])rotate([-90,0,0])cylinder(r=sdp_holder_width/2,h=sdp_holder_length+sdp_tweak,$fn=40);
		}
		translate([sdp_holder_width/2,0,sdp_holder_width/2])
		rotate([-90,0,0])
		translate([0,-1.5-sdp_end_base,-10])
		cylinder(r=sdp_diameter/2,h=sdp_length+20+sdp_tweak,$fn=40);

//		translate([0,0,sdp_support_thickness])cube([sdp_holder_width,sdp_tweak,sdp_support_thickness]);

	}
		cube([sdp_holder_width,sdp_holder_length-sdp_tweak,sdp_support_thickness*1.7]);

}

//sdp_bearing_holder(-15);
