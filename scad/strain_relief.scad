//-- Stepper mounted extruder cable harness strain relief
//-- with nylon ties
//-- by AndrewBCN - Barcelona, Spain - December 2014
//-- GPLV3

//-- I designed this for use with Marty Rice's awesome
//-- Direct Drive Extruder which I have installed on my
//-- P3Steel, but it can probably be used for many other
//-- extruder setups. Simple fact is,  there is a thick
//-- bunch of electrical wires that comes out of the extruder, go
//-- around the top of the printer and then down to the
//-- RAMPS electronics. All this moves left and right together
//-- with the X-carriage and common sense dictates that a strain
//-- relief is required to avoid wire breakage and the usual
//-- disastrous consequences.
//-- I have designed this strain relief so that it is very easy
//-- to install even after everything is in place. It requires
//-- one long and two short nylon ties, the long one goes around
//-- the stepper and the two shorter ones are tightened around the
//-- cable harness.

//-- Some tweaks by MRice - I made the bit around the cables 
//-- curved so that it would grab a little better, and 
//-- parameterized the larger ziptie cut and then made it a 
//-- little wider than the original.

//-- Parameters
large_ziptie_w = 6;
small_ziptie_w = 3;
mount_w = 4 + large_ziptie_w;


//-- Modules
module ziptie_groove() {
  rotate([90,0,0]) difference() {
        cylinder(r=12,h=small_ziptie_w);
        translate([0,0,-1]) cylinder(r=10,h=small_ziptie_w+2);
  }
}

module strf() {
  // stepper mount
  difference() {
    union() {
      union() {
	    cube([17.2,6,mount_w]);
       translate([17.2,0,0]) rotate([0,0,45]) cube([6,6,mount_w]);
      }
      mirror([1,0,0]) union() {
      	 cube([17.2,6,mount_w]);
	    translate([17.2,0,0]) rotate([0,0,45]) cube([6,6,mount_w]);
      }
    }
    // tunnel for nylon tie
    translate([-25,2.2,mount_w/2-large_ziptie_w/2]) cube([50,large_ziptie_w/3,large_ziptie_w]);
    // delete some useless material
    translate([-30.4,-1,-.5]) cube([10,10,mount_w+1]);
    mirror([1,0,0]) translate([-30.4,-1,-.5]) cube([10,10,mount_w+1]);
  }
  // arm
  difference() {
    union() {
      translate([7,0,7]) cube([6,6,28]);
      translate([7,6,25]) cube([6,6,10]);
      translate([7,0,33]) rotate([0,45,0]) cube([6,12,10]);
      translate([13,0,33]) mirror([1,0,0]) rotate([0,45,0]) cube([6,12,10]);
      translate([7,0,33]) cube([6,12,10]);
    }
    // cup to hold harness
    translate([10,16,49.5]) rotate([90,0,0]) scale([1,1.4,1]) #cylinder(r=9, h=18,$fn=40);
    // save some material
    translate([4,13.08,17.9]) rotate([45,0,0]) cube([10,10,10]);
    // tunnels for nylon ties
    translate([10,4,46]) #ziptie_groove();
    translate([10,11,46]) #ziptie_groove();
  }
}

//-- Print the part
rotate([90,0,0]) strf();
