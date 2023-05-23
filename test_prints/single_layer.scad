z=0.12;

for (x = [0:3]) {
    translate([15 * x,0,0]) 
    linear_extrude(z) 
    for (y = [0:1]) {
        translate([x, y * 100, 0]) square([10, 75]);
    }
}
