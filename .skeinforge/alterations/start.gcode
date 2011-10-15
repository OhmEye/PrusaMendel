G21 ;metric is good!
G90 ;absolute positioning
M104 S185 ; Set Extruder temp
M140 S72 ; Set Bed temp
G92 Z0 ; Zero the Z Position.
G1 Z3 F120 ;move up a tad.
G28 X; Home X
G92 X0 ; Zero the Y Position.
G28 Y; Home Y
G92 Y0 ; Zero the Y Position.
G1 Y190 F5000; Move the bed to the front for last minute cleaning
G28 Z; Home Z
G92 Z0 ; Zero the Z Position.
G1 Z0.2 F120; Move up so the nozzle can be wiped if necessary
M107 ; Turn the fan off while we get the extruder to temp.
M109 S185 ; Go to temp and wait till it gets there.
G92 E0 ;zero the extruded length
M106 S255 ; fan on full speed.
