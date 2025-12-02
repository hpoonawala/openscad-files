// Early mount system for custom board on activity bot

$fa = 1;
$fs = 0.4;

holed1 = 69.1;
holed2 = 65;
hole_radius = 1.65;

linear_extrude(height=2,convexity=10)difference(){
		square([holed1+2*hole_radius+2*3,20]);
        new_radius = 1.7;
		translate([3+hole_radius,3+hole_radius])scale(new_radius/1.65)circle(r=hole_radius);
		translate([3+hole_radius+holed1,3+hole_radius])scale(new_radius/1.65)circle(r=hole_radius);
		translate([3+hole_radius+4.1/2,3+hole_radius+10])scale(new_radius/1.65)circle(r=hole_radius);
		translate([3+hole_radius+holed2+4.1/2,3+hole_radius+10])scale(new_radius/1.65)circle(r=hole_radius);
	}

