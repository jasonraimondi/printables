// CSG.scad - Basic example of CSG usage

thickness = 3;


rotate([0,0,1]) {  
  cube([30, thickness, thickness]);
}


translate ([0, 3 + thickness, 0]) {
    rotate([0,0,-1]) {
       cube([30, thickness, thickness]);
    }
}

translate([28,0.5,0]) {
   cube(size=[thickness, 8, thickness]);
}

cyl = 15;

translate([-5, 4.5, 0]) {

difference() {
    cylinder(h=thickness,d=cyl);
    translate([0, 0, -1]) {
        cylinder(h=thickness + 2,d=cyl-(thickness*2));
    }  
    translate([5,0,1]) {
        cube([5, thickness, 6], center=true);     
    }  
}
}

translate([-20,-0.25,0]) {

  difference() {
      cube([10, 10, thickness]);
      translate([2, 1.5, -2]) {
          cube([4, 7, 7]);
      }
  }
}


echo(version=version());
