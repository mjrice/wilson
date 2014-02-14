
// Y belt holder
// GNU GPL v3
// Josef Průša <josefprusa@me.com>
// Václav 'ax' Hůla <axtheb@gmail.com>
// Alterations for reprap Wilson by Martin Rice <mrice411@gmail.com>
// (this is exactly like the box-frame Y belt holder)

include <configuration.scad>
include <functions.scad>

use_fillets = 1;
extratallness = 0;

module y_belt_holder(len=40) {
    y_delta = -2.5;
    ybelt_hole_to_side = 5;
    real_len = len + 2 * ybelt_hole_to_side;
    screw_hole_z_offset = 0;
    
    difference(){
        union(){

            translate([-21 - belt_thickness, -7, 0]) cube_fillet([13 + y_delta, 14, len], vertical=[3,0,0,0], fn=8 );
            translate([-14, -5.5, len / 2])          cube_fillet([24 + 2 * y_delta, 3, len], vertical=[3, 0, 0, 0], center = true);
            translate([-24.5-extratallness/2, 0, real_len / 2])      cube_fillet([11.5+extratallness, 16+3, real_len], center = true, vertical = [1, 1, 1, 1], $fn=16);
            translate([-4.0 + y_delta, 0, len / 2])  cube_fillet([8, 14, len], center = true, vertical = [2,2,0,2]);

        }
        translate([-4.5 + y_delta, 0, real_len / 2]) cube([10, 10, 10], center = true);
        translate([-11, 0, ybelt_hole_to_side + len]) {
            translate([screw_hole_z_offset,0,0]) rotate([0, -90, 0]) plate_screw(20);
            translate([8 + y_delta, 0, 0]) cube([10, 9, 9], center=true);
        }
        translate([-11, 0, ybelt_hole_to_side]) {
            translate([screw_hole_z_offset,0,0]) rotate([0, -90, 0]) plate_screw(20);
            translate([8 + y_delta, 0, 0]) cube([10, 9, 9], center=true);
        }

        translate([-8 + y_delta, 0, 0]) mirror([1, 0, 0]) belt(real_len);
    }
}


y_belt_holder();
