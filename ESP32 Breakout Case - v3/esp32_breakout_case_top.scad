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

module shell() {
    linear_extrude(height=case_height) 
    minkowski() {
        square([pin_widths, pin_depth]);
        circle(6);
    }
}

module inset() {
    translate([0,0,base_thickness])
    linear_extrude(height=case_height) 
    minkowski() {
        square([pin_widths, pin_depth]);
        circle(3);
    }
}

module power_hole(diameter=8) {
    $fn=15;
    height = 100;
    
    rotate([90,0,0]) translate([diameter, (case_height * 2/3) + 4,-(height - 10)]) cylinder(h=height,d=diameter);
   
    rotate([90,0,0]) translate([pin_widths - diameter, (case_height * 2/3) + 4,-(height - 10)]) cylinder(h=height,d=diameter);
}

module case(with_top_notch=true) {
    difference() {
        shell();
        inset();
        air_holes();
        power_hole(diameter=8);
        if (with_top_notch) {
            translate([pin_widths/2,0,45]) rotate([90,0,0]) cylinder(h=10,d=20);
        }
        pegs();
    }
}

case(with_top_notch=true);

echo(version=version());
