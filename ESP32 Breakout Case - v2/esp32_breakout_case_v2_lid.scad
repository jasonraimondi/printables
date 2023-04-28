$fn=10;

pin_widths=63;
pin_depth=60;
base_thickness = 4;
pin_d = 3;
case_height = 40;
power_opening = 8;

module lid() {
    module top() {
        linear_extrude(height=base_thickness) 
        minkowski() {
            square([pin_widths, pin_depth]);
            circle(6);
        }
        linear_extrude(height=(base_thickness + 2)) 
        minkowski() {
            square([pin_widths, pin_depth]);
            circle(3);
        }
    }

    difference() {
        top();
        translate([0,0,-1]) cylinder(h=10,d=5);
        translate([pin_widths/2,-3,11.5]) rotate([90,0,0]) cylinder(h=10,d=20);
    }
}

lid();

echo(version=version());