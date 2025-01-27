// A Chassis for mounting 2 TT motors, a motor driver (On AtomicMOtionBase), a microcontroller (ESP32S3 on AtomS3Lite), and sensors (realsense+RPLidar)
// Trying to mount the RPi and M5stack AtomicMotionBase
include <../hp_utils.scad>
include <mountplate.scad> // for motors
include <baseplate.scad>
include <DRV8833.scad>
include <atommotionbase.scad>
include <steel_caster.scad>
include <rpiplan.scad>
include <elegoo_uno_r3.scad>
include <RPLidarA1M8.scad>

// include <../../home/bday_bot/two_TT_motor_base.scad>

$fa=1;
$fs=0.4;


hole_radius = 1.8;
shaft_hole_radius = 3.1;
hole_separation = 17.5;
mount_thickness = 3;
motor_gap = 70;
base_height = 3;
base_length = 50+10;
base_width =31+40;
plate_width = 22.3+4; // old, for mount_plate

// the mounting square dimensions 
mtr_mnt_L = 33;
mtr_mnt_W= motor_gap-14;
mtr_mnt_H = 40;

// MOTOR MOUNT functions:
module hole_pattern_mount_flange(){
	mirrory()move(x=-21,y=14)circle(1.67);
}

module separator_hole_pattern(r=1.8){
	mirror4()move(x=28,y=32)circle(r);
}

upper_realsense_extend = 15+0;
caster_X = 48+30;
upper_caster_extend =5;

// LOWER BOARD to attach motors, RPi, AMB mount
module lower_board(){

	// motor mount pieces
	difference(){ 
		mirror4()move(rx=90)move(z=motor_gap/2+0.1)lin_ext(mount_thickness)polygon([[0,0],[23,0],[15,30],[0,30],[0,0]]);
		// Motor mount  holes:
		mirrory()move(x=-10,z = base_height+12,rx=90)lin_ext(mtr_mnt_W*1.2)holepattern(0,hole_radius,20.1,hole_separation);
	}

		mirrory()move(y=motor_gap/2+0.1,z = base_height)move(rz=180)linear_extrude(height=27,scale=0.5)move(x=-2)square([4,8]);
	// PLATFORM
	difference(){// 

		left_add = upper_realsense_extend ;
		right_add = 28+upper_caster_extend+10+30;
		lin_ext(base_height)difference(){
			move(x=(right_add - left_add)/2)rounded_rect(50+left_add+right_add,rpi_L,2); 
			rounded_rect(mtr_mnt_L-mount_thickness,mtr_mnt_W-mount_thickness,2); 
			move(x=45)rounded_rect(mtr_mnt_L-mount_thickness,mtr_mnt_W-mount_thickness,2); 
			move(x=caster_X,rz=90)hole_pattern_caster(); // Caster holes
			move(x=caster_X,rz=90)rounded_rect(20,20,2);// Hole above caster
			// moveArduino()elegoo_uno_r3_plan(); // Arduino holes
			separator_hole_pattern();
			move(x=-3)hole_pattern_rpi(); // RPi holes
			// move(x=-32)mirrory()move(y=10)circle(1.67); // potential realsense additional mount holes
			mirrory()move(x=-30,y=10)polygon([[0,35],[-35,35],[-35,0]]); // cutouts
			mirrory()move(x=35+30,y=12)polygon([[0,35],[35,35],[35,0]]); // cutouts
			// motorWireHoleDim = 18;
			// mirrory()move(x=40,y=15)polygon([[0,0],[0,motorWireHoleDim],[motorWireHoleDim,0]]); // cutouts
			// move(x=50+25)hole_pattern_AMB(r=1.67);
		}
	} 



}

module rsExtend(){
	// REALSENSE mount: 
	RS_mount_X = -25-3.2-upper_realsense_extend;
	move(x=RS_mount_X){
		lin_ext(10)difference(){
			circle(6.1);
			circle(3.2);
		}
			lin_ext(2)difference(){
				move(x=10+3.2)rounded_rect(20,30,2); 
			move(x=-32-RS_mount_X)mirrory()move(y=10)circle(1.67);
			}
	}
}

