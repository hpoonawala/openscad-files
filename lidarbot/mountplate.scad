// The design above is weird. Make the mounting plates
module mount_plate(){
	lin_ext(mount_thickness)difference(){
		move(x=-10){
			apply_fillet(-30/2,tt/2,1,90)apply_fillet(30/2,tt_motor_width/2,1)square([30,tt_motor_width],center=true); 
		}
 tt_hole_pattern();
		//move(x=5,y=5)repeat(y=hole_separation)circle(hole_radius); 
			}
}

module tt_hole_pattern(){
	mirrory()move(y=hole_separation/2)circle(hole_radius); 
	move(x=-21.1)circle(30);
}

///// Code to test hole pattern values
module holepattern(A,r,d,sep){
	move(rz=A){
		move(x=d)mirrory()move(y=sep/2)circle(r); 
		circle(shaft_hole_radius);
	}
}
