LAYER_HEIGHT = 1.28;
MATRIX_X = 162.5;
MATRIX_Z = 5;

module flat_bottom() {
    minkowski() {
        square(MATRIX_X);
        circle(LAYER_HEIGHT, $fn=10);    
    }
}

module led_slots() {
    for (x = [0:15]) {
        for (y = [0:15]) {
            translate([x * 10, y * 10, 0]) square(5);
        }
    }
}

module walls() {
    linear_extrude(MATRIX_Z) difference() {
        flat_bottom();
        square(MATRIX_X);
    }
}

module notch() {
    NOTCH_OFFSET = 1.28;
    translate([0,0,LAYER_HEIGHT + NOTCH_OFFSET]) linear_extrude(1) difference() {
        flat_bottom();
        translate([1, 1, 0]) square(MATRIX_X - 2);
    }
}

walls();
notch();

linear_extrude(LAYER_HEIGHT) difference() {
    flat_bottom();
    translate([3.75, 3.75,0]) led_slots();
}
