// PRUSA iteration3
// Y belt holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

// Adapted for Wilson TS by mrice

belt_spacing = 2.0; // gt2=2mm
tooth_w      = 1; 
min_h = 8; // belt starts this far from bottom of bed
max_h = 22; // belt can be up to this far from bottom of bed
nut_trap_w = 6;

module belt_holder_base(){
 translate([-33-8.5,0,0]) cube([33,15,max_h]); // this is the part the belt is cut into
 translate([-33-9.5,12,0]) cube([35,15,12]); 
}

module belt_holder_beltcut(){
 position_tweak=.5;
 // Belt slit
 translate([-66,-0.5+10,0]) cube([67,1,15]);
 // Smooth insert cutout
 translate([-66,-0.5+10,12]) rotate([45,0,0]) cube([67,15,15]);
 // Individual teeth
 for ( i = [0 : 23] ){
  translate([0-(i*belt_spacing)+position_tweak,-0.5+8,0]) cube([tooth_w,3,15]);
 }
 // Middle opening
 translate([-2-25,-1,0]) cube([4,11,15]);	
}

module belt_holder_holes(){
  translate([0,19,-2]) { 
    translate([-14.5,0,0]) {
          cylinder(h=30, r=1.8, $fn=10);
          translate([0,0,10]) cylinder(h=30, r=nut_trap_w/2+.5, $fn=6);
    }
    translate([-35.5,0,0]) {
          cylinder(h=30, r=1.8, $fn=10);
          translate([0,0,10]) cylinder(h=30, r=nut_trap_w/2+.5, $fn=6);
    }
  }
}

// Final part
module belt_holder(){
 difference(){
  belt_holder_base();
  translate([0,0,min_h]) belt_holder_beltcut();
  belt_holder_holes();
 }
}

belt_holder();