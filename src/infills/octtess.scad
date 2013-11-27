include <../variables.scad>
nozzle_width=0.5;
eps = .00001;

a=10;
b=1/sqrt(2)*(2*a);
step=(2/3)*b*2;

module Octohedron(){
	polyhedron(
		points=[ [a,a,0],[a,-a,0],[-a,a,0],[-a,-a,0],
				[0,0,b],[0,0,-b] ],
		triangles=[ [0,1,4],[2,0,4],[1,3,4],[3,2,4],
				[1,0,5],[0,2,5],[3,1,5],[2,3,5] ]
	);
}


module Truncated_Octohedron(){
	intersection(){
		Octohedron();
		rotate([0,0,45]) cube(step,center=true);
	}
}

module Infill_octtess(){
	for(x = [bbox[0][0]+step:step:bbox[1][0]+step],
		y = [bbox[0][1]+step:step:bbox[1][1]+step],
		z = [bbox[0][2]+step:step:bbox[1][2]+step])
	{
		translate([x,y,z]) Truncated_Octohedron();
	}
}


//Truncated_Octohedron();
Infill_octtess();
