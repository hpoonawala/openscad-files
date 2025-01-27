    // Wheel Diameter: 32.4mm / 1.3"
    // Wheel Thickness: 14.2mm / 0.56"
    // Bottom Plate: 32mm x 38mm / 1.26" x 1.5"
    // Height: 42mm / 1.65"
    // Mounting Holes Distance: 30mm x 24.3mm / 1.2" x 0.96"
    // Weight: 45.7g
// Caster
hole_sep_caster_L = 30;
hole_sep_caster_W = 24.3;
hole_rad_caster = 1.67;

caster_L = 38;
caster_W = 32;
caster_H = 2;

module caster_board(){
	lin_ext(caster_H)difference(){
		rounded_rect(caster_L,caster_W,2.54);
		hole_pattern_caster();
	}
}

module hole_pattern_caster(r = hole_rad_caster){
	mirror4()move(x=hole_sep_caster_L/2,y=hole_sep_caster_W/2)circle(r);
}

