include <../hp_utils.scad>
$fa=10;
$fs=0.1;
n_height = 1;
module baseplate_profile(){ // seems unused
	translate([0.25,0])polygon([[0,0],[2.85,0],[2.85,4.65],[0.7,2.5],[0.7,0.7]]);
	// 2.85+0.25+0.6
}

module binbase_profile(wall_thickness=1.2,floor_height=2){
	// The bottom should add 0.8 mm to the base, so that we have 41.5 = 3.75 + 34 + 3.75
	polygon([[0,floor_height+0.8],[-0.8,floor_height],[-0.8,0],[0,0],[0.8,0.8],[0.8,2.6],[0.8+2.15,2.6+2.15],[0.8+2.15,7],[2.95-wall_thickness,7],[2.95-wall_thickness,0.8+floor_height+0.8+2.15-wall_thickness]]);
	translate([-0.8,0])square([0.8,1]);
}

module lip_profile(wall_thickness=1.2){
	// profile of lip at the upper part to allow a bin to stack on top
	translate([0.35,14+7*n_height])polygon([[0,0],[0.7,0.7],[0.7,2.5],[2.6,4.4],[2.6,0],[2.6,-2.6],[2.6-wall_thickness,-2.6],[0,-wall_thickness]]);
	// actual wall:
	translate([0.35+2.6-wall_thickness,7])square([wall_thickness,4.4+7*n_height]);
}

// Assemble profiles. 3D is perhaps a misnomer
module baseplate_3D(){
	move(x=0.8){
		//translate([0,-10])baseplate_profile();
		binbase_profile(1.0,2);
		lip_profile(1.0);
	}
}
// extrude assembled profile to get bin walls
mirrorx()move(x=17)mirrory(){
	move(y=17,x=-17)move(rz=90)move(rx=90)lin_ext(H=17.0)baseplate_3D();
	move(rx=90)lin_ext(H=17.0)baseplate_3D();
	move(y=17)rot_ext(A=90)baseplate_3D();
}
// bottom plate
mirror4()cube([17.0,17.0,2.0]);
