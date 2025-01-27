
// DRV8833
hole_sep_DRV8833_L = 0.8*25.4;
hole_sep_DRV8833_W = 0.5*25.4;
hole_rad_DRV8833 = 1.67;

DRV8833_W = 0.7*25.4;
DRV8833_L = 1.0*25.4;
DRV8833_H = 2;

module DRV8833_board(){
	lin_ext(DRV8833_H)difference(){
		rounded_rect(DRV8833_L,DRV8833_W,2.54);
		hole_pattern_DRV8833();
	}
}

module hole_pattern_DRV8833(r = hole_rad_DRV8833){
	mirrorx()move(x=hole_sep_DRV8833_L/2,y=hole_sep_DRV8833_W/2)circle(r);
}

