LAYER_HEIGHT = 0.2;
BOTTOM_LAYER = LAYER_HEIGHT * 4;

MATRIX_X = 162.5;
MATRIX_Z = 5;

module flat_bottom() {
    minkowski() {
        square(MATRIX_X);
        circle(d=2, $fn=10);    
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

module notch(size) {
    translate([0, 0, BOTTOM_LAYER+size]) linear_extrude(1) difference() {
        flat_bottom();
        translate([size, size, 0]) square(MATRIX_X - (size * 2));
    }
}

union() {
    translate([0,0,LAYER_HEIGHT]) union() {
        walls();
        start = LAYER_HEIGHT;
        step = LAYER_HEIGHT/2;
        limit = LAYER_HEIGHT * 4;
        for (size = [start:step:limit]) {
            translate([0,0,1]) notch(size);
        }
        linear_extrude(BOTTOM_LAYER) difference() {
            flat_bottom();
            translate([3.75, 3.75,0]) led_slots();
        }
    }
    linear_extrude(LAYER_HEIGHT) flat_bottom();
}