// UPPER BOARD to attach RPLidar and now RealSense
module upper_board(){
	main_L = 90;
	right_add = 0;
	left_add = 5;
	rplidar_xshift=5;
	difference(){// 
		uprbrd_W = mtr_mnt_W-mount_thickness+24;
		uprbrd_L = right_add+left_add+main_L;
		center_cutout_L = 50;
		center_cutout_W = 50;
		chamfer_size = 8;
		lin_ext(base_height)difference(){
			move(x=(right_add-left_add)/2)rounded_rect(uprbrd_L,uprbrd_W,2); 
			rounded_rect(center_cutout_L,center_cutout_W,2); 
			separator_hole_pattern();
			mirrory(){// Triangular cutout 
				move(x=right_add+main_L/2,y=uprbrd_W/2)polygon([[0,0],[-chamfer_size,0],[0,-chamfer_size]]);
				move(x=-left_add-main_L/2,y=uprbrd_W/2)polygon([[0,0],[chamfer_size,0],[0,-chamfer_size]]);
			}
			// mirrorx()move(x=25)rounded_rect(5,mtr_mnt_W-mount_thickness-25,2); //more cutouts
			move(x=-rplidar_xshift)rplidar_holeplan();
		}


	} 

		lin_ext(base_height+6)
			difference(){separator_hole_pattern(2.75);separator_hole_pattern();
			}

	// Build the front vertical plate with some ribs and holes for mounts. May need spacers for long M3 screws
	move(x=-left_add,rz=180)move(x=main_L/2){
		RSmountplate_W = 58;
		RSM_thick = 3; // real sense mount place thickness
		mirrory()move(y=RSmountplate_W/2-RSM_thick)move(rz=90)linear_extrude(height=20,scale=[1,RSM_thick/8.0])square([RSM_thick,8]);
		move(ry=-90)mirrory()lin_ext(RSM_thick)difference(){
			square([20,RSmountplate_W/2]);
			move(x=3+17/2,y=45/2)circle(1.67); // distance between M3 mount holes = 45mm
		}
	}
}


// Designed a mount for the AtomicMotionBase that goes above the screw holes for the caster, with a seat to resolve push-pull
module AMB_mount(){
	difference(){

			AMB_move = 12;
		lin_ext(4)difference(){

			left_add = 10-2;
			right_add = 15;
			move(x=(right_add - left_add)/2)rounded_rect(40+left_add+right_add,40,2);
			{
				move(x=AMB_move)hole_pattern_AMB(r=1.7);
				move(rz=90)hole_pattern_caster(); // Caster holes
				move(rz=90)rounded_rect(20,20,2);// Hole above caster
			}
		}
		move(z=1.5)lin_ext(3)move(rz=90) hole_pattern_caster(3.1);
		move(x=AMB_move,z=2.5)lin_ext(3)rounded_rect(AMB_L+0.2,AMB_W+0.2,3);

	}
}

module rpi(){
	cube([85,56,38]);
	move(z=38)cube([20,56,10]);
}



// Assembly
assembly = true;
// assembly = false;

if (assembly){ // ASSEMBLE
	color("green")move(z=40)move(rx=180){ 
		upper_board();
	}
	// color("orange")move(y=-25,rz=90)move(x=-mtr_mnt_L/2,y=-56/2)move(z=2)rpi();
	move(rx=180)lower_board();
	move(x=caster_X,z=0)AMB_mount();	
	// rsExtend();
}
else{         // LAYOUT
	move(y=0)upper_board();
	move(y=100)lower_board();
	move(x=caster_X)AMB_mount();	
	move(x=-50)rsExtend();
}


// Atomic Motion Base model for viz
// move(y=-100) AMB_board();
//

// Made spacers for the optical sensor mount
// lin_ext(6)
// 	difference(){separator_hole_pattern(2.75);separator_hole_pattern();
// 	}
