$fn=10;

pin_widths=63;
pin_depth=60;
base_thickness = 4;
pin_height = 6;
pin_d_base = 5;
pin_d = 3;
case_height = 40;
power_opening = 8;

module pegs() {
    module peg() {
        translate([pin_d/2, pin_d/2, base_thickness]) {
            linear_extrude(height = 2, center=true) circle(d=pin_d_base + 3, $fn=15);

            difference() {
                linear_extrude(height = pin_height) circle(d=pin_d_base, $fn=15);            linear_extrude(height = 20, center=true) circle(d=pin_d, $fn=15);
            }
        }
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
    }
    pegs();
}

case(with_top_notch=true);

echo(version=version());
