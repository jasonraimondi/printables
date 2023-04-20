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
            circle(2.5);
        }
    }

    difference() {
        top();
        translate([10, 7, 1]) rotate([180]) linear_extrude(height=(base_thickness)) text("WLED");
    }
}

lid();

echo(version=version());