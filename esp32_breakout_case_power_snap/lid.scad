include <./power.scad>;

$fn=10;

LID_THICKNESS = 2;
NOTCH_THICKNESS = 3;

module lid(lid_z = LID_THICKNESS, notch_z = NOTCH_THICKNESS) {
    pin_widths=63;
    pin_depth=60;
    
    module top() {
        union() {
            linear_extrude(height=lid_z) 
            minkowski() {
                square([pin_widths, pin_depth]);
                circle(6);
            }
            linear_extrude(height=(lid_z + notch_z)) 
            minkowski() {
                square([pin_widths, pin_depth]);
                circle(3);
            }
        }
    }

    module _power_snap() {
        translate([61.9,-13.2, 8]) rotate([-90,90,0]) power_snap();
    }

    union() {
        top();
        translate([ -5.7, 7.5, lid_z + notch_z]) color("blue") _power_snap(wall_thickness = lid_z + notch_z); 
    }

}

lid();

echo(version=version());