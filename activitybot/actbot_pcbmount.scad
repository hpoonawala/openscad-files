$fa = 1;
$fs = 0.4;

hole_sep_actbot = 69.9;
hole_sep_pcb = 65;
hole_radius = 1.8;


// hole_pair(hole_radius,hole_sep)
module hole_pair(hole_radius=hole_radius,hole_sep = hole_sep_actbot){
linear_extrude(height=1){
        translate([0,hole_sep/2])circle(r=hole_radius);
        translate([0,-hole_sep/2])circle(r=hole_radius);
    }
}

// drilled_hole_pair(hole_radius,hole_sep,x_clr,y_clr)
module drilled_hole_pair(hole_radius=hole_radius,hole_sep = hole_sep_actbot,x_clr=1,y_clr=1){
difference(){
    L = 2*hole_radius+x_clr;
    W = hole_sep+2*hole_radius+y_clr;
    linear_extrude(height=1,convexity=5)translate([-L/2,-W/2])square([L,W]);
    translate([0,0,-0.01])scale([1,1,1.02])hole_pair(hole_radius,hole_sep_actbot);
}
}


// simple test:
//drilled_hole_pair(hole_radius,hole_sep_actbot);
//translate([10,0,0])hole_pair(hole_radius,hole_sep_actbot);

actpcb_L = 40+0.75;
actpcb_W = 70+1.25;
module actbot_pcb_outline(L=10,W=10){
    translate([-L/2,-W/2])square([L,W]);
}
module actbot_pcb_containter(wall_thickness=2,wall_height=2+4+9,base_thick=2){
    L = actpcb_L;
    W = actpcb_W;
    difference(){
        linear_extrude(height=wall_height,convexity=10)actbot_pcb_outline(L+wall_thickness,W+wall_thickness);
        translate([20,-20,base_thick+4])linear_extrude(height=20,convexity=10)square([10,40]);
        translate([0,0,base_thick])linear_extrude(height=wall_height-base_thick+0.1,convexity=10)actbot_pcb_outline(L,W);
        //translate([0,-30,0])cube([40,80,20]); //sectioner
        C_L = 30;
        C_W = 60;
        translate([-C_L/2,-C_W/2,-0.1])linear_extrude(height=3,convexity=10)square([C_L,C_W]);
    }
    translate([-actpcb_L/2,-actpcb_W/2,base_thick])linear_extrude(height=4.5,convexity=10)square([4,4]);
    translate([actpcb_L/2-2.5,actpcb_W/2-4,base_thick])linear_extrude(height=4.5,convexity=10)square([2.5,4]);
    translate([-actpcb_L/2,actpcb_W/2-4,base_thick])linear_extrude(height=4.5,convexity=10)square([4,4]);
    translate([actpcb_L/2-4,-actpcb_W/2,base_thick])linear_extrude(height=4.5,convexity=10)square([4,4]);

}
translate([actpcb_L/2*1.1+7,0,0])actbot_pcb_containter();

L = 10;
W = 76;
difference(){
linear_extrude(height=1.5,convexity=5)translate([0,-W/2])square([L,W]);
translate([3,0,-0.1])scale([1,1,2])hole_pair(hole_radius,hole_sep_actbot);
//translate([15,0,-0.1])scale([1,1,2])hole_pair(hole_radius,hole_sep_pcb);
}

translate([2.5,0,0])rotate([0,0,-90])linear_extrude(2)text("III",size=4,font="Times New Roman",halign="center");