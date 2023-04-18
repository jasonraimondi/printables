
base_height = 4;
base_width = 66;
base_depth = 63;

cylinder_height = 4;
cylinder_dia = 5;
cylinder_dia_small = 2.9;


cube([base_width, base_depth, base_height]);


translate([2.5, 2.5, base_height]) {
    cylinder(h=cylinder_height, d=cylinder_dia);
    cylinder(h=cylinder_height + 1.5, d=cylinder_dia_small);
}


translate([2.5, base_depth - 2.5, base_height]) {
    cylinder(h=cylinder_height, d=cylinder_dia);
    cylinder(h=cylinder_height + 1.5, d=cylinder_dia_small);
}

translate([base_width - 2.5, 2.5, base_height]) {
    cylinder(h=cylinder_height, d=cylinder_dia);
    cylinder(h=cylinder_height + 1.5, d=cylinder_dia_small);
}

translate([base_width - 2.5,base_depth - 2.5, base_height]) {
    cylinder(h=cylinder_height, d=cylinder_dia);
    cylinder(h=cylinder_height + 1.5, d=cylinder_dia_small);
}