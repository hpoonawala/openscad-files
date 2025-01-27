
// AMB
hole_sep_AMB_W = 16;
hole_loc_AMB_L = 20;
hole_rad_AMB = 4.85/2;

AMB_W = 24;
AMB_L = 72;
AMB_H1 = 10.4;
AMB_H2 = 10.3;

module AMB_board(){
	lin_ext(AMB_H1)difference(){
		rounded_rect(AMB_L,AMB_W,3);
		hole_pattern_AMB();
	}
	#repeat(x=-30)move(z=AMB_H1)lin_ext(AMB_H2)square([5,20],center=true);

}

module hole_pattern_AMB(r = hole_rad_AMB){ // two large mounting holes
	mirrory()move(x=AMB_L/2-hole_loc_AMB_L,y=hole_sep_AMB_W/2)circle(r);
}

// AMB_board();
