//
// Parametric belt guide for 624, 623 bearings and their ilk.
// 

layer_height = 0.3;
hotend_width = 0.5;

wall= hotend_width*3;
clearence= hotend_width/2; 

// for 624 bearings:
bearing_d = 13;
bearing_h = 5;
bearing_inside_d = 4;

// for 623 bearings:
//bearing_d = 10;
//bearing_h = 4;
//bearing_inside_d = 3; // hole diameter of the bearing

guide_outer_d = 16.5;
guide_outer_h = 8.7; // total height wanted for the assembled belt guide

module belt_guide_base() {
 cylinder(r=guide_outer_d/2, h=guide_outer_h/2, $fn=50);
 // outer flange
 cylinder(r=guide_outer_d/2+(hotend_width*4), h=3*layer_height, $fn=50);
}

module belt_guide_holes(){
 // hole for the bearing:
 #translate([0,0,guide_outer_h/2 - bearing_h/2 - layer_height]) cylinder(r=bearing_d/2+clearence, h=bearing_h, $fn=50);
 // hole for the rod through:
 translate([0,0,-1]) cylinder(r=bearing_d/2-wall, h=10, $fn=50);
}

// Final part
module belt_guide(){
 difference(){
  belt_guide_base();
  belt_guide_holes();
 }
}

belt_guide();


