use <heart.scad>
use <parametric_involute_gear_v5.0.scad>

//Define colours to use to recognise individual gears.
coded_colors=[
[0.2,0.2,0.2,1],			// 0 black
[136/255,70/255,38/255,1],	// 1 brown
[1,0,0,1],				// 2 red
[1,163/255,70/255,1],		// 3 orange
[1,1,0,1],				// 4 yellow
[0,213/255,0,1],			// 5 green
[0,0,213/255,1],			// 6 blue
[162/255,48/255,165/255,1],	// 7 purple
[1,1,1,1],				// 8 white
[0.5,0.5,0.5,1],			// 9 grey
[1,0.5,0.75,1],			// 10 pink
[0.5,0.5.0,1]			// 11 khaki
];

// Define the parameters for the two types of gears to use.

gear1_teeth = 15;
gear2_teeth = 10;
axis_angle =acos(1/sqrt(5));

echo ("axis_angle", axis_angle);

outside_circular_pitch=2000;
heart_width = 200;

outside_pitch_radius1 = gear1_teeth * outside_circular_pitch / 360;
outside_pitch_radius2 = gear2_teeth * outside_circular_pitch / 360;
pitch_apex1=outside_pitch_radius2 * sin (axis_angle) + 
	(outside_pitch_radius2 * cos (axis_angle) + outside_pitch_radius1) / tan (axis_angle);
cone_distance = sqrt (pow (pitch_apex1, 2) + pow (outside_pitch_radius1, 2));
face_width = cone_distance;
pitch_apex2 = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius2, 2));
echo ("cone_distance", cone_distance);
pitch_angle1 = asin (outside_pitch_radius1 / cone_distance);
pitch_angle2 = asin (outside_pitch_radius2 / cone_distance);
echo ("pitch_angle1, pitch_angle2", pitch_angle1, pitch_angle2);
echo ("pitch_angle1 + pitch_angle2", pitch_angle1 + pitch_angle2);

big_gear_rotate = 
	2 * atan (			
		(cos (90 - pitch_angle1 - pitch_angle2) * cos (36)) /
		sin (90 - pitch_angle1 - pitch_angle2)	);

small_gear_rotate = 
	2 * atan (
		(cos (90 - pitch_angle1 - pitch_angle2) * cos (72)) /
		sin (90 - pitch_angle1 - pitch_angle2)	);

gear_bottom_apex_height=45.5;
gear_bottom_apex_thickness=24;
bearing_depth=17;


bearing_id = 05;
bearing_od = 10;

//===========================================================

// first create heart.stl.
//translate ([0,0,15])
//heart (width=heart_width);

gear_num=1; // 0 for all gears.
gear_mask= (gear_num==0) ? 4095 : pow(2,gear_num-1);

// This intersects the gear cluster with the heart stl created above.
// I used it to get an aesthetically pleasing orientation.
//intersected_gears(use_stl=false);

// This is used to generate the individual gear#.stl files where # is the gear number from 1 to 12. 
// It does this by intersecting them and then reversing the rotation so that the gear is upright again.
//repositioned_gear();

// This uses the generated STLs to show a colour coded version of the gear cluster. 
// Use it to aid with assembly.
//pretty_gears();


// For assembly, each of the gears is split into two parts.
// The inner part screws into the mount. 
// The outer part is glued to the inner part.
// I have used various methods to try to make the outer gears as hollow. 
//This could definately be improved.

//15tooth_inner ();
//10tooth_inner ();

//gear1_outer ();
//gear2_outer ();
//gear3_outer ();
//gear4_outer ();
//gear5_outer ();
//gear6_outer ();
//gear7_outer ();
//gear8_outer ();
//gear9_outer ();
//gear10_outer ();
//gear11_outer ();
//gear12_outer ();

// These print the various parts for my re-designed bearing mount centre piece.

//rotate([0,180,0]) bevel_gear_cluster_support (part=1);
//bevel_gear_cluster_support (part=2);
//bevel_gear_cluster_support (part=3);

//bevel_gear_cluster_support();

// The modules for the handle and the knob.

//handle();
//knob();

