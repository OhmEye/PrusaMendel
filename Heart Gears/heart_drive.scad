// © 2010 by Greg Frost

use <parametric_involute_gear_v5.0.scad>

drive_gear_angle1=69.075;

drive_gear1_teeth=15;
drive_gear2_teeth=7;
drive_gear3_teeth=10;
drive_gear_axis_angle = 180-drive_gear_angle1;
drive_gear_outside_circular_pitch=900;
drive_gear_outside_pitch_radius1 = drive_gear1_teeth * drive_gear_outside_circular_pitch / 360;
drive_gear_outside_pitch_radius2 = drive_gear2_teeth * drive_gear_outside_circular_pitch / 360;
drive_gear_outside_pitch_radius3 = drive_gear3_teeth * drive_gear_outside_circular_pitch / 360;
drive_gear_pitch_apex1=drive_gear_outside_pitch_radius2 * sin (drive_gear_axis_angle) + 
	(drive_gear_outside_pitch_radius2 * cos (drive_gear_axis_angle) + drive_gear_outside_pitch_radius1) / tan (drive_gear_axis_angle);
drive_gear_cone_distance=sqrt(pow(drive_gear_pitch_apex1, 2) + pow(drive_gear_outside_pitch_radius1, 2));
drive_gear_pitch_apex2=sqrt(pow(drive_gear_cone_distance, 2) - pow(drive_gear_outside_pitch_radius2, 2));
drive_gear_pitch_apex3=sqrt(pow(drive_gear_cone_distance, 2) - pow(drive_gear_outside_pitch_radius3, 2));
echo("drive_gear_cone_distance",drive_gear_cone_distance);
drive_gear_pitch_angle1 = asin (drive_gear_outside_pitch_radius1/drive_gear_cone_distance);
drive_gear_pitch_angle2 = asin (drive_gear_outside_pitch_radius2/drive_gear_cone_distance);
drive_gear_pitch_angle3 = asin (drive_gear_outside_pitch_radius3/drive_gear_cone_distance);
echo ("drive_gear_pitch_angle1,2,3 ",drive_gear_pitch_angle1,drive_gear_pitch_angle2,drive_gear_pitch_angle3);
echo ("drive_gear_pitch_angle1+2",drive_gear_pitch_angle1+drive_gear_pitch_angle2);
echo ("drive_gear_pitch_angle1+2*2+3", drive_gear_pitch_angle1+drive_gear_pitch_angle2*2+drive_gear_pitch_angle3);

drive_gear3_thickness=12;
drive_gear_face_width=drive_gear3_thickness/cos(drive_gear_pitch_angle3);
drive_gear2_thickness=drive_gear_face_width*cos(drive_gear_pitch_angle2);
drive_gear1_thickness=3.5;

drive_gear_bore_diameter=3/16*25.4;

//3/16th nylock
nut_height=4.5;
nut_radius=4.5;

bearing_radius=5;
bearing_height=4;

trim_angle=drive_gear_pitch_angle2+drive_gear_pitch_angle3;
trim_apex=drive_gear_pitch_apex2/cos(trim_angle);
trim_radius=trim_apex/tan(trim_angle);

gear2_trim_angle=90-drive_gear_pitch_angle3-drive_gear_pitch_angle2;
gear2_trim_apex=drive_gear_pitch_apex3/sin(gear2_trim_angle);
gear2_trim_radius=gear2_trim_apex*tan(gear2_trim_angle);

wall_sphere_inner=42;
wall_sphere_thickness=4;
wall_sphere_outer=wall_sphere_inner+wall_sphere_thickness;
wall_base_angle=12.5;
wall_cone_height=drive_gear_pitch_apex3+2+wall_sphere_thickness;

crossmount_x=24;
crossmount_y=80;
crossmount_z=16.2;
crossmount_z_displacement=-4.5;
crossmount_cutout_thickness=6;
crossmount_end_thickness=crossmount_z;
crossmount_clearance=0.3;
crossmount_hole_offset=crossmount_y/2-5;
support_width=crossmount_x+20;
base_thickness=4;
wall_descent=24;
wall_ascent=wall_sphere_outer*sin(wall_base_angle);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//shaft_hardware();

