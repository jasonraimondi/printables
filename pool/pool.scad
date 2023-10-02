                                    function feet(num) = num * 12;

module pool() {
    module pool_shape() {    
        polygon([
          [0,0],
          [feet(12),0],
          [feet(12),feet(18)], 
          [feet(18),feet(18)],
          [feet(18),feet(26)],
          [feet(0),feet(31.7)],
        ]);
    }
    
    module deep_end_bench() {
        linear_extrude(feet(3.5)) polygon([
          [feet(16),feet(18)],
          [feet(18),feet(18)],
          [feet(18),feet(26)],
          [feet(16),feet(27)],
        ]);
    }
    
    module deep_end_corner() {
        bench_size = feet(3); 
        linear_extrude(feet(3.5)) polygon([
          [feet(0),feet(31.7)],
          [bench_size,feet(31.7)],
          [feet(0),feet(31.7) - bench_size],
        ]);
    }
    
    module grand_entrance() {
        linear_extrude(feet(4.5)) polygon([
          [0,0],
          [feet(12),0],
          [feet(12),feet(6)], 
          [feet(0),feet(6)],
        ]);
        linear_extrude(feet(3.5)) polygon([
          [feet(0),feet(6)],
          [feet(12),feet(6)],
          [feet(12),feet(7)], 
          [feet(0),feet(7)],
        ]);
        linear_extrude(feet(2.5)) polygon([
          [feet(0),feet(7)],
          [feet(12),feet(7)],
          [feet(12),feet(8)], 
          [feet(0),feet(8)],
        ]);
    }  
    
    difference() {
        linear_extrude(feet(6)) minkowski() {
          pool_shape();
          circle(feet(1));
        }
        translate([0,0,feet(1)]) linear_extrude(height=feet(5)) pool_shape();
    }
    //translate([0,0,feet(1)]) grand_entrance();
    //translate([0,0,feet(1)]) deep_end_bench();
    //translate([0,0,feet(1)]) deep_end_corner();

}

pool();