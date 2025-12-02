// Want to avoid having screws and nuts jutting out. 
// Need to get a better system for aligning top and bottom
// Started using modules, but the old method was so bad, going to redo in v6
$fa=1;
$fs=0.4;
include <../../libraries/BOSL/constants.scad>
use <../../libraries/BOSL/masks.scad>
box_opacity=0.7;
joystick_L = 33.3+0.5;
joystick_W = 26.69+0.6+1;
joystick_hole_radius = 3.5/2-0.5;//1.25
pcbjoystickgap = 2;
pcb_L = 70+1.0;//+0.8 was a press fit
pcb_W = 30+0.6;
pcb_hole_radius = 0.8;
wall_thickness = 2;

// Creates a nice macro for movements//from manual
module move(x=0,y=0,z=0,rx=0,ry=0,rz=0)
{ translate([x,y,z])rotate([rx,ry,rz]) children(); }

// mimics the move to center
module center_pcb(){
    move(x= -pcb_L/2,y=-pcb_W/2) children();
}
// But whhhhhhyyyyyyyyyy

module repeat(spacex=0,spacey=0){
    children(0);
    move(x=spacex,y=spacey)children(0);
}

// Creates two 'teeth' on the wall for locking with the cap
wall_height = 17;
repeat(spacey=pcb_W-3-6.3-3)
center_pcb()move(x=pcb_L,y=3,z = wall_height)linear_extrude(height=2,convexity=10)square([wall_thickness,6.3]); 

module base(H=2*wall_thickness+13){ // Base surrounding ESP module
    // 2*2+13 = 17 > 16 for tight, to account for USB height
	L = pcb_L+2*wall_thickness; 
	W = pcb_W+2*wall_thickness;
	color([0,0.5,0.2,box_opacity])translate([-L/2-joystick_L-pcbjoystickgap,-W/2,0])cube([L+joystick_L+pcbjoystickgap,W,H]); 
}

module esp_base(H=18){ // ESP module based	
    translate([-pcb_L/2,-pcb_W/2,wall_thickness])linear_extrude(height=H+0.1,convexity=10)square([pcb_L,pcb_W]); 
}
module joy_base(){ // Joystick base 
	color("red")translate([-joystick_L/2-pcbjoystickgap,-joystick_W/2]){
        dX = (joystick_L-26.5)/2;
        dY = (pcb_W - joystick_W)/2; 
        square([joystick_L+pcbjoystickgap+0.2,joystick_W]);
        polygon([[dX,0],[dX+dY,-dY],[joystick_L-dX-dY,-dY],[joystick_L-dX,0]]);
        polygon([[dX,+joystick_W],[dX+dY,dY+joystick_W],[joystick_L-dX-dY,dY++joystick_W],[joystick_L-dX,+joystick_W]]);
        //polygon([[0,0],[dX+dY,-dY],[joystick_L,0],[joystick_L-5,joystick_W],[0,joystick_W]]);
        
    }
}
module bod(){ // Create body 
	difference(){ // as difference 
		base();// of extruded base block
		translate([-joystick_L/2-pcb_L/2,0,wall_thickness])linear_extrude(height=20.3,convexity=10)joy_base();
		esp_base();
		//translate([0,0,-3])scale(0.8)esp_base();//cutout to save space
	}
}
// Assemble
difference(){
	union(){
		// extrude the suppoorts around the hole
		translate([-joystick_L-pcb_L/2-pcbjoystickgap,-joystick_W/2,wall_thickness+2])linear_extrude(height=5,convexity=10)joystick_hole_plan();
		#translate([-joystick_L-pcb_L/2-pcbjoystickgap,-joystick_W/2,wall_thickness])linear_extrude(height=5,convexity=10)joystick_hole_plan(joystick_hole_radius+0.5+0.5);
		bod();
	}
	usb_cutout();
	L = 70+4+33.3+50;
	repeat(spacey=2*17.3)translate([-33.3/2-5,-17.3,0])fillet_mask_x(L,2);
}


// Create a cover
//translate([0,-50,16])
translate([0,50,0])difference(){
	base(H=3);
	translate([-joystick_L/2-pcb_L/2,0,-0.2])linear_extrude(height=5.3,convexity=10)joy_base();	
	//translate([35-5+5,-5-1,-0.1])linear_extrude(height=5.3,convexity=10)square([10,12]);// Previous gap for the USB 
	L = pcb_L+2*wall_thickness+joystick_L+pcbjoystickgap+50;
	repeat(spacey=pcb_W+2*wall_thickness)translate([-joystick_L-pcbjoystickgap,-wall_thickness-pcb_W/2,3])fillet_mask_x(L,2);
	repeat(spacey=pcb_W-3-6.3-3)
	center_pcb()move(x=pcb_L,y=3,z = -0.05)linear_extrude(height=3.1,convexity=10)square([wall_thickness+0.1,6.3]); 
}

module joystick_hole_plan(hole_radius=joystick_hole_radius){
		//hole_radius=3.5/2+0.1;
		holesep_x = 26.5; holesep_y = 20;
		temp1 = (joystick_L-holesep_x)/2;
		temp2 = (joystick_W-holesep_y)/2;
		translate([temp1,temp2])
		repeat(spacex=holesep_x)
		repeat(spacey=holesep_y)
		circle(r=hole_radius); 
}
// USB CUTOUT
module usb_cutout(){
	translate([35+0.5+wall_thickness+0.1,-15,16.1])rotate([0,-90,0])rotate([0,0,90])linear_extrude(height=5,convexity=10){
		repeat(spacey=5)translate([9,-5])square([12,5]);
		//translate([9,0])square([12,5]);
	}
}

