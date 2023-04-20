$fn=10;

pin_widths=63;
pin_depth=60;
base_thickness = 4;
pin_d = 3;
case_height = 30;
power_opening = 8;

module pegs() {
    module peg() {
        translate([pin_d/2,pin_d/2,0])
        linear_extrude(height = 100, center=true) 
        circle(d=pin_d, $fn=15);

        translate([pin_d/2,pin_d/2,0])
        linear_extrude(height = 2, center=true) 
        circle(d=pin_d + 3, $fn=15);
    }

    peg();
    translate([0,pin_depth - pin_d,0]) peg();
    translate([pin_widths - pin_d,0,0]) peg();
    translate([pin_widths - pin_d,pin_depth - pin_d,0]) peg();

}

module air_holes() {
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

module case() {
    difference() {
        shell();
        inset();
        pegs();
        air_holes();
    }
}

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
        air_holes();
    }
}

case();
translate([80,0,0]) lid();

echo(version=version());
