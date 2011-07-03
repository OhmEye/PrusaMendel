include <configuration.scad>
use <bar-clamp.scad>
use <frame-vertex.scad>

translate([0,55,0])
%square([180,180],center=true);

rotate(90)
{
//	translate([-30,-35,0]) 
//	barclamp();
	
	translate([55,5,0]) 
	rotate(180)
	vertex(true);
	
	translate([0,0,0]) 
	vertex(true);
	
	translate([-60,7,0]) 
	rotate(60+90+180)
	vertex(false);
}
translate([0,87,0])
rotate(90)
{
//	translate([-30,-35,0]) 
//	barclamp();
	
	translate([55,5,0]) 
	rotate(180)
	vertex(true);
	
	translate([0,0,0]) 
	vertex(true);
	
	translate([-60,7,0]) 
	rotate(60+90+180)
	vertex(false);
}