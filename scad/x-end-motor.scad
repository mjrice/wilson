// PRUSA iteration3
// X end motor
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <x-end.scad>

offs_adjuster_y = 5.5;
adj_block_x = 12;
adj_block_y = 10;
adj_block_z = 32;

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
         rotate([0,0,30]) #cylinder(h = 4, r=3.1, $fn = 6);
         translate([0,0,-20]) #cylinder(h=30,r=2,$fn=16);
}

   }

}

module x_end_motor_base(){
 x_end_base();
 // motor arm
 translate(v=[-15,31,26.5]) cube(size = [17,44,53], center = true);
 // z stop adjuster
 adjustomatic();
}

module x_end_motor_holes(){
 x_end_holes();
 // Position to place
 translate(v=[-1,32,30.25]){
  // Belt hole
  translate(v=[-14,1,0]) cube(size = [10,46,22], center = true);
  // Motor mounting holes
  translate(v=[20,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[1,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 10, r=3.1, $fn=30);
 

  translate(v=[20,-15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[1,-15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 10, r=3.1, $fn=30);


  translate(v=[20,15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[1,15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 10, r=3.1, $fn=30);


  translate(v=[20,15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[1,15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 10, r=3.1, $fn=30);

  // Material saving cutout 
  translate(v=[-10,12,10]) cube(size = [60,42,42], center = true);

  // Material saving cutout
  translate(v=[-10,40,-30]) rotate(a=[45,0,0])  cube(size = [60,42,42], center = true);
  // Motor shaft cutout
  translate(v=[0,0,0]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=17, $fn=6);
 }
}

// Final part
module x_end_motor(){
 difference(){
  x_end_motor_base();
  x_end_motor_holes();
 }
}

x_end_motor();