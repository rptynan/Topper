module Infill_octtess(side){

	a=(3*side)/2;
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
		new = (3*side)*((step-infill_width)/step);
		resize([new,new,step-infill_width]) 
		intersection(){
			Octohedron();
			rotate([0,0,45]) cube(step,center=true);
		}
	}
	

	module disz(){
		for(z = [bbox[0][2]:step:bbox[1][2]+step]){
			translate([0,0,z]) Truncated_Octohedron();
		}
	}

	module disx(){
		for(x = [bbox[0][0]:4*side:bbox[1][0]+step]){
			translate([x,0,0]) children(0);
		}
		for(x = [bbox[0][0]+2*side:4*side:bbox[1][0]+2*side]){
			translate([x,0,-step/2]) children(0);
		}
	}
	
	module disy(){
		for(y = [bbox[0][2]:4*side:bbox[1][2]+2*side]){
			translate([0,y,0]) children(0);
		}
		for(y = [bbox[0][2]+2*side:4*side:bbox[1][2]+2*side]){
			translate([0,y,step/2]) children(0);
		}
	}

	disy() disx() disz();
	
}
//Half side length of pyramid or octohedron = a
//Side of octohedron / 3  = side = side of truncated octohedron
//Half height of octohedron or height of pyramid = b
//Square face to opposite Square face = step 