//drive_gears();
//color([0.4,0.4,1,0.7]) import_stl("heart_drive.stl");

//rotate([0,180,0])
//crossmount();
//import_stl("crossmount.stl");

walls ();
//import_stl("walls.stl");

//wall_outer();
//wall_inner();
//base_edge_blocks();
//base_support_blocks();

module walls()
{
	rotate([0,180,0])
	difference ()
	{
		union ()
		{
			difference()
			{
				wall_outer();
				wall_inner();
			}
		
			intersection ()
			{
				wall_outer();
				union ()
				{
					base_edge_blocks();
					base_support_blocks();
				}
			}
		}
		crossmount_slot();
		shaft_hardware();
	}
}

module crossmount_slot()
{
	translate([-crossmount_x/2-crossmount_clearance,
		-crossmount_y/2-crossmount_clearance,
		-50+crossmount_z+crossmount_z_displacement])
	cube([crossmount_x+2*crossmount_clearance,
		crossmount_y+2*crossmount_clearance,50]);
}

module base_support_blocks()
{
	for (x=[0:1]) 
	rotate([0,0,180*x])
	difference ()
	{
		translate([-support_width/2,crossmount_y/2-10,crossmount_z+crossmount_z_displacement-5])
		cube([support_width,30,35]);
		translate([0,crossmount_hole_offset,crossmount_z+crossmount_z_displacement-12])
		cylinder (r=2,h=24,$fn=8);

		translate([0,crossmount_hole_offset+3.5-25/2,crossmount_z+crossmount_z_displacement-12+5+12.5])
		cube([5.7,25,2.7],center=true);
	}
}

module base_edge_blocks()
{
	for (x=[0:3]) 
	rotate([0,0,90*x])
	difference ()
	{
		translate([-crossmount_x/2-crossmount_clearance,crossmount_y/2+crossmount_clearance-1,-wall_descent+base_thickness+0.5])
		cube([crossmount_x+2*crossmount_clearance,
			20,
			35]);
		translate([0,crossmount_y/2+3.5,-wall_descent-5])
		cylinder (r=2,h=24,$fn=8);

		translate([0,crossmount_y/2+3.5+3.5-25/2,-wall_descent+12.5])
		cube([5.7,25,2.7],center=true);
	}
}

module wall_inner ()
{
	$fn=72;
	cylinder_overlap=1.8;
	difference ()
	{
		sphere(r=wall_sphere_inner);
		translate([0,0,wall_cone_height-wall_sphere_thickness])
		cylinder(r=wall_sphere_inner,h=wall_sphere_inner);
	}

	translate([0,0,-cylinder_overlap*wall_descent])
	cylinder(
		r1=wall_sphere_inner*cos(wall_base_angle)+
			(wall_sphere_inner*sin(wall_base_angle)+cylinder_overlap*wall_descent)*tan(wall_base_angle),
		r2=wall_sphere_inner*cos(wall_base_angle),
		h=wall_sphere_inner*sin(wall_base_angle)+cylinder_overlap*wall_descent);
}

module wall_outer()
{
	$fn=72;
	difference()
	{
		union ()
		{
			sphere(r=wall_sphere_outer);
			translate([0,0,-wall_descent])
			cylinder(
				r1=wall_ascent/tan(wall_base_angle)+
					(wall_ascent+wall_descent)*tan(wall_base_angle),
				r2=wall_ascent/tan(wall_base_angle),
				h=wall_ascent+wall_descent);
		}
		translate([0,0,-100-wall_descent])
		cube([200,200,200],center=true);

		translate([0,0,100+wall_cone_height])
		cube([200,200,200],center=true);
	}
}

