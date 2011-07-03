include <configuration.scad>
use <x-end-motor.scad>
use <x-end-idler.scad>
use <gregs-x-carriage.scad>


union ()
{
	xendmotor(endstop_mount=true,curved_sides=true,closed_end=true);
	
	translate([-10,33,0]) 
	rotate(180)
	xendidler(endstop_mount=false,curved_sides=true,closed_end=false);
}