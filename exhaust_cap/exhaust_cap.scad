$fn=40;

LAYER_HEIGHT=1.12;

FROM=94;
TO=96;
HEIGHT=30;

LIP_INNER=TO+10;
LIP_OUTER=LIP_INNER + LAYER_HEIGHT;
LIP_HEIGHT=LAYER_HEIGHT*1.5;

difference() {
    union() {
        translate([0,0,LAYER_HEIGHT]) cylinder(h=HEIGHT, d1=TO, d2=FROM);
        linear_extrude(LAYER_HEIGHT) circle(d=LIP_INNER);
    }

   translate([0,0,LAYER_HEIGHT]) cylinder(h=HEIGHT * 2, d=90);
}

echo(version=version());
