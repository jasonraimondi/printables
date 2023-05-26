module shell(wall_width, lip_width, z) {
    matrix_size = 162.75;
    shell_size = matrix_size + (wall_width * 2);
    lip_size = matrix_size - (lip_width * 2);
    
    module picture_hanger() {
        rotate(90) union() {
            circle(d=10);
            translate([10,0,0]) circle(d=6);
            translate([8,0,0]) circle(d=6);
            translate([6,0,0]) circle(d=6);
            translate([4,0,0]) circle(d=6);
        }
    }
        
    union() {        
        difference() {
            linear_extrude(z) 
            minkowski() {
                square(shell_size);
                circle(d=4, $fn=10);    
            }

            translate([wall_width + lip_width, wall_width + lip_width, 0])
            linear_extrude(z) 
            minkowski() {
                square([lip_size, lip_size]);
                circle(d=2, $fn=10);    
            }
            
            layers = 3;
            
            for (x = [1:layers]) {
                translate([wall_width + lip_width/x, wall_width + lip_width/x, x/layers])
                linear_extrude(z) 
                minkowski() {
                    square([lip_size, lip_size]);
                    circle(d=x, $fn=10);    
                }
            }
            
            translate([wall_width, wall_width, wall_width])
            linear_extrude(z) 
            minkowski() {
                square([matrix_size, matrix_size]);
                circle(d=4, $fn=10);    
            }   
        }
        
        translate([wall_width, wall_width,z-wall_width]) 
        linear_extrude(wall_width)
        difference() {
                minkowski() {
                square([matrix_size, matrix_size/3]);
                circle(d=4, $fn=10);
            }
            translate([shell_size/2,20,0]) 
            rotate(180)
            picture_hanger();
        }

    }
}

WIDTH = 1.2;
LIP= 1;
Z = 40;

shell(WIDTH, LIP, Z);
