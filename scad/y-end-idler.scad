//
// Parametric single-piece y ends for Reprap Wilson
// GNU GPL v3
// by Martin Rice <mrice411@gmail.com>
//
include <configuration.scad>

washer_recess     = 2; // recesses the washer into the end.
idler_offset_y    = 6;
base_thickness    = 3;

yend_idler();

module yend_idler()
{
  difference() {
    union() {
    // thin base under the end (optional)
    bigbase();
    brace();

    // first corner
    endpost();

    // second corner
    translate([193.5,0,0]) scale([-1,1,1]) endpost();

    // idler mount
    translate([193.5/2+23.8/2,19.1 - idler_offset_y,0]) 
        rotate([0,0,180]) 
          translate([-72.5,-106.7,0]) 
             rotate([0,0,0.7]) import("i3rsubidler2_fixed.stl");
    }

     translate([-1,-23/2,-1]) rotate([0,0,45]) cube([10,10,50]);
     translate([194.5,-23/2,-1]) rotate([0,0,45]) cube([10,10,50]);

  }
}

module endpost()
{
     difference() {
       union() {
         difference() {
           cube([23,16,height_of_post]);
           translate([23/2,7,height_of_post]) rotate([-90,0,0]) cylinder(r=smooth_rod_d/2+2+tie_wrap_t,h=tie_wrap_w);
         }

         difference() {
         translate([23/2,7,height_of_smooth]) rotate([-90,0,0]) cylinder(r=smooth_rod_d/2+2,h=tie_wrap_w);
         translate([0,0,height_of_post]) cube([23,16,10]);
         }
       }

       #translate([23/2,-10,height_of_threaded ]) rotate([-90,0,0]) cylinder(r=threaded_rod_d/2+.4,h=380);
       #translate([23/2,-.1,height_of_threaded ]) rotate([-90,0,0]) cylinder(r=washer_d/2+.4,h=washer_recess);
       #translate([23/2,2.5,height_of_smooth]) rotate([-90,0,0]) cylinder(r=smooth_rod_d/2+.1,h=380);
     }

}

module endpostneuvo()
{
endpost_depth = 16;

tie_wrap_extragap = 7; // this moves the slots for the tie wrap out to the 
                       // edge of the post so that the head of the tiewrap 
                       // can be moved out of the way of the print bed.

     difference() {
       union() {
         difference() {
           cube([23,endpost_depth,47]);
           translate([23/2,7,45]) rotate([-90,0,0]) cylinder(r=smooth_rod_d/2+tie_wrap_extragap+tie_wrap_t,h=tie_wrap_w);
         }

         difference() {
         translate([23/2,7,45]) rotate([-90,0,0]) cylinder(r=smooth_rod_d/2+tie_wrap_extragap,h=tie_wrap_w);
         translate([0,0,47]) cube([23,endpost_depth,10]);
         }
       }

       #translate([23/2,-10,20]) rotate([-90,0,0]) cylinder(r=threaded_rod_d/2+.4,h=380);
       #translate([23/2,-.1,20]) rotate([-90,0,0]) cylinder(r=washer_d/2+.4,h=washer_recess);
       #translate([23/2,endpost_depth-washer_recess+.01,20]) rotate([-90,0,0]) cylinder(r=washer_d/2+.4,h=washer_recess);
       #translate([23/2,2.5,45]) rotate([-90,0,0]) cylinder(r=smooth_rod_d/2+.1,h=380);
     }

}

module bigbase()
{
   difference() {
    intersection() {
       cube([193.5,55,base_thickness]);
       translate([193.5/2,-182,-1]) cylinder(r=220,h=base_thickness+2,$fn=150);
       }  
    #translate([193.5/2,0,0]) cylinder(r=10,h=10);
}
}

module brace() {
    difference() {  translate([193.5/2,-373.2+5,0]) cylinder(r=386,h=32.6,$fn=200);
                    translate([193.5/2,-211.9+5,-2]) cylinder(r=223,h=50,$fn=200);
                    #translate([-320,3,-2]) rotate([0,0,270]) cube([900,900,50]);
                    translate([-20,-1,-1]) cube([43,16,47]);
                    translate([193.5-22.9,-1,-1]) scale([1,1,1]) cube([43,16,47]);
                    #translate([192.5/2-23/2+5.9,0,14.5]) cube([11.96,40,20]);

}
}





