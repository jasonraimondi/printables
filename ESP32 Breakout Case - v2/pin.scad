include <BOSL2/std.scad>
include <BOSL2/metric_screws.scad>

module band() {
    difference() {
        cylinder(h=2.5, d=10);
        translate([0,0,-1]) cylinder(h=5, d=5);
    }
}

difference() {
    generic_screw(screwsize=2.8,screwlen=5,headsize=7,headlen=8, anchor="base");
    up(3) band();
}

echo(version=version());
