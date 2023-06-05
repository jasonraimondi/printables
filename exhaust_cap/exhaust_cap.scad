$fn=40;

LAYER_HEIGHT=1.12;

FROM=95;
TO=101;
HEIGHT=30;

LIP_INNER=TO+10;
LIP_OUTER=LIP_INNER + LAYER_HEIGHT;
LIP_HEIGHT=LAYER_HEIGHT*1.5;

difference() {
    union() {
        translate([0,0,LAYER_HEIGHT]) cylinder(h=HEIGHT, d1=TO, d2=FROM);
        linear_extrude(LAYER_HEIGHT) circle(d=LIP_INNER);
    }

    rotate([0,90,0]) union() difference() {
        cylinder(h=40,d=40,center=true);
        cylinder(h=40,d=10,center=true);
    }
}


echo(version=version());
