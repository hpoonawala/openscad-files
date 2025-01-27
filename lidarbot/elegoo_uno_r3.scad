// $fa = 1;
// $fs = 0.4;
// arduino shape
arduino_hole_radius=1.6+0.127/2;  
arduino_length = 68.6;
arduino_width = 53.3;
// arduino holes relative to arduino shape 
module elegoo_uno_r3_plan(){
	translate([15.3,2.5]){
		translate([0,0])circle(r=arduino_hole_radius);
		translate([0,15.2+27.9+5.1])circle(r=arduino_hole_radius);  
		translate([50.8,5.1])circle(r=arduino_hole_radius);  
		translate([50.8,5.1+27.9])circle(r=arduino_hole_radius);
	}
}  

