// PRUSA iteration3
// X end motor
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// Alterations for reprap Wilson by Martin Rice <mrice411@gmail.com>

use <x-end.scad>

offs_adjuster_y = 5.5;
adj_block_x = 12;
adj_block_y = 10;
adj_block_z = 32;
motor_offs_z = 0;

module adjustomatic() {

   difference() {     
       translate(v=[-(15+17/2+adj_block_x/2),offs_adjuster_y,58-adj_block_z/2]) 
          cube(size=[adj_block_x,adj_block_y,adj_block_z],center=true);
       
       translate(v=[-(15+17/2+adj_block_x/2)-5,offs_adjuster_y,58-adj_block_z/2-8]) 
         rotate([0,-30,0]) cube(size=[adj_block_x,adj_block_y+2,adj_block_z],center=true);

       translate(v=[-(15+17/2+adj_block_x/2-1),offs_adjuster_y,58-adj_block_z/2-3]) 
          cube(size=[adj_block_x,adj_block_y-2,adj_block_z-2],center=true);

       translate(v=[-(15+17/2+adj_block_x/2),offs_adjuster_y,58-adj_block_z/2+14]) 
           {
         rotate([0,0,30]) #cylinder(h = 4, r = 7.5/2 , $fn = 6);
         translate([0,0,-20]) #cylinder(h=30,r=2,$fn=16);
}

   }

}

module pocket_endstop()
{
translate([-7,-40,0]) 
    difference() {
       union() {  translate([-1.5,0,0]) cube(size=[9,16,22]);
                  //translate([3,12,20]) cylinder(r=4,h=10,$fn=16);
                  translate([-11,40,57.9]) rotate([90,0,0]) cube(size=[10,5,20]);
       }
    
    #translate([-2,-1,1]) cube(size=[7,16,22]);
    //#translate([3,12,20]) cylinder(r=3,h=21,$fn=16);
    // grove for wiring along bottom
    #translate([-10,50.5,58]) rotate([90,0,0]) cube(size=[8,4,31]);
    // screw holes for endstop switch
    #translate([-2,7,1.5+5.5]) rotate([0,90,0]) cylinder(r=1.5,h=15);
    #translate([-2,7,1.5+5.5+9.5]) rotate([0,90,0]) cylinder(r=1.5,h=15);
    //#translate([0,-3,15]) cube(size=[6,15,20]);
    }
}

module x_end_motor_base(){
 x_end_base();
 // motor arm
 translate(v=[-15,31,26.5+motor_offs_z]) cube(size = [17,44,53], center = true);
 // z stop adjuster
 adjustomatic();
 // x endstop holder
 pocket_endstop();
}

screw_head_r = 3.5;

module x_end_motor_holes(){
 x_end_holes();
 // Position to place
 translate(v=[-1,32,30.25+motor_offs_z]){
  // Belt hole
  translate(v=[-14,1,0]) cube(size = [10,46,22], center = true);
  // Motor mounting holes
  translate(v=[20,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[1,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 12, r=screw_head_r, $fn=30);
 

  translate(v=[20,-15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[1,-15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 12, r=screw_head_r, $fn=30);


  translate(v=[20,15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[1,15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 12, r=screw_head_r, $fn=30);


  translate(v=[20,15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[1,15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 12, r=screw_head_r, $fn=30);

  // Material saving cutout 
  translate(v=[-10,12,10]) cube(size = [60,42,42], center = true);

  // Material saving cutout
  translate(v=[-10,40,-30]) rotate(a=[45,0,0])  cube(size = [60,42,42], center = true);
  // Motor shaft cutout
  translate(v=[0,0,0]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=17, $fn=6);

  // zip tie retainer for securing end stop wiring
  #translate([-5,-59,14]) difference() { cylinder(r=4.5,h=4,$fn=16);
                                          translate([0,0,-1]) cylinder(r=2.5,h=7,$fn=16);
                                        }
 }
}

// Final part
module x_end_motor(){
 difference(){
  x_end_motor_base();
  x_end_motor_holes();
 }
}
rotate([0,0,180])
x_end_motor();