module repositioned_gear ()
{
			rotate ([180,0,0])
//	translate ([0,0,gear_bottom_apex_height])
	if (gear_num == 1)
	{
		rotate ([180,0,0])
		intersected_gears ();
	}
	else if (gear_num == 2)
	{
		rotate([0,0,-360/15*0.5])
		rotate([0,big_gear_rotate,0])
		rotate ([0,-180,0])
		rotate ([0,0,-280])
		intersected_gears ();
	}
	else if (gear_num == 3)
	{
		rotate([0,0,-360/15*0.5])
		rotate([0,big_gear_rotate,0])
		rotate([0,0,-360*2/5])
		rotate ([0,-180,0])
		rotate ([0,0,-280])
		intersected_gears ();
	}
	else if (gear_num >= 4 && gear_num <= 8)
	{
		rotate([0,-(pitch_angle1+pitch_angle2),0])
		rotate([0,0,-360/5*(gear_num-4)])
		rotate ([0,-180,0])
		rotate ([0,0,-280])
		intersected_gears ();
	}
	else if (gear_num == 9)
	{
		rotate([0,-180,0])
		rotate ([0,-180,0])
		rotate ([0,0,-280])
		intersected_gears ();
	}
	else if (gear_num == 10)
	{
		rotate([0,-(180-small_gear_rotate),0])
		rotate([0,0,-360/10*7])
		rotate ([0,-180,0])
		rotate ([0,0,-280])
		intersected_gears ();
	}
	else if (gear_num == 11)
	{
		rotate([0,-(180-small_gear_rotate),0])
		rotate([0,0,-360/10*3])
		rotate ([0,-180,0])
		rotate ([0,0,-280])
		intersected_gears ();
	}
	else if (gear_num == 12)
	{
		rotate([0,-(180-small_gear_rotate),0])
		rotate([0,0,-360/10*1])
		rotate ([0,-180,0])
		rotate ([0,0,-280])
		intersected_gears ();
	}
	else
	{
		intersected_gears ();
	}
}

module intersected_gears (use_stl=false)
{
	intersection ()
	{
		rotate ([0,0,280])
		rotate ([0,180,0])
		bevel_gear_cluster (use_stl=use_stl);
		import_stl("heart.stl");
	}
}

module pretty_gears ()
{
	rotate ([0,0,280])
	rotate ([0,180,0])
	bevel_gear_cluster (use_stl=true);
}

module bevel_gear_cluster (use_stl=false)
{
	if (in_mask (gear_mask, 1))
	color(coded_colors[1])
	translate([0,0,-pitch_apex1])
	{
		if (use_stl)
		{
			rotate([0,0,90+360/30-2])
			rotate([180,0,0])
			translate([0,0,-pitch_apex1])
			import_stl("gear1.stl");
		}
		else
		{
			bevel_gear (
				number_of_teeth=gear1_teeth,
				cone_distance=cone_distance,
				face_width=face_width,
				pressure_angle=30,
				outside_circular_pitch=outside_circular_pitch,
				bore_diameter=0,
				backlash = 1);
		}
	}

	if (in_mask (gear_mask, 2))
	color(coded_colors[2])
	rotate([0,-big_gear_rotate,0])
	translate([0,0,-pitch_apex1])
	rotate([0,0,360/15*0.5])
	{
		if (use_stl)
		{
			rotate([180,0,0])
			translate([0,0,-pitch_apex1])
			import_stl("gear2.stl");
		}
		else
		{
			bevel_gear (
				number_of_teeth=gear1_teeth,
				cone_distance=cone_distance,
				face_width=face_width,
				pressure_angle=30,
				outside_circular_pitch=outside_circular_pitch,
				bore_diameter=0,
				backlash = 1);
		}
	}

	if (in_mask (gear_mask, 3))
	color(coded_colors[3])
	rotate([0,0,360*2/5])
	rotate([0,-big_gear_rotate,0])
	translate([0,0,-pitch_apex1])
	rotate([0,0,360/15*0.5])
	{
		if (use_stl)
		{
			rotate([180,0,0])
			translate([0,0,-pitch_apex1])
			import_stl("gear3.stl");
		}
		else
		{
			bevel_gear (
				number_of_teeth=gear1_teeth,
				cone_distance=cone_distance,
				face_width=face_width,
				pressure_angle=30,
				outside_circular_pitch=outside_circular_pitch,
				bore_diameter=0,
				backlash = 1);
		}
	}

