//
// Parametric sleeve-style belt guide for 624, 623 bearings and their ilk.
// mrice

layer_height = 0.3;
hotend_width = 0.5;

wall= hotend_width*3;
clearence= hotend_width/2; 

// for 624 bearings:
bearing_d        = 13;
bearing_h        = 5;
bearing_inside_d = 4;
belt_w           = 7;

// for 623 bearings:
//bearing_d = 10;
//bearing_h = 4;
//bearing_inside_d = 3; // hole diameter of the bearing

//guide_outer_d = bearing_d + 12;
flange_h = 3*layer_height;
//flange_d = 21;

hole_for_inner = bearing_d/2+(2*clearence);
r_for_inner = hole_for_inner + (2*hotend_width);
hole_for_outer = r_for_inner+clearence;
r_for_outer = hole_for_outer + (hotend_width*2);

flange_d = 2*r_for_outer + (6*hotend_width);

module belt_guide_base(a) {
 if(a) {
    cylinder(r=r_for_outer, h=belt_w+flange_h, $fn=50);
 }
 else {
    cylinder(r=r_for_inner, h=belt_w+flange_h, $fn=50);
 }
 // outer flange
 cylinder(r=flange_d/2, h=flange_h, $fn=50);
}

module belt_guide_holes(a){
 // hole for the bearing:
 if(a) {
     #translate([0,0,flange_h+(1-a)*(belt_w-bearing_h-layer_height)]) cylinder(r=hole_for_outer, h=bearing_h+10, $fn=50);
 }
 else {
     #translate([0,0,flange_h+(1-a)*(belt_w-bearing_h-layer_height)]) cylinder(r=hole_for_inner, h=bearing_h+10, $fn=50);
 }
 // hole for the rod through:
 translate([0,0,-1]) cylinder(r=bearing_d/2-wall, h=10, $fn=50);
}

// Final part
module belt_guide(){
 difference(){
  belt_guide_base(0);
  belt_guide_holes(0);
 }
}

module belt_guide_sleeve() {
 difference(){
  belt_guide_base(1);
  belt_guide_holes(1);
 }
}

belt_guide();

translate([flange_d+5,0,0]) belt_guide_sleeve();
