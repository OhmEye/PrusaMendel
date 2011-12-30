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
[0.5,0.5,1]			// 11 khaki
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

gear_support_gap=2;

//===========================================================

// first create heart.stl.
//translate ([0,0,15])
//heart (width=heart_width);

gear_num=0; // 0 for all gears.
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

//gear_lineup();

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
	difference()
	{
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
		
		rotate([180,0,0])
		translate([-150,-150,-1])
		cube([300,300,cluster_support_radius+gear_support_gap+1]);
	}	
}

module intersected_gears (use_stl=false)
{
	intersection ()
	{
		rotate ([0,0,280])
		rotate ([0,180,0])
		bevel_gear_cluster (use_stl=use_stl);
		translate([0,0,-38])
		scale([2,2.2,2])
		import_stl("heart2.stl");
*		import_stl("heart.stl");
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

module gear_lineup ()
{
	translate([0,0,0])
	import_stl("gear1.stl");
	translate([100,0,0])
	import_stl("gear2.stl");
	translate([200,0,0])
	import_stl("gear3.stl");
	translate([300,0,0])
	import_stl("gear4.stl");
	translate([400,0,0])
	import_stl("gear5.stl");
	translate([500,0,0])
	import_stl("gear6.stl");
	translate([600,0,0])
	import_stl("gear7.stl");
	translate([700,0,0])
	import_stl("gear8.stl");
	translate([800,0,0])
	{
	import_stl("gear9.stl");
	cylinder(r=20,h=120);
	}
	translate([900,0,0])
	import_stl("gear10.stl");
	translate([1000,0,0])
	import_stl("gear11.stl");
	translate([1100,0,0])
	import_stl("gear12.stl");
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
bushing_hole_r=3.4/2;
bushing_depth=8;
rod_hole_r=3/16*25.4/2*0.9;
equator_offset=2.7;

m3_nut_diameter=5.6/cos(30);
m3_nut_depth=2;
m3_head_diameter=5.8;

washer_d=7;
washer_thickness=0.4;

bevel_gear_cluster_struts2 (top=true);
translate([cluster_support_radius*2.4,0,0])
rotate([0,0,180])
bevel_gear_cluster_struts2 (top=false);

module bevel_gear_cluster_struts2 (top=false)
{
	translate([0,0,top?equator_offset:-equator_offset])
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
//					hollow_dodecahedron();
					import_stl("hollow_dodecahedron.stl");
					cylinder ($fn=16,r=bushing_hole_r,h=2*cluster_support_radius+2,center=true);
					for(i=[0:1])
					rotate([180*i,0,0])
					translate([0,0,cluster_support_radius-bushing_depth+m3_nut_depth])
					rotate([180,0,0])
					cylinder ($fn=6,r=m3_nut_diameter/2,h=m3_nut_depth+0.5);

					for(i=[0:1])
					rotate([180*i,0,0])
					translate([0,0,cluster_support_radius-washer_thickness])
					cylinder ($fn=32,r=washer_d/2,h=washer_thickness+0.5);
	
					for (side=[0:4])
					{
						rotate ([0,0,360/5*side])
						rotate([0,axis_angle,0])
						{
						cylinder ($fn=16,r=bushing_hole_r,h=2*cluster_support_radius+2,center=true);

						for(i=[0:1])
						rotate([180*i,0,0])
						translate([0,0,cluster_support_radius-bushing_depth+m3_nut_depth])
						rotate([180,0,0])
						cylinder ($fn=6,r=m3_nut_diameter/2,h=m3_nut_depth+0.5);

						for(i=[0:1])
						rotate([180*i,0,0])
						translate([0,0,cluster_support_radius-washer_thickness])
						cylinder ($fn=32,r=washer_d/2,h=washer_thickness+0.5);
						}
					}
				}	

				for (hole=[0:1])
				{
				rotate ([0,0,180*hole])
				translate([0,cluster_support_radius*0.9,0])
				{
					cylinder($fn=16,r=3.4/2,h=2.1*cluster_support_radius,center=true);

					translate([0,0,-equator_offset])
					{
						rotate([0,180,0])
						translate([0,0,3])
						rotate(180/6)
						cylinder($fn=6,r=m3_nut_diameter/2,h=cluster_support_radius);
						translate([0,0,3])
						cylinder($fn=16,r=m3_head_diameter/2,h=cluster_support_radius);
					}
				}
				}

			}
		}
	
		color ([1,1,0,0.25])
		translate([-50,-50,top?-equator_offset:-100-equator_offset])
		cube([100,100,100]);
	}
}

//hollow_dodecahedron();

//intersection()
//{
////	hollow_dodecahedron();
//	import_stl("hollow_dodecahedron.stl");
//	cube([1,1,1]*cluster_support_radius*4);
//}

module hollow_dodecahedron()
{
	difference ()
	{
		dodecahedron (height=2*cluster_support_radius);
		dodecahedron (height=2*(cluster_support_radius-bushing_depth));
		cylinder(r=0.2,h=3*cluster_support_radius);
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
