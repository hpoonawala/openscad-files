
include <../hp_utils.scad>
module rplidar_holeplan(r=1.5){
	mirrory(){
		move(x=42,y=20)circle(r);
		move(x=-28,y=28)circle(r);
	}
}
// lin_ext(5)rplidar_holeplan();

