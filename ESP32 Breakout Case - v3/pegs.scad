module pegs() {
    module standoff() { cylinder(h=10, d=4.9, $fn=6); }

    module peg() {
        translate([pin_d/2,pin_d/2,0])
        linear_extrude(height = base_thickness * 4) 
        circle(d=pin_d, $fn=15);

        translate([pin_d/2,pin_d/2,-0.2])
        linear_extrude(height = base_thickness / 2) 
        circle(d=pin_d + 3, $fn=15);

        difference() {
            translate([pin_d/2,pin_d/2,base_thickness / 1.5]) standoff();
        }
    }

    peg();
    translate([0,pin_depth - pin_d,0]) peg();
    translate([pin_widths - pin_d,0,0]) peg();
    translate([pin_widths - pin_d,pin_depth - pin_d,0]) peg();
}
