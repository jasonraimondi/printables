module base(center=true) {
    wid = 2.5;

    base_width = 66;
    base_depth = 63;
    base_height = 4;
    cylinder_height = 20;
    cylinder_dia = 3;

    difference() {
        cube([base_width, base_depth, base_height]);

        translate([wid, wid, -2]) cylinder(h=cylinder_height, d=cylinder_dia);
        translate([wid, base_depth - wid, -2]) cylinder(h=cylinder_height, d=cylinder_dia);
        translate([base_width - wid, wid, -2]) cylinder(h=cylinder_height, d=cylinder_dia);
        translate([base_width - wid,base_depth - wid, -2]) cylinder(h=cylinder_height, d=cylinder_dia);


        opening = 18;

        for (y = [0 : 5]){
            translate([10, y * 10 + 3, -4]) cube([opening, 6, 10]);
            translate([base_depth - (10 + opening), y * 10 + 3, -4]) cube([opening, 6, 10]);
        }
    }
}


module wall(with_openings=false) {
    thickness = 4;

    base_width = 74;
    
    wall_height = 40;


    difference() {
        cube([base_width, thickness, wall_height + thickness]);
       
        if (with_openings) {            
            translate([(base_width / 2) - 10,-10,10]) cube([20, 20, 20]);
            translate([10,-3,10]) cube([10, 10, 25]);
            translate([14 + (base_width / 2),-3,10]) cube([10, 10, 25]);
        }


    }
}

module side_wall() {
    thickness = 4;

    base_width = 74;
    base_depth = 65;
    
    wall_height = 40;
    
    difference() {
        cube([thickness, base_depth + thickness * 2, wall_height + thickness]);
        //translate([2,2.5,40]) cylinder(h=5, d=3);
        //translate([2,68.5,40]) cylinder(h=5, d=3);
    }  
 }


base_width = 74;
base_depth = 69;
base_height = 4;

base();

difference() {
translate([-4, -4, 0]) cube([base_width, base_depth, base_height]);
    translate([0,0,-2]) cube([base_width-9, base_depth-10, 15]);
}

translate([-4,-5,0]) wall(with_title=true, with_openings=true);
translate([-4,64,0]) wall();
translate([-5,-5,0]) side_wall();
translate([69,-5,0]) side_wall();


echo(version=version());
