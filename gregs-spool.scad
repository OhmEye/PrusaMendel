
/*
 *  Filament Spool
 *  by Greg Frost.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
*/

use<Libs.scad>

num_balls=9;
ball_diameter=8;
ball_separation=0.01;
bearing_slop=0.5;
bearing_support_thickness=5;
bearing_gap=1.5;
shaft_diameter=8;

dovetail_height=8;

dovetail_width=9;
arm_width=15;
arm_stub_length=12;
slot_width=9.4;

ball_facets=20;
bearing_facets=80;
shaft_facets=15;

ball_translation=((ball_diameter+ball_separation)/2)/sin(180/num_balls);
race_inside_height=ball_diameter+bearing_slop;
race_outside_height=race_inside_height+bearing_support_thickness;
race_radius=ball_translation+ball_diameter/2+bearing_slop/2+bearing_support_thickness;
race_inside_radius=ball_translation+ball_diameter/3;

//bushing_race ();

//cross_piece();
//translate([0,(arm_width+2),0])
//spoke();


//race ();
//hub();
//translate((race_radius+race_inside_radius)/sqrt(2)*[-1,-1,0])
//hub();
//
//translate([-40,10])
//rotate(30)
//balls();

//for(i=[-1:-3])
//translate([0,i*(arm_width+2),0])
//cross_piece();
//
//for(i=[0:5])
//translate([0,i*(arm_width+2),0])
//spoke();

//test_dovetail ();

race_for_viks();


module test_dovetail ()
{
	dovetail(height=dovetail_height,width=dovetail_width,male=false);

	translate([0,2*dovetail_width,0])
	difference ()
	{
	translate([0.5*dovetail_width,0,0])
	cube([dovetail_width,dovetail_width*1.5,dovetail_height],center=true);
	dovetail(height=dovetail_height+2,width=dovetail_width+0.5,male=false);
	}
	
}

module balls()
{
	for(i=[0:5])
	for(j=[0:2])
	translate([i*(ball_diameter+2),j*(ball_diameter+2),0])
	ball();
}

module ball()
{
	difference()
	{
		sphere(r=ball_diameter/2,$fn=ball_facets);
		translate([0,0,-ball_diameter/2])
		cube([ball_diameter+1,ball_diameter+1,ball_diameter],center=true);
	}
}

module race()
{
	translate([0,0,race_outside_height/2])
	difference()
	{
		render();
		difference()
		{
			cylinder(r=race_radius,h=race_outside_height,center=true,$fn=bearing_facets);
			cylinder(r=race_inside_radius,h=race_outside_height+2,center=true,$fn=bearing_facets);
		}
		raceway();
	}

	for(arm=[0:2])
	rotate(arm*360/3)
	translate([0,0,dovetail_height/2])
	difference()
	{
		translate([-ball_translation-ball_diameter/2-bearing_slop-arm_stub_length/2,0,0])
		cube([arm_stub_length,arm_width,dovetail_height],center=true);
		translate([-ball_translation-ball_diameter/2-bearing_slop-arm_stub_length,0,0])
		dovetail(height=dovetail_height+2,width=dovetail_width+0.5,male=false);
	}
}

module race_for_viks()
{
	arm_stub_length=53;

	difference()
	{
		union()
		{
			render()
			translate([0,0,dovetail_height/4])
			difference()
			{
			cylinder(r=race_radius*1.5,h=dovetail_height/2,center=true,$fn=bearing_facets);
			cylinder(r=race_radius*1.5-7,h=dovetail_height+2,center=true,$fn=bearing_facets);
			}
			for(arm=[0:2])
			rotate(arm*360/3)
			{
				translate([-arm_stub_length/2,0,dovetail_height/2])
				cube([arm_stub_length,arm_width,dovetail_height],center=true);
		
				render()intersection()
				{
					translate([-50,-arm_width/2,0])
					cube([10,arm_width,race_outside_height]);
					translate([0,0,-1])
					cylinder(r=50,h=20,$fn=200);
				}
			}
		}

		translate([0,0,dovetail_height/2])
		cylinder(r=9/2,h=dovetail_height+2,center=true,$fn=20);
	}

}

module bushing_race()
{
	bushing_inner_diameter=21.5;
	bushing_clearance=0.5;
	bushing_support_thickness=5;

	difference ()
	{
		union()
		{
			cylinder(r1=bushing_inner_diameter/2+(dovetail_height/2)*cos(60),
				r2=bushing_inner_diameter/2,
				h=dovetail_height/2,$fn=bearing_facets);
			translate([0,0,dovetail_height/2])
			cylinder(r2=bushing_inner_diameter/2+(dovetail_height/2)*cos(60),
				r1=bushing_inner_diameter/2,
				h=dovetail_height/2,$fn=bearing_facets);
		}

		translate([0,0,-1])
		cylinder(r=8/2+0.25,h=dovetail_height+2);
	}

