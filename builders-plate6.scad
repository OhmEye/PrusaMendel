include <configuration.scad>
use <gregs-wade-v3.scad>
use <gregs-wadebits.scad>


union ()
{
	wade(hotend_mount=2);

	translate([-5,40,15.25]) 
	rotate([0,-90,0])
	wadeidler();

	translate([40,95,0])
	WadesL();

	translate([8,66,0])
	WadesS();
}