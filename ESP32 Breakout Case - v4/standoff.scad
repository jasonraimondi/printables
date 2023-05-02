BASE_THICKNESS = 4;
PIN_HEIGHT = 6;
PIN_DIAMETER = 3;
STANDOFF_INNER_DIA = 6;

STANDOFF_WIDTH=63;
STANDOFF_DEPTH=60;

PIN_COORDINATES = [
    [0, 0, 0],
    [0, STANDOFF_DEPTH - PIN_DIAMETER, 0],
    [STANDOFF_WIDTH - PIN_DIAMETER, 0, 0],
    [STANDOFF_WIDTH - PIN_DIAMETER, STANDOFF_DEPTH - PIN_DIAMETER, 0]
];

module screw_holes(thickness = BASE_THICKNESS, diameter = PIN_DIAMETER, with_standoff_cutout = false) {        
    _offset = diameter / 2;

    translate([diameter/2, diameter/2, 0]) union() {
        translate([0,0,-1])
        linear_extrude(height = thickness + 4) 
        circle(d=diameter, $fn=15);

        translate([0,0,-0.2])
        linear_extrude(height = thickness / 3) 
        circle(d=diameter + 3, $fn=15);

        if (with_standoff_cutout) {
            difference() {
                translate([0,0,thickness/1.5]) standoff();
            }
        }
    }
}

module standoff(diameter = STANDOFF_INNER_DIA) { 
    cylinder(h=10, d=diameter, $fn=6);
}

module standoff_outer(diameter = STANDOFF_INNER_DIA) {
    cylinder(h=4, d=diameter + 2, $fn=6);
}

module standoff_holder(diameter = PIN_DIAMETER, thickness = BASE_THICKNESS) {
    translate([diameter / 2, diameter / 2, 0]) difference() {
        standoff_outer();
        translate([0,0,-1]) standoff();
    }
}

function pin_coords(positions) = [ 0 : len(positions) - 1 ];

module pegs(type="screw_holes", positions = PIN_COORDINATES, with_standoff_cutout = false) {
    for (p = pin_coords(positions)) {
        if (type == "screw_holes") {
            translate(positions[p]) screw_holes(with_standoff_cutout = with_standoff_cutout);
        } else if (type == "standoff_holder") {
            translate(positions[p]) standoff_holder();
        }
    }
}
