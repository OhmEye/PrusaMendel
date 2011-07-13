heart();

module heart (
	width=20,
	resolution = 24)
{
	bulb=1.2;
	squash = 0.65;
	stretch = 1.2;

	$fn=resolution*2;
	
	scale ([1,squash,stretch]*width/2)

	union()
	{
		rotate ([0,90,0])
		union()
		{
			for (x=[0:resolution-1])
			assign(r1=abs((x/resolution)*(x/resolution)-1),
				   r2=abs(((x+1)/resolution)*((x+1)/resolution)-1))
			{
				translate([x/resolution,0,0])
				rotate([0,90,0])
				cylinder (
					r1=r1,
					r2=r2,
					h=1/resolution);
			}
	
		}

		difference ()
		{
			union ()
			{
				scale ([1,1,sqrt(pow(bulb/2,2)-pow(1-bulb/2,2))-0.04])
				sphere (r=1);

				translate([bulb/2-1,0,-0.04])
				rotate ([0,45,0])
				translate([1-bulb/2,0,0])
				rotate_extrude (convexity=10)
				translate([1-bulb/2,0,0])
				circle (r=bulb/2);

				translate([1-bulb/2,0,-0.04])
				rotate ([0,-45,0])
				translate([bulb/2-1,0,0])
				rotate_extrude (convexity=10)
				translate([1-bulb/2,0,0])
				circle (r=bulb/2);

			}

			translate([-1,-1,-2.00-0.0001])
			#cube ([2,2,2]);
		}
	}
}