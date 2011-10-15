// Gregs PRUSA Mendel  
// GNU GPL v2
// Greg Frost
//https://github.com/GregFrost/PrusaMendel

include <configuration.scad>

strain_reliever();


terminal_separation=14.5;
terminal_hole=8.5;
edge=2;
width=terminal_separation+terminal_hole+edge*2;
landing=10;
space=12;
length=landing+edge+space+terminal_hole;
thickness=8;
bottom=1.3;

echo ("length", length);
echo ("width", width);

top_length=27;

top_inner_height=12;
top_height=13.3;
side_length=20;

wall=2;

cord=6.4;
cord2=4;

module strain_reliever()
{
//	translate([0,0,1])
	difference()
	{
		cube([width,length,thickness+bottom]);
		translate([edge+terminal_hole/2,edge+terminal_hole/2,-1])
		cylinder(r=terminal_hole/2,h=thickness+1);
		translate([width-edge-terminal_hole/2,edge+terminal_hole/2,-1])
		cylinder(r=terminal_hole/2,h=thickness+1);

		translate([width/2, length-landing/2,0])
		{
			translate([0,0,thickness+bottom-3])
			cylinder(r=m3_nut_diameter/2,h=4,$fn=6);
			translate([0,0,-1])
			cylinder(r=m3_diameter/2,h=thickness+bottom+2);
		}
	}
//	cube([width,length,bottom]);

	translate([-width-4,0,0])
	difference()
	{
		union()
		{
			cube([width,landing,top_height]);
			translate([-wall,0,0])
			cube([wall,side_length,top_height+3]);
			translate([width,0,0])
			cube([wall,side_length,top_height+3]);
			cube([width,top_length,top_height-top_inner_height]);
		}

		translate([cord/2+edge,-1,top_height-cord/2+1.5])
		rotate([-90,0,0])
		{
			cylinder(r=cord/2,h=landing+2);
			translate([-cord/2,-cord/2,0])
			cube([cord,cord/2,landing+2]);
		}

		translate([width-cord2-edge*2,0,top_height-1])
		cube([cord2,landing+2,2]);

#		translate([width/2,landing/2,-1])
		cylinder(r=m3_diameter/2,h=top_height+2);
	}
}
