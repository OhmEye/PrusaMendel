include <configuration.scad>
use <x-end-motor.scad>
use <x-end-idler.scad>
use <gregs-new-x-carriage.scad>


xendmotor(endstop_mount=true,curved_sides=true,closed_end=true,luu_version=true);

translate([0,47,0]) 
rotate(180)
xendidler(endstop_mount=false,curved_sides=true,closed_end=false,luu_version=true);
