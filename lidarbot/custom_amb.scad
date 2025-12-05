
// cAMB
hole_sep_cAMB_W = 16;
hole_loc_cAMB_L = 20;
hole_rad_cAMB = 4.85/2;

cAMB_W = 30.5;
cAMB_L = 70.5;
cAMB_H1 = 10.4;
cAMB_H2 = 10.3;

module cAMB_board(){
	lin_ext(cAMB_H1)difference(){
		rounded_rect(cAMB_L,cAMB_W,3);
		// hole_pattern_cAMB();
	}

}

module hole_pattern_cAMB(r = hole_rad_cAMB){ // two large mounting holes
	mirrory()move(x=cAMB_L/2-hole_loc_cAMB_L,y=hole_sep_cAMB_W/2)circle(r);
}

// cAMB_board();
//
//

// Designed a mount for the AtomicMotionBase that goes above the screw holes for the caster, with a seat to resolve push-pull
module cAMB_mount(){
	difference(){

		lin_ext(2)difference(){

			rounded_rect(40,77,2);
			{
				// move(x=cAMB_move)hole_pattern_cAMB(r=1.7);
				move(rz=90)hole_pattern_caster(); // Caster holes
				rounded_rect(20,20,2);// Hole above caster
			}
		}
		move(z=1.5)lin_ext(3)move(rz=90) hole_pattern_caster(3.1);

		// move(x=cAMB_move,z=2.5)lin_ext(3)rounded_rect(cAMB_L+0.2,cAMB_W+0.2,3);

	}
	difference(){

		move(z=1.49)lin_ext(3)move(rz=90) hole_pattern_caster(5);
		move(z=1.4)lin_ext(3.3)move(rz=90) hole_pattern_caster(3.1);
	}
	move(z=2)
		lin_ext(6)
		difference()
		{
			rounded_rect(40,77,2);// Walls of the board holder
			rounded_rect(30.6,70.6,0.25); // rect hole for board
			square([40,50],center=true);
		}
	lin_ext(2+6-1.5)mirror4()move(x=15,y=35)circle(3);
}
