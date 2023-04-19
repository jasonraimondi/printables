thickness = 4;
overlap = 4;
extrude_thickness = thickness + overlap;

esp_width = 66;
esp_depth = 63;
cylinder_dia = 3;
cylinder_offset = 2.5;


case_width = esp_width + overlap * 2; 
case_depth = esp_depth + overlap * 2; 
case_height = 50;


module base() {
    module peg(x=0, y=0) {
        translate([x, y, -(overlap / 2)]) cylinder(h=extrude_thickness, d=cylinder_dia);
    }

    translate([overlap, overlap, 0]) difference() {
        translate([-overlap, -overlap, 0]) cube([case_width, case_depth, thickness]);
        peg(x=cylinder_offset, y=cylinder_offset);
        peg(x=cylinder_offset, y=(esp_depth - cylinder_offset));
        peg(x=(esp_width - cylinder_offset), y= cylinder_offset);
        peg(x=(esp_width - cylinder_offset), y=(esp_depth - cylinder_offset));
    }
}


module front_wall(with_opening=false) {
    difference() {
        cube([case_width, thickness, case_height]);

        if (with_opening) {
            translate([case_width / 4, -(overlap / 2), case_height / 4]) cube([esp_width / 2, extrude_thickness, case_height / 2]);
        }
    }


}

module side_wall(with_openings=false) {
    difference() {
        translate([0, -thickness,0]) cube([thickness, case_depth + thickness * 2, case_height]);
        for (y = [1:6]) {
            translate([-(overlap / 2), y * 10 - thickness, thickness * 2]) cube([extrude_thickness, 5, 30]);
        }
    }
}

base();
translate([0,-thickness,0]) front_wall(with_opening=true);
translate([0,case_depth,0]) front_wall();
translate([-thickness,0,0]) side_wall();
translate([case_width,0,0]) side_wall();

echo(version=version());
