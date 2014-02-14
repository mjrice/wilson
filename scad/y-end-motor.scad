//
// Parametric single-piece y ends for Reprap Wilson
// GNU GPL v3
// by Martin Rice <mrice411@gmail.com>
//
include <configuration.scad>

washer_recess     = 2; // recesses the washer into the outer side of the end.
motor_face_x_offs = 78; // distance from corner to the face of the stepper motor
fan_hole          = 1;
strengthen_around_fan = 1; // adds block behind fan for extra stiffness
brace_h            = 41;
want_endstop_mount = 1;    // set to zero if you don't want it!
fan_depth = 10; // if this is greater than 10mm, be sure to add strengthen from above.


//endpost();
yend_motor();

module yend_motor()
{
  difference() {
    union() {
       // thin base under the end (optional)
       bigbase();
       // first corner
       endpost();
       // second corner
       translate([193.5,0,0]) scale([-1,1,1]) endpost();
       // motor and fan mount
       translate([motor_face_x_offs,0,0]) translate([-60,42.52,-3]) rotate([0,0,-89.4]) import("i3rsubmotor_fixed.stl");
   
       // connecting braces
       translate([88+53,-3,0]) cube([29.5,19,brace_h]);
       translate([88,0,0]) brace();
       translate([23,0,0]) smallbrace();

       if(strengthen_around_fan)    {        
          translate([25+9.2,-5-(fan_depth-10),0]) cube([54,6+(fan_depth-10),brace_h]);
       }

       if(want_endstop_mount) {
           translate([157,3,brace_h-1]) {
                  cube([4,13,20]);
                  translate([0,10,0]) rotate([0,0,90]) cube([3,5,20]);
           }
          
       }

     }

     translate([-1,-23/2,-1])    rotate([0,0,45]) cube([10,10,90]);
     translate([194.5,-23/2,-1]) rotate([0,0,45]) cube([10,10,90]);
     translate([43,21,-1]) cube([32,30,10]);
     
     // fancy big cutout
     translate([88+23+(fan_depth-10)/5,-45.4-(fan_depth-10)/3,-1]) cylinder(r=52,h=brace_h+10,$fn=100);

     // fan cutout for bigger fans
     #translate([25+13,4+10-fan_depth,1]) cube([40,fan_depth+.5,40]);
     
     // fan vent cutout
     if(fan_hole) translate([23+23.7+11.2,5,20]) rotate([90,0,0]) cylinder(r=19,h=40,$fn=6);

     if(want_endstop_mount) {
            #translate([160,3,brace_h]) {
                translate([1.1,0,1]) cube([6,15,20]); // endstop for visualization
                translate([-5,6.5,5]) #rotate([0,90,0]) rotate([0,0,30]) cylinder(r=1.8,h=10); // mount hole
                translate([-5,6.5,15]) #rotate([0,90,0])  rotate([0,0,30]) cylinder(r=1.8,h=10); // mount hole
             }
            
     }
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

module bigbase()
{     
       intersection() {
       cube([193.5,55,2]);
       translate([193.5/2,-85,-1]) cylinder(r=140,h=9,$fn=50);
       }
}

module brace()
{   

   difference() {
      translate([0,-3,0]) cube([53,19,brace_h]);
      //translate([25,-45.4,-1]) cylinder(r=52,h=brace_h+2,$fn=100);
      translate([25,61.5,-1]) cylinder(r=52,h=brace_h+2,$fn=100);
   }
 
}

module smallbrace()
{
      smallbrace_h = brace_h;

     cube([11.2,16,smallbrace_h]);
}



