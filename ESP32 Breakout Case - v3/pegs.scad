include <BOSL2/std.scad>;

module pegs(is_holed=true) {
    standoff_inner_mm = 6;

    module standoff() { 
        cylinder(h=10, d=standoff_inner_mm, $fn=6);
    }

    module screw_holes(is_holed=is_holed) {        
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

    module standoff_holder() {
        module standoff_outer() {
            cylinder(h=4, d=standoff_inner_mm + 2, $fn=6);
        }

        translate([pin_d/2,pin_d/2,base_thickness]) difference() {
            standoff_outer();
            translate([0,0,-1]) standoff();
        }
    }

    positions = [
        [0,0,0],
        [0,pin_depth - pin_d,0],
        [pin_widths - pin_d,0,0],
        [pin_widths - pin_d,pin_depth - pin_d,0]
    ];

    for (p = [ 0 : len(positions) - 1 ]) {
        if (is_holed) {
            translate(positions[p]) screw_holes();
        } else {
            translate(positions[p]) standoff_holder();
        }
    }
}
