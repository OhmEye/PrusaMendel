handle_hub_diameter=18;
handle_shaft_diameter=3/16*25.4;
handle_shaft_length=22;

handle_length=35;

handle_end_diameter=14.4;
handle_end_length=12;

overlap=0.1;

$fn=36;


handle();
//knob();

module handle()
{
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