	for (i=[0:4])
	{
		if (in_mask (gear_mask, 4+i))
		color(coded_colors[i+4])
		rotate([0,0,360/5*i])
		rotate([0,(pitch_angle1+pitch_angle2),0])
		translate([0,0,-pitch_apex2])
		{
			if (use_stl)
			{
				if (i==0)
				rotate([180,0,0])
				translate([0,0,-pitch_apex2])
				import_stl("gear4.stl");

				if (i==1)
				rotate([180,0,0])
				translate([0,0,-pitch_apex2])
				import_stl("gear5.stl");

				if (i==2)
				rotate([180,0,0])
				translate([0,0,-pitch_apex2])
				import_stl("gear6.stl");

				if (i==3)
				rotate([180,0,0])
				translate([0,0,-pitch_apex2])
				import_stl("gear7.stl");

				if (i==4)
				rotate([180,0,0])
				translate([0,0,-pitch_apex2])
				import_stl("gear8.stl");
			}
			else
			{
				bevel_gear (
					number_of_teeth=gear2_teeth,
					cone_distance=cone_distance,
					face_width=face_width,
					pressure_angle=30,
					outside_circular_pitch=outside_circular_pitch,
					bore_diameter=0,
					backlash = 1);
			}
		}
	}

	if (in_mask (gear_mask, 9))
	color(coded_colors[9])
	rotate([0,180,0])
	translate([0,0,-pitch_apex2])
	{
		if (use_stl)
		{
			rotate([180,0,0])
			translate([0,0,-pitch_apex2])
			import_stl("gear9.stl");
		}
		else
		{
			bevel_gear (
				number_of_teeth=gear2_teeth,
				cone_distance=cone_distance,
				face_width=face_width,
				pressure_angle=30,
				outside_circular_pitch=outside_circular_pitch,
				bore_diameter=0,
				backlash = 1);
		}
	}

	if (in_mask (gear_mask, 10))
	color(coded_colors[10])
	rotate([0,0,360/10*7])
	rotate([0,180-small_gear_rotate,0])
	translate([0,0,-pitch_apex2])
	{
		if (use_stl)
		{
			rotate([180,0,0])
			translate([0,0,-pitch_apex2])
			import_stl("gear10.stl");
		}
		else
		{
			bevel_gear (
				number_of_teeth=gear2_teeth,
				cone_distance=cone_distance,
				face_width=face_width,
				pressure_angle=30,
				outside_circular_pitch=outside_circular_pitch,
				bore_diameter=0,
				backlash = 1);
		}
	}

	if (in_mask (gear_mask, 11))
	color(coded_colors[11])
	rotate([0,0,360/10*3])
	rotate([0,180-small_gear_rotate,0])
	translate([0,0,-pitch_apex2])
	{
		if (use_stl)
		{
			rotate([180,0,0])
			translate([0,0,-pitch_apex2])
			import_stl("gear11.stl");
		}
		else
		{
			bevel_gear (
				number_of_teeth=gear2_teeth,
				cone_distance=cone_distance,
				face_width=face_width,
				pressure_angle=30,
				outside_circular_pitch=outside_circular_pitch,
				bore_diameter=0,
				backlash = 1);
		}
	}

	if (in_mask (gear_mask, 12))
	color(coded_colors[0])
	rotate([0,0,360/10*1])
	rotate([0,180-small_gear_rotate,0])
	translate([0,0,-pitch_apex2])
	{
		if (use_stl)
		{
			rotate([180,0,0])
			translate([0,0,-pitch_apex2])
			import_stl("gear12.stl");
		}
		else
		{
			bevel_gear (
				number_of_teeth=gear2_teeth,
				cone_distance=cone_distance,
				face_width=face_width,
				pressure_angle=30,
				outside_circular_pitch=outside_circular_pitch,
				bore_diameter=0,
				backlash = 1);
		}
	}
}

sphere_r=18;
clearance=0.5;
gear_height=27;
bolt_head_hole_height=14;

module gear12_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear12.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);	

		intersection ()
		{
			cylinder (r1=14,r2=2,h=18);
			//cylinder (r1=21*0.63,r2=33,h=54);
		}
	}
}

module gear11_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear11.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);	

		intersection ()
		{
			cylinder (r1=37,r2=2,h=39);
			cylinder (r1=21*0.63,r2=33,h=54);
		}
	}
}

module gear10_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear10.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);	

		intersection ()
		{
			cylinder (r1=30,r2=2,h=32);
			cylinder (r1=21*0.63,r2=33,h=54);
		}
	}
}

module gear9_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear9.stl");

		translate ([-60,-60,-120])
		cube ([120,120,120]);	

		intersection ()
		{
			cylinder (r1=13,r2=2,h=16);
		}
		cylinder (r=3/16*25.4/2+0.5,h=60);

		translate ([0,0,48]) 
		{
			difference ()
			{
				cylinder(r=5.2,h=25,$fn=72);
				cylinder(r=4,h=25,$fn=72);
				cube([12,2,6],center=true);
			}
		}

	}
}

