include <BOSL2/std.scad>;
include <./air_holes.scad>;
include <./pegs.scad>;

$fn=10;

pin_widths=63;
pin_depth=60;
base_thickness = 4;
pin_height = 6;
pin_d_base = 5;
pin_d = 3;
case_height = 40;
power_opening = 8;

module bottom() {
    module top() {
        linear_extrude(height=base_thickness / 2) 
        minkowski() {
            square([pin_widths, pin_depth]);
            circle(6);
        }
        linear_extrude(height=(base_thickness)) 
        minkowski() {
            square([pin_widths, pin_depth]);
            circle(3);
        }
    }

    pegs(is_holed=false);

    difference() {
        top();
        pegs(is_holed=true);
        air_holes();
    }
}

bottom();

echo(version=version());
