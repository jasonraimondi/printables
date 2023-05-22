LAYER_HEIGHT = 1;
MATRIX_X = 162.5;
MATRIX_Z = 8;

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
    translate([0, 0, LAYER_HEIGHT+size]) linear_extrude(1) difference() {
        flat_bottom();
        translate([size, size, 0]) square(MATRIX_X - (size * 2));
    }
}

FLATTY = 0.4;
union() {
    translate([0,0,FLATTY]) union() {
        walls();
        for (size = [0.5:0.25:2.5]) {
            notch(size);
        }
        linear_extrude(LAYER_HEIGHT) difference() {
            flat_bottom();
            translate([3.75, 3.75,0]) led_slots();
        }
    }
    linear_extrude(FLATTY) flat_bottom();
}