module gear8_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear8.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);	

		intersection ()
		{
			cylinder (r1=44,r2=2,h=54);
			cylinder (r1=21*0.63,r2=33,h=54);
		}
	}
}

module gear7_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear7.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);	

		cylinder (r1=21*0.65,r2=2,h=25.5);
	}
}

module gear6_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear6.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);	

		cylinder (r1=21*0.65,r2=2,h=33);
	}
}

module gear5_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear5.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);	

		cylinder (r1=21*0.65,r2=2,h=40);
	}
}

module gear4_outer ()
{
	bolt_head_hole_height=21;

	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear4.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);
	
		cylinder (r1=bolt_head_hole_height*0.7,r2=2,h=bolt_head_hole_height);
	}
}

module gear3_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear3.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);	

		translate ([-15,0,-25])
		rotate([45,0,0])
		cube ([30,30,30]);	
	}
}

module gear2_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear2.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);	

		cylinder (r1=14,r2=2,h=16);
	}
}

module gear1_outer ()
{
	difference ()
	{
		translate ([0,0,-gear_height-sphere_r-clearance])
		import_stl ("gear1.stl");
	
		translate ([-60,-60,-120])
		cube ([120,120,120]);
	
		cylinder (r1=bolt_head_hole_height*0.6,r2=2,h=bolt_head_hole_height);
	
		difference ()
		{
			cylinder (r1=28,r2=34,h=30);
			translate([0,-50,0])
			rotate ([0,-45,0])
			cube([100,100,100]);
		}
	}
	
	difference ()
	{
		cylinder (r1=bolt_head_hole_height*0.6+2,r2=2+2,h=bolt_head_hole_height);
		cylinder (r1=bolt_head_hole_height*0.6,r2=2,h=bolt_head_hole_height);
	}
}

module 15tooth_inner ()
{
	difference ()
	{
		intersection ()
		{
			rotate([0,180,0])
			translate ([0,0,-gear_height-sphere_r-clearance])
			import_stl ("gear1.stl");
	
			translate ([-60,-60,])
			cube ([120,120,gear_height]);
		}
	
		cylinder (r=2.5,h=30);
	}
}

module 10tooth_inner ()
{
	difference ()
	{
		intersection ()
		{
			rotate([0,180,0])
			translate ([0,0,-gear_height-sphere_r-clearance])
			import_stl ("gear4.stl");
	
			translate ([-60,-60,])
			cube ([120,120,gear_height]);
		}
	
		cylinder (r=2.5,h=30);
	}
}

function in_mask (mask,bit) = (mask % pow(2,bit)) > (pow(2,bit-1)-1);

cluster_support_radius=17;
bearing_depth=1.5;
bearing_rear_clearance=3;
bearing_height=4;
side_bearing_centre_z=(cluster_support_radius-bearing_depth-bearing_height/2)*cos(pitch_angle1+pitch_angle2);
bearing_clearance=0.25;
bearing_radius=5;

nut_slot_height=2.2;
nut_slot_width=6.25;
nut_head_radius=2.7;

