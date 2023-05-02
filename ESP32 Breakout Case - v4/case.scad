include <./standoff.scad>;

$fn=10;

PIN_WIDTHS=63;
PIN_DEPTH=60;
BASE_THICKNESS = 4;
CASE_HEIGHT = 40;
POWER_OPENING = 10;

module air_holes(pin_widths = PIN_WIDTHS, pin_depth = PIN_DEPTH) {
    cube_size=5;
    count = 5;
    width = pin_widths * (2/3);
    offset = (width - cube_size) / count;

    translate([pin_widths * 1/6, pin_depth * 1/6,0]) {
        for (x=[0:count]) {
            for (y=[0:count]) {
                translate([offset * x, offset * y, -10]) cube([cube_size,cube_size,100]);
            }
        }
    }
}

module case(case_height = CASE_HEIGHT, pin_widths = PIN_WIDTHS, pin_depth = PIN_DEPTH, base_thickness = BASE_THICKNESS) {
    module shell() {
        difference() {
            union() {
                linear_extrude(height=case_height) 
                minkowski() {
                    square([pin_widths, pin_depth]);
                    circle(6);
                }
            }

            translate([0,0,base_thickness])
            linear_extrude(height=case_height) 
            minkowski() {
                square([pin_widths, pin_depth]);
                circle(3);
            }
            
            power_cutout();
            cord_hole(opening=10);
            air_holes();
        }
    }

    module power_cutout() {
        plate_x = 15.5;
        plate_y = 18.5;
        
        translate([0,-10,case_height - plate_y]) linear_extrude(height=plate_y) square([plate_x,10]);
    }
    
    module cord_hole(opening = 10) {
        height = 20;

        translate([pin_widths/2, pin_depth + 10, case_height]) {
            translate([0, 0, -opening]) 
            rotate([90,0,0]) 
            color("brown") 
            cylinder(d=opening,h=height, center=true);

            cube([3, height, opening + 1], center=true);
        }
    }

    difference() {
        shell();
        pegs(with_standoff_cutout = true);
    }
    
    translate([ 0, 0, BASE_THICKNESS]) pegs(type="standoff_holder");
}

case();

echo(version=version());
