//PRUSAMendel
//GNUGPLv2
//GregFrost

/**
*@categoryPrinted
*/

layer_height=0.4;
perimeter_w_over_t=2;

single_layer_width=layer_height*perimeter_w_over_t;
bearing_inner=22.2;
thickness=layer_height*4.1;
height=7+thickness;
wall_ascent=5;
wall_descent=0.5;
tolerance=0.15;

module inner()
{
	difference()
	{
		cylinder(r=bearing_inner/2+single_layer_width+tolerance,h=height);
		translate([0,0,-1])
		cylinder(r=bearing_inner/2+tolerance,h=height+2);
	}

	difference()
	{
		cylinder(r=bearing_inner/2+wall_ascent,h=thickness);
		translate([0,0,-1])
		cylinder(r=bearing_inner/2-wall_descent,h=thickness+2);
	}
}

module outer()
{
	difference()
	{
		cylinder(r=bearing_inner/2+2*single_layer_width+2*tolerance,h=height);
		translate([0,0,-1])
		cylinder(r=bearing_inner/2+single_layer_width+2*tolerance,h=height+2);
	}

	difference()
	{
		cylinder(r=bearing_inner/2+wall_ascent,h=thickness);
		translate([0,0,-1])
		cylinder(r=bearing_inner/2-wall_descent,h=thickness+2);
	}
}

inner();

translate([34,0,0])
outer();
