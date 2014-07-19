//Drag chain holder for wilson
//based on http://www.thingiverse.com/thing:63029/


difference()
{
	union()
	{
		translate([15, 20+34-1.2, 13.55])
		rotate([180,0,0])
		import("../src/chain.stl");
		cube([20, 20+34+21, 13.55]);
	}
	translate([2,-2,2])
	cube([20-4, 80, 15-5]);
	
	translate([-4, 20+34+3.5,2])
	cube([10,14,10]);
	
	translate([10,10,-2])
	#cylinder(r=5.2/2, h=10);
	
	translate([2,4,2])
	#cube([20-4, 12, 15]);

	translate([2,20,2])
	#cube([20-4, 12, 15]);

	translate([2,36,2])
	#cube([20-4, 12, 15]);

	translate([2,52,2])
	#cube([20-4, 20, 15]);

} 
