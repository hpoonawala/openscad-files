
// rpi
hole_sep_rpi_L = 58;
hole_sep_rpi_W = 49;
hole_rad_rpi = 2.5/2+0.17;

rpi_W = 56;
rpi_L = 85;
rpi_H = 2;

module rpi_board(){
	lin_ext(rpi_H)difference(){
		rounded_rect(rpi_L,rpi_W,2.54);
		hole_pattern_rpi();
	}
}

module hole_pattern_rpi(r = hole_rad_rpi){
	mirror4()move(x=hole_sep_rpi_L/2,y=hole_sep_rpi_W/2)circle(r);
}

