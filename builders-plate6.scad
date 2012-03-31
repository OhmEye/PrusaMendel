include <configuration.scad>
use <gregs-wade-v3.scad>
use <gregs-wadebits.scad>

union ()
{
	wade(hotend_mount=256);

	translate([-30,84,15.25])  // this is the translation for the 3mm version.
//	translate([-30,84,13.92])  // this is the translation for the 1.75mm version.
	rotate(180)
	rotate([0,-90,0])
	wadeidler();

	translate([28,90,0])
	WadesL();
	
	translate([50,34,0])
	bearing_washer();
}