
bearing_624_double = [13, 10, 4, 0];
// this one has roughly same diameter as pulley, makes belt parallel so its prettier
bearing_623_double = [10, 8, 3, 0];

idler_bearing              = bearing_624_double;
m4_diameter                = 4.7;
m4_nut_diameter            = 7.6;
m4_nut_diameter_horizontal = 8.15;

width_over_thickness = 2.2;
layer_height = 0.25;
single_wall_width = width_over_thickness * layer_height;
idler_width = (idler_bearing[1] > 7 ? idler_bearing[1] : 7) + 2.5 * idler_bearing[3] ;
use_fillets = 1;

tensioner();

module tensioner()
{
   difference() {
     union() {
            translate([0,-5,0]) cube([30,10,16]);
            translate([30,-10,0]) cube([20,20,16]);
            translate([30,5,0]) cylinder(r=5,h=16,$fn=16);
            translate([30,-5,0]) cylinder(r=5,h=16,$fn=16);
     }

     #translate([43,11/2,8]) rotate([90,0,0]) {
        cylinder(r=13,h=11);
        translate([0,0,-6]) cylinder(r=2.1,h=25);
      }

     #translate([9,-7,-5/2+8]) cube([15,16,5]);
     #translate([3,-4,-7.3/2+8]) cube([4,16,7.3]);
     #translate([-1,0,16/2]) rotate([0,90,0]) cylinder(r=2,h=20,$fn=16);
   }
}
