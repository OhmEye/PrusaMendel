//for (i=[0:3])
//translate([i*46,0,0])
//import_stl("Bgear1.stl");
//
//translate([-28,0,0])
color([0,0,1])
translate([-105.95-12.5/2,-80+13.33,-29.2])
import_stl("bender_all.stl");


//cube([4,4,45]);


//cylinder(r1=20,r2=25,h=40,$fn=100);

translate([-12.5/2,0,0])
leg();

translate([12.5/2,0,0])
leg();

*body();

module leg()
{
	render()
	intersection()
	{
	sphere (r=6.1,$fn=30);
	translate([0,2.75,0])
	cube([13,5.5,13],center=true);
	}
	
	rotate([-90,0,0])
	cylinder(r=1.5,h=33,$fn=10);
	
	for(i=[0:5])
	{
	translate([0,i*4.6+6,0])
	rotate([-90,0,0])
	cylinder(r=2,h=4,$fn=20);
	}
}



module body()
{
shoulder=10;
seam=0.8;

	translate([0,33,0])
	rotate([-90,0,0])
	cylinder(r1=9.9-seam,r2=13.23-seam,h=26.5,$fn=40);

	difference()
	{
	translate([0,33,0])
	rotate([-90,0,0])
	cylinder(r1=9.9,r2=13.23,h=26.5,$fn=40);

	translate([-7,36.5,0])
	{
	difference()
	{
	union()
	{
	multmatrix([[1,-0.15,0],[0,1,0],[0,0,1]])
	cube([14,19.5,15]);
	multmatrix([[1,0.15,0],[0,1,0],[0,0,1]])
	cube([14,19.5,15]);
	}
	
	translate([seam,seam,0])
	{
	multmatrix([[1,-0.15,0],[0,1,0],[0,0,1]])
	cube([14-2*seam,19.5-2*seam,16]);
	multmatrix([[1,0.15,0],[0,1,0],[0,0,1]])
	cube([14-2*seam,19.5-2*seam,16]);
	}
	}
	}
	}

	translate([0,33+26.5,0])
	rotate([-90,0,0])
	rotate_extrude()
	union()
	{
		color([1,0,0])
		square([shoulder*0.5,shoulder*0.85*0.73]);
		translate([13.23-shoulder,0,0])
		scale([1,0.73])
		render()
		intersection()
		{
		square([shoulder*2,shoulder*0.85]);
		circle(r=shoulder,$fn=40);
		}
	}

	translate([6.05,47.2,10.0])
	sphere(r=1.16,$fn=30);
}

translate([-10.7,54.7,0])
difference()
{sphere(r=5.25,$fn=30);
translate([-9.7,0,0])
rotate(10)
cube([10,10,10],true);
}


translate([0.9,51.2,16.2])
rotate([105,0,-65])
{
cylinder(r=2,h=3.3,$fn=30);
cylinder(r=1.5,h=5,$fn=30);
}

translate([4.4,52.7,15.5])
rotate(23)
rotate([0,-81,0])
{
cylinder(r=2,h=3.3,$fn=30);
cylinder(r=1.5,h=5,$fn=30);
}

translate([-2.8,49.4,15])
rotate(21)
rotate([0,-122,0])
{
cylinder(r=2,h=3.3,$fn=30);
cylinder(r=1.5,h=5,$fn=30);
}

translate([-6.2,48.3,12.7])
rotate(-8)
rotate([0,-128,0])
{
cylinder(r=2,h=3.3,$fn=30);
cylinder(r=1.5,h=5,$fn=30);
}


translate([-7.2,48.3,12.7])
rotate(-8)
rotate([0,-128,0])
{
cylinder(r=2,h=3.3,$fn=30);
cylinder(r=1.5,h=5,$fn=30);
}