module bevel_gear_cluster_support (part=1) //1=top 2=middle 3=bottom
{
	difference ()
	{
		if (part==1)
		{
			difference ()
			{
				intersection ()
				{
					import_stl ("bevel_gear_cluster_struts.stl");
					translate([-cluster_support_radius*2,-cluster_support_radius*2,+side_bearing_centre_z])
					cube([cluster_support_radius*4,cluster_support_radius*4,side_bearing_centre_z*3]);
				}	
				cylinder(r=5.75,h=cluster_support_radius-bearing_depth-bearing_height-bearing_clearance);
			}
		}
		else if (part==2)
		{
			difference()
			{
				intersection ()
				{
					import_stl ("bevel_gear_cluster_struts.stl");
					union ()
					{
						translate([-cluster_support_radius*2,-cluster_support_radius*2,-side_bearing_centre_z])
						cube([cluster_support_radius*4,cluster_support_radius*4,side_bearing_centre_z*2]);
						cylinder(r=5.5,h=cluster_support_radius-bearing_depth-bearing_height-bearing_clearance);	
					}
				}
				translate([0,0,-cluster_support_radius*2])
				cylinder(r=2,h=cluster_support_radius*4,$fn=20);
			}
		}
		else if (part==3)
		{
			intersection ()
			{
				import_stl ("bevel_gear_cluster_struts.stl");
				translate([-cluster_support_radius*2,-cluster_support_radius*2,-side_bearing_centre_z*3])
				cube([cluster_support_radius*4,cluster_support_radius*4,side_bearing_centre_z*2]);
			}
		}

		translate([0,0,-cluster_support_radius*2])
		cylinder(r=2,h=cluster_support_radius*4,$fn=20);

		for (j=[0:1]) rotate ([0,180*j,0])
		for (i=[0:4])
		{
			rotate([0,0,360/5*i])
			translate([-14,0,0])
			{
				translate([0,0,0])
				cylinder(r=1.625,h=3,$fn=15);
	
				translate([0,0,2.5+nut_slot_height/2+0.5])
				cylinder(r=1.625,h=40,$fn=15);
	
				translate([0,0,9])
				{
					cylinder(r=nut_head_radius,h=10,$fn=15);
					translate([-10,-nut_head_radius,0])
					cube([10,nut_head_radius*2,10]);
				}
				translate([0,0,2.5])
				{
					translate([-15/2,0,0])
					cube([15,nut_slot_width,2.2],center=true);
		
					translate([-15-5,-nut_slot_width/2,0])
					cube([15,nut_slot_width,10]);
		
					translate([0,0,-nut_slot_height/2])
					cylinder(r=nut_slot_width/2/cos(30),$fn=6,h=nut_slot_height);
				}
			}
		}
	}
}

//bevel_gear_cluster_struts ();

module bevel_gear_cluster_struts ()
{
	difference ()
	{
		intersection ()
		{
			strut(hole=false);
		
			rotate([0,-big_gear_rotate,0])
			strut();
		
			rotate([0,0,360*2/5])
			rotate([0,-big_gear_rotate,0])
			strut();
		
			rotate([0,0,360/5*0])
			rotate([0,(pitch_angle1+pitch_angle2),0])
			strut();
			rotate([0,0,360/5*1])
			rotate([0,(pitch_angle1+pitch_angle2),0])
			strut();
			rotate([0,0,360/5*2])
			rotate([0,(pitch_angle1+pitch_angle2),0])
			strut();
			rotate([0,0,360/5*3])
			rotate([0,(pitch_angle1+pitch_angle2),0])
			strut();
			rotate([0,0,360/5*4])
			rotate([0,(pitch_angle1+pitch_angle2),0])
			strut();
	
			rotate([0,180,0])
			strut(nut=false);
		
			rotate([0,0,360/10*7])
			rotate([0,180-small_gear_rotate,0])
			strut();
		
			rotate([0,0,360/10*3])
			rotate([0,180-small_gear_rotate,0])
			strut();
		
			rotate([0,0,360/10*1])
			rotate([0,180-small_gear_rotate,0])
			strut();
		}
	}
}


//strut();
module strut(hole=true)
{
	rod_r=3/16*25.4/2;
	big=50;

	difference ()
	{
		translate([0,0,big/2-cluster_support_radius])
%		cube ([big,big,big],center=true);

		if (hole)
		{
			translate([0,0,-cluster_support_radius+bearing_depth-bearing_clearance])
			cylinder ($fn=20,r=bearing_radius+bearing_clearance,h=bearing_height+bearing_clearance*2);
		
			translate([0,0,-cluster_support_radius-bearing_depth])
			cylinder ($fn=20,r=4.5,h=bearing_height+2*bearing_depth+bearing_rear_clearance);
		}
	}
}

bevel_gear_cluster_struts2 (top=false);
//translate([cluster_support_radius*2.4,0,0])
//rotate([0,0,180])
//bevel_gear_cluster_struts2 (top=false);

module bevel_gear_cluster_struts2 (top=true)
{
	bushing_hole_r=2.5/2;
	bushing_depth=7;
	rod_hole_r=3/16*25.4/2*0.9;
	equator_offset=2.5;

