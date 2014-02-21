//
// Parametric single-piece y ends for Reprap Wilson
// GNU GPL v3
// by Martin Rice <mrice411@gmail.com>
//
include <configuration.scad>

washer_recess     = 2; // recesses the washer into the end.
idler_offset_y    = 6;
base_thickness    = 3;
tie_wrap_extra = 1;
belt_h = 29;
idler_w = 10; // the gap provided for the bearing holder
idler_wall_t = 5;
idler_bearing_inside_d = 3;
end_w = 193.5;

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
      translate([end_w,0,0]) scale([-1,1,1]) endpost();

      // idler mount
      translate([end_w/2,0,0]) idler_post(); 
    }

     // bevels on outer corners
     translate([-1,-23/2,-1])    rotate([0,0,45]) cube([10,10,50]);
     translate([end_w+1,-23/2,-1]) rotate([0,0,45]) cube([10,10,50]);

     // cutout for idler
     #translate([end_w/2,0,0]) translate([-idler_wall_t,10,belt_h]) rotate([0,90,0]) cylinder(r=10+4,h=idler_w);

     // slots for attaching end to table surface if desired
     #translate([end_w/2-end_w/4,20,0]) cube(size=[4,10,10],center=true);
     #translate([end_w/2+end_w/4,20,0]) cube(size=[4,10,10],center=true);
  }
}


module idler_post()
{
    difference() {
         union() {
             translate([idler_w/2,0,0]) {
                   cube(size=[idler_wall_t,20,belt_h]);
                   translate([0,10,belt_h]) rotate([0,90,0]) cylinder(r=10,h=idler_wall_t);
             }
             translate([-idler_w/2-idler_wall_t,0,0]) {
                   cube(size=[idler_wall_t,20,belt_h]);
                   translate([0,10,belt_h]) rotate([0,90,0]) cylinder(r=10,h=idler_wall_t);
             }
             translate([-idler_w,0,0]) cube(size=[idler_wall_t * 2 + idler_w,20,belt_h/2]);
         } 
         // holes for idler bolt
         #translate([-12,10,belt_h]) rotate([0,90,0]) cylinder(r=idler_bearing_inside_d/2+.5,h=25);
         
    }
}

module endpost()
{
     difference() {
       union() {
         difference() {
           cube([23,16,height_of_post]);
           #translate([23/2,7,height_of_post]) rotate([-90,0,0]) cylinder(r=smooth_rod_d/2+2+tie_wrap_t+tie_wrap_extra,h=tie_wrap_w);
         }

         difference() {
         translate([23/2,7,height_of_post]) rotate([-90,0,0]) cylinder(r=smooth_rod_d/2+2+tie_wrap_extra,h=tie_wrap_w);
         translate([0,0,height_of_post]) cube([23,16,10]);
         }
       }

       translate([23/2,-10,height_of_threaded ]) rotate([-90,0,0]) cylinder(r=threaded_rod_d/2+.4,h=380);
       translate([23/2,-.1,height_of_threaded ]) rotate([-90,0,0]) cylinder(r=washer_d/2+.4,h=washer_recess);
       translate([23/2,2.5,height_of_smooth]) rotate([-90,0,0]) cylinder(r=smooth_rod_d/2+.1,h=380);
     }

}

module bigbase()
{
   difference() {
    intersection() {
       cube([193.5,55,base_thickness]);
       translate([193.5/2,-182,-1]) cylinder(r=220,h=base_thickness+2,$fn=150);
       }  
    //#translate([193.5/2,0,0]) cylinder(r=10,h=10);
}
}

module brace() {
    translate([193.5,17,0]) rotate([0,0,180]) difference() {  translate([193.5/2,-290,0]) cylinder(r=310,h=32.6,$fn=200);
                    translate([193.5/2,-211.9+5,-2]) cylinder(r=223,h=50,$fn=200);
                    translate([-320,3,-2]) rotate([0,0,270]) cube([900,900,50]);
                    translate([-20,-1,-1]) cube([43,16,47]);
                    translate([193.5-22.9,-1,-1]) scale([1,1,1]) cube([43,16,47]);
                    //translate([192.5/2-23/2+5.9,0,14.5]) cube([11.96,40,20]);

}
}





