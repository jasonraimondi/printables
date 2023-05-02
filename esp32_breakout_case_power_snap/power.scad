POWER_OPENING = 10.5;
WALL_THICKNESS = 4;

module power_snap(power_opening = POWER_OPENING, wall_thickness = WALL_THICKNESS) {
    plate_x = 16;
    plate_y = 15;

    module power_opening() {
        x = wall_thickness;
        
        difference() {
            translate([x/2,0,0]) linear_extrude(height=wall_thickness) square([plate_x + x,plate_y], center=true);
            linear_extrude(height=wall_thickness) circle(d=power_opening, center=true, $fn=20);
        }
    }
    
    module snap_back() {
        snap_height = 2;
        height = 22 + wall_thickness;
        
        translate([(plate_x / 2) + wall_thickness/2,0,0]) 
        difference() {
            translate([-2.5 - wall_thickness / 2,-(plate_y / 2),height]) linear_extrude(height=2) square([2.5, plate_y]);
            translate([-2.5 - wall_thickness / 2,-(plate_y / 6),height]) linear_extrude(height=2) square([2.5, plate_y / 3]);
        }
    }

    power_opening();
    snap_back();
}

// power_snap();