	difference()
	{
		cylinder(r=bushing_inner_diameter/2+bushing_clearance+(dovetail_height/2)*cos(45)+bushing_support_thickness,h=dovetail_height);

		cylinder(r1=bushing_inner_diameter/2+bushing_clearance+(dovetail_height/2)*cos(45),
			r2=bushing_inner_diameter/2+bushing_clearance,
			h=dovetail_height/2,$fn=bearing_facets);
		translate([0,0,dovetail_height/2])
		cylinder(r2=bushing_inner_diameter/2+bushing_clearance+(dovetail_height/2)*cos(45),
			r1=bushing_inner_diameter/2+bushing_clearance,
			h=dovetail_height/2,$fn=bearing_facets);
	}

	for(arm=[0:2])
	rotate(arm*360/3)
	translate([0,0,dovetail_height/2])
	difference()
	{
		translate([-ball_translation-ball_diameter/2-bearing_slop-arm_stub_length/2,0,0])
		cube([arm_stub_length,arm_width,dovetail_height],center=true);
		translate([-ball_translation-ball_diameter/2-bearing_slop-arm_stub_length,0,0])
		dovetail(height=dovetail_height+2,width=dovetail_width+0.5,male=false);
	}
}

module hub()
{
	translate([0,0,race_outside_height/2])
	difference ()
	{
		cylinder(r=race_inside_radius-bearing_gap,h=race_outside_height,center=true,$fn=bearing_facets);
		cylinder(r=shaft_diameter/2,h=race_outside_height+2,center=true,$fn=shaft_facets);
		raceway();
	
		translate([-race_inside_radius,-race_inside_radius,0])
		cube([race_inside_radius*2,race_inside_radius*2,race_outside_height/2+1]);
	}
}

module raceway()
{
	scale([1,1,race_inside_height/ball_diameter])
	{
		rotate(180/bearing_facets)
		rotate_extrude ($fn=bearing_facets)
		{
			translate([ball_translation+bearing_slop/2,0])
			circle(r=ball_diameter/2,$fn=ball_facets);
			translate([ball_translation-bearing_slop/2,0])
			circle(r=ball_diameter/2,$fn=ball_facets);
			translate([ball_translation,0])
			square([bearing_slop,ball_diameter],center=true);
		}
	}
}

module cross_piece()
{
l=145;

	difference()
	{
		translate([-l/2,0,0])
		cube([l,arm_width,dovetail_height],true);
		rotate(180)
		dovetail(height=dovetail_height+2,width=dovetail_width+0.5,male=false);
		translate([-l,0,0])
		dovetail(height=dovetail_height+2,width=dovetail_width+0.5,male=false);

		translate([-l/2,0,0])
		cube([l-30,slot_width,dovetail_height+2],true);

		translate([-l+15,0,0])
		cylinder(r=slot_width/2,h=dovetail_height+2,center=true);
		translate([-15,0,0])
		cylinder(r=slot_width/2,h=dovetail_height+2,center=true);

		for (i=[1:6])
		translate([-l/7*i,0,0])
		rotate([90,0,0])
		cylinder(r=3/2-0.2,h=arm_width+2,center=true);
		
	}	
}

module spoke ()
{
l=150;
slat=105;

	difference()
	{
	union()
	{
		dovetail(height=dovetail_height,width=dovetail_width,male=false);
		translate([-l/2,0,0])
		cube([l,arm_width,dovetail_height],true);	
		translate([-l,0,0])
		cylinder(r=arm_width/2,h=dovetail_height,center=true);
	}

	translate([-l,0,0])
	cylinder(r=slot_width/2,h=dovetail_height+2,center=true);

	translate([-l/2+3,0,0])
	cube([l-24,slot_width,dovetail_height+2],true);	

	translate([-l+15,0,0])
	cylinder(r=slot_width/2,h=dovetail_height+2,center=true);

	translate([-9,0,0])
	cylinder(r=slot_width/2,h=dovetail_height+2,center=true);

		for (i=[0:2])
		translate([-l+16+i*9,0,0])
		rotate([90,0,0])
		cylinder(r=3/2-0.2,h=arm_width+2,center=true);
	}

	translate([-slat,0,dovetail_height/2])
	rotate([0,-90,0])
	{
	dovetail(height=dovetail_height,width=dovetail_width,male=false);

	translate([0,-arm_width/2,-3*dovetail_height/2])
	cube([dovetail_height,arm_width,dovetail_width]);
	translate([-dovetail_height,-arm_width/2,-3*dovetail_height/2])
	cube([dovetail_height,arm_width,dovetail_width+dovetail_height]);
	}
}