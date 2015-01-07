// Y frame brace for Wilson TS
// by sgraber
// further parameterized and fiddled with my mjrice

beam_size = 20;
smidge = .52; // about your nozzle width, maybe a little more so they aren't too tight).
walls = 5;
bracket_w = beam_size + (walls*2);

module fillet() {
	difference() {
		cube(size=[bracket_w,beam_size,beam_size]);
		rotate([0,90,0]) translate([-beam_size,0.5,0]) cylinder(r=10*2, h=bracket_w+1,$fn=60);
	}
}

bracket();

module bracket() {
 difference() {
	union() {
		cube(size=[bracket_w,45,4]);
		translate([0,70/2-29/2,0]) cube(size=[bracket_w,beam_size + 4.7,30]);
		translate([0,0.5,4]) fillet();
		//translate([0,69.5,4]) mirror([0,1,0]) fillet();
	}
	translate([walls-smidge/2,70/2-20.5/2,-1]) cube(size=[beam_size + smidge,beam_size + 2,40]);
	translate([beam_size/2+walls,7+8,-5]) cylinder(r=3,h=50);   // inner hole
	translate([beam_size/2+walls,7+8,5]) cylinder(r=5.5,h=50); // outer inset hole for screw head
	//translate([beam_size/2+walls,63,-5]) cylinder(r=3,h=50);
	//translate([beam_size/2+walls,63,4]) cylinder(r=5,h=50);
	translate([-1,0,0]) cube(size=[bracket_w+2,5,10]); // cuts off the bit on the front

	translate([beam_size/2+walls,70,10+8]) rotate([90,0,0]) cylinder(r=3,h=70); // inner hole
	translate([beam_size/2+walls,21,10+8]) rotate([90,0,0]) cylinder(r=5.5,h=70); // outer inset hole for screw head
	//translate([beam_size/2+walls,25+70,10+8]) rotate([90,0,0]) cylinder(r=5,h=43);

    // bevels on bottom of the part, so that squashing of the first layer won't impact our fit to the extrusions:
    translate([1,70/2-20.5/2,-3]) rotate([0,45,0]) cube(size=[beam_size,beam_size+2,beam_size]);
    #translate([25.7,70/2-20.5/2-4,-3]) rotate([0,45,90]) cube(size=[2,beam_size+smidge*2,7]);
    
 }
}