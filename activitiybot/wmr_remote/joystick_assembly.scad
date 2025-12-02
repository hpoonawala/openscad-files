$fa = 1;
$fs = 0.4;
hole_radius=3.5/2+0.1;
holesep_x = 26.5;
holesep_y = 20;
base_width = 26.69;
base_length = 33.30;
linear_extrude(height=1.9 ,convexity=10)difference(){
		square([base_length ,base_width]);
		temp1 = (base_length-holesep_x)/2;
		temp2 = (base_width-holesep_y)/2;

    translate([temp1,temp2])circle(r=hole_radius);  
    translate([temp1+holesep_x,temp2])circle(r=hole_radius);  
    translate([temp1,temp2+holesep_y])circle(r=hole_radius);  
    translate([temp1+holesep_x,temp2+holesep_y])circle(r=hole_radius);  
}
