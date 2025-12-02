// Want to avoid having screws and nuts jutting out. 
// Need to get a better system for aligning top and bottom
// Started using modules, but the old code was so bad, going to redo in v6
// Adding mirroring. Building symmetric things centered wrt axis makes sense, but shifting was a bad way to do it, modules or not. Mirror across y instead of shift. 

// $fa=1;
// $fs=0.4;
include <../../libraries/BOSL/constants.scad>
use <../../libraries/BOSL/masks.scad>
include <../../hp_utils.scad>
box_opacity=0.7;
joystick_L = 33.3+0.5;
joystick_W = 26.69+0.6+1;
joystick_hole_radius = 3.5/2-0.5;//1.25
pcbjoystickgap = 2;
pcb_L = 70+1.0;//+0.8 was a press fit
pcb_W = 30+0.6;
wall_thickness = 2;
wall_height=17;

base_length = pcb_L+2*wall_thickness+joystick_L+pcbjoystickgap;
base_width = pcb_W+2*wall_thickness;

module base_box(H=wall_height){ // Base 
	color([0,0.5,0.2,box_opacity]) move(x=-wall_thickness)mirrory()cube([base_length+wall_thickness,base_width/2,H]); 
}

module esp_plan(){mirrory()square([pcb_L,pcb_W/2]); } // ESP module based
module joy_base(){ // Joystick base 
	dX = (joystick_L-26.5)/2;
	dY = (pcb_W - joystick_W)/2; 
	mirrory(){
		square([joystick_L+pcbjoystickgap+0.2,joystick_W/2]); //2 mm accounts for board asymmetry along x, 0.2 for removing thin
		polygon([[dX,+joystick_W/2],[dX+dY,dY+joystick_W/2],[joystick_L-dX-dY,dY+joystick_W/2],[joystick_L-dX,+joystick_W/2]]);
	}
}

module bod(){ // Create body 
	difference(){ // as difference 
		base_box();// of extruded base block
		move(x=wall_thickness,z=wall_thickness){
			linear_extrude(height=wall_height,convexity=10)joy_base();
			move(x=pcbjoystickgap+joystick_L)linear_extrude(height=wall_height,convexity=10)esp_plan();
		}//translate([0,0,-3])scale(0.8)esp_base();//cutout to save space
	}
	move(z=wall_thickness)linear_extrude(height=5,convexity=10)joystick_hole_plan();
	move(z=wall_thickness)linear_extrude(height=3,convexity=10)joystick_hole_plan(joystick_hole_radius+0.5+0.5);
	// Creates two 'teeth' on the wall for locking with the cap
	repeat(x=-base_length)mirrory()move(x=base_length-wall_thickness,y=5.5,z = wall_height)linear_extrude(height=3,convexity=10)square([wall_thickness,6]); 

}

// Assemble
difference(){
	bod();
	usb_cutout();
	L = base_length+2+wall_thickness;
	mirrory()move(x=L/2-0.1-wall_thickness,y=base_width/2)fillet_mask_x(L,2); //fillet
}

// Create a cover
//translate([0,-50,17])
translate([0,50,0])difference(){
	base_box(H=3);
	move(x=wall_thickness,z=-0.05)linear_extrude(height=5.3,convexity=10)joy_base();	
	L = base_length+2+wall_thickness;
	mirrory()move(x=L/2-0.1-wall_thickness,y=base_width/2,z=3)fillet_mask_x(L,2);
	tolval = 0.15; // widens gap in cover 
	repeat(x=-base_length)mirrory()move(x=base_length-wall_thickness-0.05,y=5.5-tolval/2,z=-0.05)linear_extrude(height=3.1,convexity=10)square([wall_thickness+0.1,6+tolval/2]); 
}

module joystick_hole_plan(hole_radius=joystick_hole_radius){
	//hole_radius=3.5/2+0.1;
	holesep_x = 26.5; holesep_y = 20;
	move(x=joystick_L/2+wall_thickness)mirror4()move(x=holesep_x/2,y=holesep_y/2)circle(r=hole_radius); 
}

// USB CUTOUT
module usb_cutout(){
	move(x=base_length-wall_thickness-0.05,z=10)mirrory()cube([wall_thickness+0.1,5.5,7+0.1]);
}

