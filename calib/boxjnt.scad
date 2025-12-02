$fa=1;
$fs=0.4;
// Creates a nice macro for movements//from manual
module move(x=0,y=0,z=0,rx=0,ry=0,rz=0)
{ translate([x,y,z])rotate([rx,ry,rz]) children(); }
// Macro to repeat along x and/or y
module repeat(spacex=0,spacey=0){ children();move(x=spacex,y=spacey)children(); }
module mirrorx(){ children(); mirror([1,0,0]) children(); }//mirror across x (+x -> -x)
module mirrory(){ children(); mirror([0,1,0]) children(); }// mirror across y (+y -> -y)
module mirror4(){ mirrorx() mirrory() children(); }

module lin_ext(H=2)
{
	linear_extrude(height=H,convexity=10)children();
}

module joint_female(lw=3){
	lin_ext()mirrory(){
		difference()
		{
			mirrory()square([8,6]);
			mirrory()square([3,3]);
		}
	}
}
module joint_male(lw=3){

	lin_ext()move(x=-15){
		mirrory()square([8,6]);
		move(x=3)mirrory()square([8,lw]);
	}
}

repeat(spacex=30){
	move(y=-15){joint_male(3+0.2);joint_female(3-0.2);}
	move(y=-2*15){joint_male(3+0.1);joint_female(3-0.1);}
	joint_male();joint_female();
	move(y=15){joint_male(3-0.1);joint_female(3+0.1);}
	move(y=2*15){joint_male(3 - 0.2);joint_female(3+0.2);}
	move(y=3*15){joint_male(3 - 0.3);joint_female(3+0.3);}
	move(y=4*15){joint_male(3 - 0.4);joint_female(3+0.4);}
	move(y=5*15){joint_male(3 - 0.5);joint_female(3+0.5);}
}
