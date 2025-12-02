// Want to avoid having screws and nuts justting out. 
$fa=1;
$fs=0.4;
include <BOSL/constants.scad>
use <BOSL/masks.scad>
box_opacity=0.7;
joystick_L = 33.3+0.5;
joystick_W = 26.69+0.6;
joystick_clr = 1;
joystick_hole_radius = 3.5/2-0.25; // 1.5
pcbjoystickgap = 2;
pcb_L = 70+1.0;//+0.8 was a press fit
pcb_W = 30+0.6;
pcb_clear = 1;
pcb_hole_radius = 0.8;
wall_thickness = 2;
// You need to define translations instead of this manual calculation each time. 
// You can use the module+children feature, I believe.

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
	// Spacer under joystick
	//translate([-joystick_L/2-pcb_L/2-pcbjoystickgap,0,1])linear_extrude(height=2.5,convexity=10){
	//circle(r=2);
	//}
}
// Assemble
difference(){
	union(){
		// extrude the suppoorts around the hole
		translate([-joystick_L-pcb_L/2-pcbjoystickgap,-joystick_W/2,wall_thickness+2])linear_extrude(height=5,convexity=10)joystick_hole_plan();
        translate([-joystick_L-pcb_L/2-pcbjoystickgap,-joystick_W/2,wall_thickness])linear_extrude(height=5,convexity=10)joystick_hole_plan(joystick_hole_radius+0.5);
		//translate([-35,-15,2])linear_extrude(height=3,convexity=10)pcb_hole_plan();
		bod();
	}
	usb_cutout();
	L = 70+4+33.3+50;
	translate([-33.3/2-5,17.3,0])fillet_mask_x(L,2);
	translate([-33.3/2-5,-17.3,0])fillet_mask_x(L,2);
}


// Create a cover
//translate([0,-50,16])
translate([0,50,0])difference(){
base(H=3);
	translate([-joystick_L/2-pcb_L/2,0,-0.2])linear_extrude(height=5.3,convexity=10)joy_base();	
	translate([35-5+5,-5-1,-0.1])linear_extrude(height=5.3,convexity=10)square([10,12]);// Previous gap for the USB 
	L = pcb_L+2*wall_thickness+joystick_L+pcbjoystickgap+50;
	translate([-joystick_L-pcbjoystickgap,wall_thickness+pcb_W/2,3])fillet_mask_x(L,2);
	translate([-joystick_L-pcbjoystickgap,-wall_thickness-pcb_W/2,3])fillet_mask_x(L,2);
}

module joystick_hole_plan(hole_radius=joystick_hole_radius){
		//hole_radius=3.5/2+0.1;
		holesep_x = 26.5;
		holesep_y = 20;
		temp1 = (joystick_L-holesep_x)/2;
		temp2 = (joystick_W-holesep_y)/2;
		translate([temp1,temp2])circle(r=hole_radius);  
		translate([temp1+holesep_x,temp2])circle(r=hole_radius);  
		translate([temp1,temp2+holesep_y])circle(r=hole_radius);  
		translate([temp1+holesep_x,temp2+holesep_y])circle(r=hole_radius); 
}
// USB CUTOUT
module usb_cutout(){
	translate([35+0.5+wall_thickness+0.1,-15,16.1])rotate([0,-90,0])rotate([0,0,90])linear_extrude(height=5,convexity=10){
		translate([9,-5])square([12,5]);
		translate([9,0])square([12,5]);
	}
}

