$fa=1;
$fs=0.4;
// Creates a nice macro for movements//from manual
module move(x=0,y=0,z=0,rx=0,ry=0,rz=0)
{ translate([x,y,z])rotate([rx,ry,rz]) children(); }
// Macro to repeat along x and/or y
module repeat(x=0,y=0,z=0){ children();move(x=x,y=y,z=z)children(); }
module mirrorx(){ children(); mirror([1,0,0]) children(); }//mirror across x (+x -> -x)
module mirrory(){ children(); mirror([0,1,0]) children(); }// mirror across y (+y -> -y)
module mirrorz(){ children(); mirror([0,0,1]) children(); }// mirror across y (+y -> -y)
module mirror4(){ mirrorx() mirrory() children(); }

module lin_ext(H=2)
{
	linear_extrude(height=H,convexity=10)children();
}
module rot_ext(A=2)
{
	rotate_extrude(angle=A,convexity=10)children();
}

module fillet(r=1){
	// The corner of this shape is at the origin, and it lies in the third quadrant.
	// move to origin to corner to round the corner. Rotate as appropriate. 
	// remove this shape from 2d plan to get fillet.
	translate([-r,-r])difference(){
		square([r,r]);
		circle(r=r);
	}
}


module posfillet(r=1){
	// Corner to be fileted is not at the origin, center of circle is.
	// In some cases, the center of rounding is the reference point for applying the filet
	difference(){
		square([r,r]);
		circle(r=r);
	}
}

module apply_fillet(X=0,Y=0,r=1,A=0){
// A is the angle of the fillet
	difference(){
		children(0);
		move(x=X,y=Y)move(rz=A)fillet(r);
	}
}

module gen_fillet(r=1,A=60){
// A here is the half-angle of the corner being filleted
// A = 45 corresponds to regular quarter fillet
	difference(){
		polygon([[0,0],[-r/tan(A),0],[-r/tan(A)+r*sin(2*A),-r-r*cos(2*A)]]);
		move(x=-r/tan(A),y=-r)circle(r);
	}
}

module apply_gen_fillet(X=0,Y=0,r=1,A=0,B=45){
// A defines orientation of filet. Default means top right corner of square is being filleted (third quadrant in fillet frame)
// B here is the half-angle of the corner being filleted
// B = 45 corresponds to regular quarter fillet
	difference(){
		children(0);
		move(x=X,y=Y)move(rz=A)gen_fillet(r,B);
	}
}

module rounded_rect(L,W,r){ // creates a filleted quarter rect and mirrors to get a rounded rectangle
	mirror4()difference(){
		square([L/2,W/2]);
		move(x=L/2,y=W/2)fillet(r=r);
	}
}


module round_rect_fillet(L=5,W=5,r=1){ // assumes that the mass is in the second quadrant, and you want to cut out things close to the origin
	difference(){
		children(0);
		union(){
			mirror4()move(x=L/2-r,y=W/2-r)rotate_extrude(angle=90)move(x=r)children(1);
			mirror4()move(x=L/2,rx=90)linear_extrude(W/2+0.01-r)children(1);
			mirror4()move(y=-W/2,ry=90)linear_extrude(L/2+0.01-r)children(1);
		}
	}
}



module round_rect_fillet_int(L=5,W=5,r=1){ 
	union(){
		children(0);
		union(){
			mirror4()move(x=L/2-r,y=W/2-r)rotate_extrude(angle=90)move(x=r)children(1);
			mirror4()move(x=L/2,rx=90)linear_extrude(W/2+0.01-r)children(1);
			mirror4()move(y=-W/2,ry=90)linear_extrude(L/2+0.01-r)move(rz=180)children(1);
		}
	}
}

// For snapping box lids (
module tabs(tab_L=10,tab_W=2,ry=90,dx=10){ 
	//  tab_W is the thickness of the tab along $z$ when $ry=90$, tab_L is the width along $y$, 2*dx is the separation between the tabs.
	//  Typically you add tabs to one mating surface and remove same tab from the other mating surface, with some tolerance to enable snapping
	mirrorx()move(x=dx,ry=ry) {
		linear_extrude(tab_W/2,scale=[0,(tab_L-tab_W)/(tab_L)])square([tab_W,tab_L],center=true);
	}
}
