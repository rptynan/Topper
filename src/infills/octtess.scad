module Infill_octtess(side){

	a=side/2;
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
		difference(){
			intersection(){
				Octohedron();
				rotate([0,0,45]) cube(step,center=true);
			}
			resize([1,1,1]*(step-infill_width/2)) intersection(){
				Octohedron();
				rotate([0,0,45]) cube(step,center=true);
			}
		}
	}

	module disz(){
		for(z = [bbox[0][2]:step:bbox[1][2]+step]){
			translate([0,0,z]) Truncated_Octohedron();
		}
	}

	module disx(){
		for(x = [bbox[0][0]:step+b/2:bbox[1][0]+step]){
			translate([x,0,0]) children(0);
		}
		for(x = [bbox[0][0]+(step+b/2)/2:step+b/2:bbox[1][0]+step]){
			translate([x,0,(2*b)/3]) children(0);
		}
	}
	
	module disy(){
		for(y = [bbox[0][2]:step+b/2:bbox[1][2]+step]){
			translate([0,y,0]) children(0);
		}
		for(y = [bbox[0][2]+(step+b/2)/2:step+b/2:bbox[1][2]+step]){
			translate([0,y,(2*b)/3]) children(0);
		}
	}

	disy() disx() disz();
}
