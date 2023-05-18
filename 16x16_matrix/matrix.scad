LAYER_HEIGHT = 1.28;
MATRIX_X = 162.5;
MATRIX_Z = 40 + LAYER_HEIGHT;

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
    linear_extrude(4) difference() {
        flat_bottom();
        square(MATRIX_X);
    }
}

walls();

linear_extrude(LAYER_HEIGHT) difference() {
    flat_bottom();
    translate([3.75, 3.75,0]) led_slots();
}
