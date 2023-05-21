z=0.2;

for (x = [0:5]) {
    translate([15 * x,0,0]) 
    linear_extrude(z) 
    square([10, 200]);
}
