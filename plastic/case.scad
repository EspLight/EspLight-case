include <nutsnbolts/cyl_head_bolt.scad>;
include <nutsnbolts/materials.scad>;

$fs = 0.01;
thickness = 2;

Espwidth = 50;
Espdepth = 50;
PcbHeight = 4;
EspHeight = 5;
ScrewBorder = 2;
ScrewHoleSize = 4;
    
module box(){
    //cube
    difference(){
        cube([Espwidth+thickness+thickness,Espdepth+thickness+thickness,EspHeight+PcbHeight], 0);
        translate([thickness,thickness,thickness]){cube([Espwidth,Espdepth,EspHeight+PcbHeight], 0);};
    };
    //PCB holder
    translate([thickness+7,thickness+Espdepth-7,thickness]){cylinder(PcbHeight, d=3, center=false);};
    translate([thickness+Espwidth-7,thickness+Espdepth-7,thickness]){cylinder(PcbHeight, d=3, center=false);};
    translate([thickness+7,thickness+7,thickness]){cylinder(PcbHeight, d=3, center=false);};
    translate([thickness+Espwidth-7,thickness+7,thickness]){cylinder(PcbHeight, d=3, center=false);};
};

module holes(){
    //DC Input
    translate([thickness+Espwidth-34,-1,thickness+PcbHeight]){cube([34,thickness+2,EspHeight], 0);};
    //Outputs
    translate([thickness+Espwidth-46,1+Espdepth,thickness+PcbHeight]){cube([46,thickness+2,EspHeight], 0);};
    //Fets
    translate([thickness-1,thickness+Espwidth-37,thickness+5+PcbHeight]){cube([2,37,EspHeight-5-PcbHeight+thickness+1], 0);};
};

module screw(){
    difference() {
        cube([8+ScrewBorder+ScrewBorder,8+ScrewBorder+ScrewBorder,EspHeight+PcbHeight], 0);
        translate([4+ScrewBorder, 4+ScrewBorder, (EspHeight+PcbHeight)/2+1.25
]) nutcatch_sidecut("M3", l=ScrewBorder+5, clk=0.4, clh=0.6, clsl=0.4);
	translate([4+ScrewBorder, 4+ScrewBorder, -1]) cylinder(EspHeight+PcbHeight+2, d=4, center=false);
    }
}

module screwplate(){
    translate([0-thickness-ScrewBorder-8, thickness+ScrewBorder+7, 0]) cube([Espwidth+thickness+thickness+8+ScrewBorder+ScrewBorder+8+ScrewBorder+ScrewBorder,Espdepth-ScrewBorder-7-ScrewBorder-7,thickness], 0);
}

module screwhole(){
    translate([(0-thickness-ScrewBorder-8)/2, thickness+ScrewBorder+8+5, -1]) cylinder(PcbHeight, d=ScrewHoleSize, center=false);
    translate([thickness+thickness+Espwidth-((0-thickness-ScrewBorder-8)/2), thickness+ScrewBorder+8+5, -1]) cylinder(PcbHeight, d=ScrewHoleSize, center=false);
    translate([(0-thickness-ScrewBorder-8)/2, thickness+thickness+Espwidth-thickness-ScrewBorder-8-5, -1]) cylinder(PcbHeight, d=ScrewHoleSize, center=false);
    translate([thickness+thickness+Espwidth-((0-thickness-ScrewBorder-8)/2), thickness+thickness+Espwidth-thickness-ScrewBorder-8-5, -1]) cylinder(PcbHeight, d=ScrewHoleSize, center=false);
}

module case(){
    difference(){
            box();
            holes();
    }
    screwplate();
    //screws
        translate([0, thickness+ScrewBorder+8, 0]) rotate([0,0,180]) screw();
        translate([0, thickness+Espdepth+ScrewBorder, 0]) rotate([0,0,180]) screw();
        translate([thickness+thickness+Espdepth, 0, 0]) screw();
        translate([thickness+thickness+Espdepth, thickness+Espdepth-ScrewBorder-8, 0]) screw();
}

difference() {
    case();
    screwhole();
}
    