	rotate([0,top?0:180,0])
	intersection ()
	{
		union ()
		{
			difference ()
			{
				rotate([0,0,5])
				rotate([-90,0,0])
				rotate([0,axis_angle-90,0])
				difference ()
				{
					dodecahedron (height=2*cluster_support_radius);
					dodecahedron (height=2*(cluster_support_radius-bushing_depth));
//					import_stl("hollow_dodecahedron.stl");

					cylinder ($fn=16,r=bushing_hole_r,h=2*cluster_support_radius+2,center=true);
	
					for (side=[0:4])
					{
						rotate ([0,0,360/5*side])
						rotate([0,axis_angle,0])
						cylinder ($fn=16,r=bushing_hole_r,h=2*cluster_support_radius+2,center=true);
					}
				}	

				for (hole=[0:1])
				{
				rotate ([0,0,180*hole])
				translate([0,cluster_support_radius*0.9,0])
				{
					cylinder($fn=16,r=3/2,h=2.1*cluster_support_radius,center=true);

					translate([0,0,-equator_offset])
					for (shoulder=[0:1])
					{
						rotate([0,180*shoulder,0])
						translate([0,0,cluster_support_radius*0.3])
						cylinder($fn=16,r=7/2,h=2.1*cluster_support_radius);
					}
				}
				}

//				for (hole=[0:5])
//				{
//				rotate ([0,0,360/5*hole])
//				translate([-cluster_support_radius*0.9,0,0])
//				cylinder($fn=16,r=3/2,h=2*cluster_support_radius+2+100,center=true);
//				}
//	
//				for (hole=[0:5])
//				{
//				rotate ([0,0,360/5*hole])
//				translate([-cluster_support_radius*0.9,0,cluster_support_radius*0.4])
//				cylinder($fn=6,r=5.3/cos(30)/2,h=2*cluster_support_radius+2+100);
//				}
//
//				if (!top)
//				{
//					translate([0,0,cluster_support_radius-5])
//					cylinder($fn=6,r=7.7/cos(30)/2,h=5+1);
//				}
			}
//			translate([0,0,cluster_support_radius-bushing_depth])
//			cylinder (r=bushing_hole_r+2,h=0.5);
		}
	
		color ([1,1,0,0.25])
		translate([-50,-50,top?-equator_offset:-100-equator_offset])
		cube([100,100,100]);
	}
}

//dodecahedron();

module dodecahedron(height=10)
{
	intersection ()
	{
		cube([height*2,height*2,height],center=true);

		intersection_for (side=[0:4])
		{
			rotate([0,0,360/5*side])
			rotate([0,axis_angle,0])
			cube([height*2,height*2,height],center=true);
		}
	}
}

//strut2();
module strut2(hole=true)
{
	bushing_hole_r=4/2;
	bushing_depth=7;
	rod_hole_r=3/16*25.4/2*0.9;
	big=50;

	clearance=1.5;

	screw_head_r=6.8/2+clearance;
//	screw_head_height=3.7+clearance;
	screw_head_height=big/2-bushing_depth+1;

	difference ()
	{
		translate([0,0,big/2-cluster_support_radius])
		cube ([big,big,big],center=true);

		if (hole)
		{
			translate([0,0,-cluster_support_radius-1])
			cylinder ($fn=20,r=bushing_hole_r,h=cluster_support_radius+2);
		
			translate([0,0,-cluster_support_radius+bushing_depth-1])
			cylinder ($fn=20,r=screw_head_r,h=screw_head_height+1);
		}
		else
		{
			translate([0,0,-big])
			cylinder($fn=20,r=rod_hole_r,h=big);
		}
	}
}

handle_hub_diameter=18; 
handle_shaft_diameter=3/16*25.4;
handle_shaft_length=22;
handle_length=35;
handle_end_diameter=14.4;
handle_end_length=12;
overlap=0.1;

module handle()
{
	$fn=36;

	difference()
	{
		union ()
		{
			translate([handle_length,0,0])
			cylinder(r=handle_end_diameter/2,h=handle_end_length);
			cylinder(r=handle_hub_diameter/2,h=handle_shaft_length);
			rotate([90,0,0])
			linear_extrude (height=handle_end_diameter, convexity=2,center=true) 
			{
				polygon (points=[
				[0,0],
				[handle_length,0],
				[handle_length,handle_end_length],
				[0,handle_shaft_length]],
				paths=[[0,1,2,3,0]]);
			}
		}
		translate([0,0,2.5])
		cylinder(r=handle_shaft_diameter/2,h=handle_shaft_length);
		translate([handle_length,0,-overlap])
		cylinder(r=1.8,h=handle_end_length);

		translate ([handle_length,0,2]) 
		{
			translate ([0,0,3]) 
			cylinder(r=5+0.25,h=10,$fn=72);
			cylinder(r=5-0.75,h=6.5,$fn=72);
		}
	}
}

module knob()
{
	difference()
	{
		cylinder(r1=14/2,r2=10/2,h=22);
		translate([0,0,3])
		cylinder(r=3.5/2,h=22);
	}
}
