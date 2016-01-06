include <nutsnbolts/cyl_head_bolt.scad>;
include <nutsnbolts/materials.scad>;

$fs = 0.01;
thickness = 2;

Espwidth = 50;
Espdepth = 50;
EspHeight = 22;
//EspHeight = 15.5;
ScrewBorder = 2;
ScrewDepth = 5;
    
module box(){
    //cube
    difference(){
        cube([Espwidth+thickness+thickness,Espdepth+thickness+thickness,EspHeight], 0);
        translate([thickness,thickness,thickness]){cube([Espwidth,Espdepth,EspHeight], 0);};
    };
};

module holes(){
    //DC Input
    translate([thickness+Espwidth-34,-1,thickness+6.5]){cube([34,thickness+2,EspHeight], 0);};
    //Outputs
    translate([thickness+Espwidth-46,1+Espdepth,thickness+6.5]){cube([46,thickness+2,EspHeight], 0);};
    //Fets
    translate([thickness-1,thickness+Espwidth-37,thickness]){cube([2,37,EspHeight-5+thickness+1], 0);};
};

module screw(){
    difference() {
        cube([8+ScrewBorder+ScrewBorder,8+ScrewBorder+ScrewBorder,ScrewDepth], 0);
	translate([4+ScrewBorder, 4+ScrewBorder, -1]) cylinder(ScrewBorder+ScrewBorder+4.5, d=3.5, center=false);
        
    translate([4+ScrewBorder, 4+ScrewBorder, -1]) cylinder(3, d=6, center=false);
    }
}

module case(){
    difference(){
            box();
            holes();
    }
}

mirror([0,1,0]){
    case();
    translate([-ScrewBorder-ScrewBorder-8, 0, EspHeight-ScrewDepth]) screw();
    translate([-ScrewBorder-ScrewBorder-8, thickness+Espdepth-ScrewBorder-8, EspHeight-ScrewDepth]) screw();
    translate([thickness+thickness+Espdepth, 0, EspHeight-ScrewDepth]) screw();
    translate([thickness+thickness+Espdepth, thickness+Espdepth-ScrewBorder-8, EspHeight-ScrewDepth]) screw();

    //print support
    translate([-ScrewBorder-ScrewBorder-8, 0, 0]) cube([1.6,8+ScrewBorder+ScrewBorder,EspHeight-ScrewDepth], 0);
    translate([-ScrewBorder-ScrewBorder-8, Espwidth-8, 0]) cube([1.6,8+ScrewBorder+ScrewBorder,EspHeight-ScrewDepth], 0);
    translate([Espdepth+ScrewBorder+ScrewBorder+8+thickness+thickness-1.6, 0, 0]) cube([1.6,8+ScrewBorder+ScrewBorder,EspHeight-ScrewDepth], 0);
    translate([Espdepth+ScrewBorder+ScrewBorder+8+thickness+thickness-1.6, Espwidth-8, 0]) cube([1.6,8+ScrewBorder+ScrewBorder,EspHeight-ScrewDepth], 0);
}