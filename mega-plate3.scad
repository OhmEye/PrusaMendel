include <configuration.scad>

use <gregs-new-coupling.scad> 
use <gregs-wadebits.scad>
use <pulley.scad>

translate([-5,0,0])
WadesS();

for (i=[0:1])
translate([30*i,25,0])
coupling(); 

for (i=[0:1])
translate([21*i+15,0,0])
pulley();
