$fn=10;

wall_thickness = 4;
base_thickness = 2;

overlap = 10;
extrude_thickness = base_thickness + overlap;

esp_width = 66;
esp_depth = 63;
cylinder_dia = 3;
cylinder_offset = 2.5;

case_height = 20;

power_opening = 8;

pin_widths=63;
pin_depth=60;

module pegs() {
    module peg() {
        translate([cylinder_dia/2,cylinder_dia/2,0])
        linear_extrude(height = 100, center=true) 
        circle(d=cylinder_dia, $fn=15);
    }

    peg();
    translate([0,pin_depth - cylinder_dia,0]) peg();
    translate([pin_widths - cylinder_dia,0,0]) peg();
    translate([pin_widths - cylinder_dia,pin_depth - cylinder_dia,0]) peg();

}

difference() {
    shell();
    inset();
    pegs();
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
        circle(2);
    }
}

echo(version=version());
