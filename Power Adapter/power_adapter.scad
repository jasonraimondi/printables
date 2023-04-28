echo(version=version());

include <BOSL2/std.scad>

difference() {
    minkowski() {
      cube([14, 38, 11.9], center=true);
      sphere(1.5, center=true);
    }
    
    xrot(-90) cylinder(h=20, d1=14, d2=10.8, $fn=4, spin=45, center=true);
//    cube([14, 20, 20], center=true);
}
