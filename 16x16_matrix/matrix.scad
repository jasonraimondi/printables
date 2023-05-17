LAYER_HEIGHT = 1.28;

linear_extrude(LAYER_HEIGHT) difference() {
    square (162.5);

    translate([2.5 + 1.25, 2.5 + 1.25,0]) 
    for (x = [0:15]) {
        for (y = [0:15]) {
            translate([x * 10, y * 10, 0]) square(5);
        }
    }
}