// Drag chain holder for wilson
// based on http://www.thingiverse.com/thing:63029/

// Customizable settings

// How far is the center of the location you want your wires to enter the cable chain offset from the front side of the 2020 extrusion (in mm)
// This should work for Wilson's Direct Drive if your stepper wires are oriented upwards.
wire_offset = 56;
// Custom?
//wire_offset = ;

// If your screws are a little too long and reach the inside of the 2020 extrusion before securing the holder you can add a few mm to this.
screw_padding = 2;

// There are multiple possible locations for the screw hole(s). Each one can be turned on or off to get the screw profile you desire.
screwhole_inside = false;
screwhole_outside_openside = true; // The side the chain comes out
screwhole_outside_closedside = true; // The opposite side

// End of settings

chain_width = 21;
chain_origin_offset = 1.2; // The origin in chain.stl is slightly beyond the edge of the chain
chain_hole_width = 14;
wall_width = 2;
bar_height = 13.55;
bar_width = 20;
//bar_length = 20+34+chain_width+24;
bar_length = 20 + max(wire_offset, chain_width / 2) + chain_width / 2;
rail_height = 1.55;
rail_size = 4;
rail_spacing = 12;
screwhole_diameter = 5.6;
screwpadding_diameter = 10.2;

internal_height = bar_height-wall_width-rail_height;
railcutout_offset = bar_height-rail_height-2;
lastcutout_offset = floor((bar_length-rail_size)/(rail_spacing+rail_size)-1)*(rail_spacing+rail_size)+rail_size;

difference()
{
    union()
    {
        difference()
        {
            union()
            {
                // Combine the chain with a long cube
                translate([15, bar_length-chain_width-chain_origin_offset, bar_height])
                    rotate([180,0,0])
                    import("../stl/chain.stl");
                cube([bar_width, bar_length, bar_height]);
            }

            // Hollow out the cube for wires to pass through
            translate([wall_width, -2, wall_width])
            #cube([bar_width-wall_width*2, bar_length+4, internal_height]);

            translate([-4, bar_length-chain_width+3.5, 2])
            #cube([10, chain_hole_width, internal_height]);
        }

        // If screw padding is set add an extra cylinder
        if ( screwhole_inside && screw_padding > 0 ) {
            translate([bar_width/2, 10, 0])
            cylinder(r=screwpadding_diameter/2, h=wall_width+screw_padding);
        }

        // Add external screw holes if enabled
        if ( screwhole_outside_openside ) {
            difference()
            {
                translate([-15, 0, 0])
                cube([15, 20, wall_width+screw_padding]);

                translate([-15/2, 10, -2])
                #cylinder(r=screwhole_diameter/2, h=wall_width+screw_padding+4);
            }
        }

        if ( screwhole_outside_closedside ) {
            difference()
            {
                translate([bar_width, 0, 0])
                cube([15, 20, wall_width+screw_padding]);

                translate([bar_width+15/2, 10, -2])
                #cylinder(r=screwhole_diameter/2, h=wall_width+screw_padding+4);
            }
        }
    }

    // Add a screw hole
    if ( screwhole_inside ) {
        translate([bar_width/2, 10, -2])
        #cylinder(r=screwhole_diameter/2, h=wall_width+screw_padding+4);
	}

    // Cut open holes in the roof so only rails remain
    for ( offset = [rail_size : rail_spacing+rail_size : bar_length-rail_size-rail_spacing] ) {
        translate([wall_width, offset, railcutout_offset])
        #cube([bar_width-wall_width*2, rail_spacing, rail_height+4]);
    }

    // Expand the last cutout to the end of the bar
    translate([wall_width, lastcutout_offset, railcutout_offset])
    #cube([bar_width-wall_width*2, bar_length-lastcutout_offset-rail_size, rail_height+4]);
} 
