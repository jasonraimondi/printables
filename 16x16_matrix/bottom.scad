module shell(wall_width, lip_width, z) {
    matrix_size = 162.5;
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

    module frame(limit = 4) {
        translate([0,0,limit]) for (i = [-limit:limit]) {
            num = i+5;
            shift = -(num/2);
            translate([shift,shift,-i])
            linear_extrude(wall_width) 
            minkowski() {
                square(shell_size + num);
                circle(d=4, $fn=10);    
            }
        }
    }
        
    union() {

        color("orange") difference() {
            union() {
                linear_extrude(z) 
                minkowski() {
                    square(shell_size);
                    circle(d=4, $fn=10);    
                }
                frame();
            }
            
            for (x = [0:lip_width]) {
                shift = wall_width + lip_width;
                translate([shift, shift, (x/wall_width)])
                linear_extrude(z) 
                minkowski() {
                    square([lip_size, lip_size]);
                    circle(d=7+x, $fn=10);    
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
                square([matrix_size, matrix_size]);
                circle(d=4, $fn=10);
            }
            translate([-2,matrix_size/3.4,0]) 
            minkowski() {
                square([matrix_size, matrix_size * 2/3]);
                square(4);
            }
            translate([shell_size/2,20,0]) 
            rotate(180)
            picture_hanger();
        }
    }
}

WIDTH = 0.28 * 8;
LIP= 4;
Z = 40;

shell(WIDTH, LIP, Z);
