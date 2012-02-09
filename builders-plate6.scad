include <configuration.scad>
use <gregs-wade-v3.scad>
use <gregs-wadebits.scad>

union ()
{
	wade(hotend_mount=256,legacy_mount=false);

	translate([-30,84,15.25]) 
	rotate(180)
	rotate([0,-90,0])
	wadeidler();

	translate([28,90,0])
	WadesL();

//	translate([8,66,0])
//	WadesS();
}