module crossmount ()
{
	difference ()
	{
		translate([-crossmount_x/2,-crossmount_y/2,crossmount_z_displacement])
		cube([crossmount_x,crossmount_y,crossmount_z]);
		
		translate([0,0,
			-crossmount_z+crossmount_z_displacement+crossmount_cutout_thickness])
		difference ()
		{
			cylinder (r=crossmount_y*1.2,h=crossmount_z);
			cylinder (r=15,h=crossmount_z);
		}

		translate([0,crossmount_hole_offset,0])
		cylinder (r=2,h=crossmount_z);

		translate([0,-crossmount_hole_offset,0])
		cylinder (r=2,h=crossmount_z);

		shaft_hardware();
	}
}

module shaft_hardware ()
{
	//Main Shaft:
	
	translate([0,0,-22])
	cylinder (r=3/16*25.4/2,h=80,$fn=36);
	
	translate([0,0,drive_gear_pitch_apex3])
	cylinder (r=5,h=30,$fn=36);

	translate([0,0,-17.6])
	nut();	
	translate([0,0,-17.6+0.2+nut_height+drive_gear1_thickness])
	nut();
	
	translate([0,0,drive_gear_pitch_apex3-drive_gear3_thickness-nut_height])
	nut();
	
	//Drive Shaft:

	rotate([0,drive_gear_angle1,0])
	{
		translate([0,0,6])
		cylinder (r=3/16*25.4/2,h=50,$fn=36);

		translate([0,0,drive_gear_pitch_apex2-drive_gear2_thickness-nut_height])
		nut();
		
		translate([0,0,drive_gear_pitch_apex2])
		nut();
	}
}

module bearing()
{
	cylinder(r=bearing_radius,h=bearing_height,$fn=72);
}

module nut()
{
	cylinder(r=nut_radius,$fn=6,h=nut_height);
}

module drive_gears ()
{

//hack for printing	gear 3:	rotate([0,180,0])

	intersection ()
	{
		union ()
		{
			translate([0,0,-drive_gear_pitch_apex1])
			bevel_gear(
				number_of_teeth=drive_gear1_teeth,
				cone_distance=drive_gear_cone_distance,
				pressure_angle=22.5,
				outside_circular_pitch=drive_gear_outside_circular_pitch,
				backlash=0.5,
				gear_thickness=drive_gear1_thickness,
				face_width=drive_gear_face_width,
				bore_diameter=drive_gear_bore_diameter);

			difference ()
			{
				mirror ([0,0,1])
				rotate([0,0,360/drive_gear3_teeth/2])
				translate([0,0,-drive_gear_pitch_apex3])
				bevel_gear(
					number_of_teeth=drive_gear3_teeth,
					cone_distance=drive_gear_cone_distance,
					pressure_angle=22.5,
					outside_circular_pitch=drive_gear_outside_circular_pitch,
					backlash=0.5,
					face_width=drive_gear_face_width,
					bore_diameter=drive_gear_bore_diameter);

				translate ([0,0,drive_gear_pitch_apex3-drive_gear3_thickness-0.1]) 
				{
					cylinder(r=bearing_radius+0.25,h=bearing_height+1,$fn=72);
				}

				translate ([0,0,drive_gear_pitch_apex3-drive_gear3_thickness-0.1]) 
				{
					cylinder(r=bearing_radius-0.75,h=nut_height+2,$fn=72);
				}

				translate ([0,0,drive_gear_pitch_apex3-3]) 
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

		translate([0,0,-trim_apex])
		cylinder(r1=trim_radius*2,r2=0,h=trim_apex*2);
	}

//hack for printing:	rotate([0,(drive_gear_pitch_angle1+drive_gear_pitch_angle2),0])

	intersection ()
	{
		rotate([0,-(drive_gear_pitch_angle1+drive_gear_pitch_angle2),0])
		translate([0,0,-drive_gear_pitch_apex2])
		bevel_gear(
			number_of_teeth=drive_gear2_teeth,
			cone_distance=drive_gear_cone_distance,
			pressure_angle=22.5,
			outside_circular_pitch=drive_gear_outside_circular_pitch,
			backlash=0.5,	
			face_width=drive_gear_face_width,
			bore_diameter=drive_gear_bore_diameter);

		rotate([0,drive_gear_angle1,0])
		cylinder(r1=gear2_trim_radius,r2=0,h=gear2_trim_apex);
	}
}
