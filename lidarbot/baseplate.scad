// Base plate
module base_plate(){
	lin_ext(base_height)difference(){ 
		rounded_rect(base_length,base_width,2); 
		//mirrory()move(x=20,y=10)circle(3/2);
		rounded_rect(mtr_mnt_L,mtr_mnt_W,2); 
	}
}

