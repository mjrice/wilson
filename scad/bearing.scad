// PRUSA iteration3
// Bearing holders
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// Alterations for Wilson by MRice <mrice411@gmail.com>

bearing_diameter = 15; 

module horizontal_bearing_base(bearings=1){
 translate(v=[0,0,6]) cube(size = [24,8+bearings*25,12], center = true);	
}
module horizontal_bearing_holes(bearings=1){
 cutter_lenght = 10+bearings*25;
 one_holder_lenght = 8+25;
 holder_lenght = 8+bearings*25;
 
 // Main bearing cut
 difference(){
  translate(v=[0,0,12]) 
      rotate(a=[90,0,0]) translate(v=[0,0,-cutter_lenght/2]) cylinder(h = cutter_lenght, r=bearing_diameter/2, $fn=50);
  // Bearing retainers
  translate(v=[0,1-holder_lenght/2,3]) cube(size = [24,6,8], center = true);
  translate(v=[0,-1+holder_lenght/2,3]) cube(size = [24,6,8], center = true);
 }
 
 // Ziptie cutouts
 ziptie_cut_ofset = 0;
 for ( i = [0 : bearings-1] ){
  // For easier positioning I move them by half of one 
  // bearing holder then add each bearign lenght and then center again
  translate(v=[0,-holder_lenght/2,0]) translate(v=[0,one_holder_lenght/2+i*25,0]) difference(){
   union(){
    translate(v=[0,2-6,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 4, r=12.5, $fn=50);
    translate(v=[0,2+6,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 4, r=12.5, $fn=50);
   }
   translate(v=[0,10,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 24, r=10, $fn=50);
  }
 }
 
}

module horizontal_bearing_test(){
 difference(){
  horizontal_bearing_base(1);
  horizontal_bearing_holes(1);
 }
 translate(v=[30,0,0]) difference(){
  horizontal_bearing_base(2);
  horizontal_bearing_holes(2);
 }
 translate(v=[60,0,0]) difference(){
  horizontal_bearing_base(3);
  horizontal_bearing_holes(3);
 }
}



thinwall = 3;
bearing_size = bearing_diameter + 2 * thinwall;

module vertical_bearing_base(){
 translate(v=[-2-bearing_size/4,0,29]) cube(size = [4+bearing_size/2,bearing_size,58], center = true);
 cylinder(h = 58, r=bearing_size/2, $fn = 90);
}

bearing_cut_extra = 0.2; // padding so it's not too tight

module vertical_bearing_holes(){
  #translate(v=[0,0,-4]) cylinder(h = 61, r=bearing_diameter/2 + bearing_cut_extra, $fn = 60);
  #translate(v=[0,0,49]) cylinder(h=10,r=bearing_diameter/2-1,$fn=60);
  #rotate(a=[0,0,-70]) translate(v=[8,0,27/*was 31.5 mjr*/]) cube(size = [5.4,2 /*was 1 mjr*/ ,59], center = true);
  #translate([0,0,-1]) cylinder(h=9,r1=bearing_diameter/2+thinwall/2+1,r2=4,$fn=60);
  //#translate([0,0,49]) cylinder(h=9,r2=bearing_diameter/2+thinwall/2,r1=4,$fn=60);
}

difference(){
vertical_bearing_base();
vertical_bearing_holes();
}