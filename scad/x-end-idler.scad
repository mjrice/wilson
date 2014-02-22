// PRUSA iteration3
// X end idler
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// Alterations for reprap wilson by M. Rice <mrice411@gmail.com>

include <configuration.scad>
use <x-end.scad>

idler_offs_z = -1; // negative here means "up" when installed
idler_offs_y = 7;

module x_end_idler_base(){
 x_end_base();
}

module x_end_idler_holes(){
 x_end_holes();
 translate([0,idler_offs_y,idler_offs_z]) {
 #translate(v=[0,-22,30.25]) rotate(a=[0,-90,0]) cylinder(h = 80, r=idler_bearing_inner_d/2+.3, $fn=30);
 #translate(v=[2,-22,30.25]) rotate(a=[0,-90,0]) cylinder(h = 10, r=idler_bearing_inner_d/2 + 1, $fn=30);
 #translate(v=[-22,-22,30.25]) rotate(a=[0,-90,0]) rotate(a=[0,0,30]) cylinder(h = 80, r=idler_bearing_inner_d, $fn=6);
 }
}
 
// Final part
module x_end_idler(){
 mirror([0,1,0]) difference(){
  x_end_idler_base();
  x_end_idler_holes();
 }
}

x_end_idler();


