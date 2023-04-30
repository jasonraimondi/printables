include <./standoff.scad>;
include <./plug.scad>;

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
    module power_hole(diameter = POWER_OPENING) {
        $fn=15;
        height = 100;
        
        rotate([90,0,0]) translate([pin_widths / 2, (case_height * 2/3) + 4, -(height - 10)]) cylinder(h=height,d=diameter);
    }

    module power_holder() {
        translate([(PIN_WIDTHS / 2) - (POWER_OPENING / 2), -3, ((CASE_HEIGHT * 2/3) + 4) - POWER_OPENING / 2]) square([10, 22]);
    }

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

        power_hole();
        air_holes();
    }

    echo("TODO ADD POWER HOLDER");
    // power_holder();
}

difference() {
    case();
    pegs(with_standoff_cutout = true);
}
translate([0,0,BASE_THICKNESS]) pegs(type="standoff_holder");

echo(version=version());
