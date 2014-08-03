// Y frame brace for Wilson TS
// by sgraber

beam_size = 20;
smidge = .65; // this is the amount needed for built-in slicing error (needs to be 
              // about your nozzle width, maybe a little more so they aren't too tight)

module fillet() {
	difference() {
		cube(size=[20+8,20,20]);
		rotate([0,90,0]) translate([-20,0.5,0]) cylinder(r=10*2, h=30);
	}
}

bracket();

module bracket() {
 difference() {
	union() {
		cube(size=[beam_size+8,45,4]);
		translate([0,70/2-29/2,0]) cube(size=[beam_size+8,beam_size + 4.7,30]);
		translate([0,0.5,4]) fillet();
		//translate([0,69.5,4]) mirror([0,1,0]) fillet();
	}
	#translate([-0.25+4,70/2-20.5/2,-1]) cube(size=[beam_size + smidge,beam_size + 2,40]);
	translate([10+4,7+8,-5]) cylinder(r=3,h=50);
	translate([10+4,7+8,5]) #cylinder(r=5.5,h=50);
	translate([10+4,63,-5]) cylinder(r=3,h=50);
	translate([10+4,63,4]) cylinder(r=5,h=50);
	#cube(size=[40,5,10]);

	translate([10+4,70,10+8]) rotate([90,0,0]) cylinder(r=3,h=70);
	translate([10+4,21,10+8]) rotate([90,0,0]) #cylinder(r=5.5,h=70);
	translate([10+4,25+70,10+8]) rotate([90,0,0]) cylinder(r=5,h=43);
 }
}