include <../variables.scad>;
module Infill_rhomtess(height){

	a = 2*sqrt(2)*(height/2);
	b = 2*(height/2);

	module Rhombus(){
		translate([0,0,-a/2]) linear_extrude(a)
		polygon( points=[ [0,b/2],[a/2,0],[0,-b/2],[-a/2,0] ],
				paths=[ [0,1,2,3] ]);
		
	}

	module Square_Pyramid(){
		polyhedron( points=[ [0,1,0],[1,0,0],[0,-1,0],[-1,0,0],[0,0,2] ],
					triangles=[ [4,0,1],[4,1,2],[4,2,3],[4,3,0],[0,3,1],[2,1,3] ]);
	}

	module Rhombic_Dodecahedron(){
		difference(){
			hull(){
				Rhombus();
				rotate([0,90,0]) Rhombus();
				rotate([90,0,0]) Square_Pyramid();
				rotate([-90,0,0]) Square_Pyramid();
			}
			scale([1,1,1,]*0.99) hull(){
				Rhombus();
				rotate([0,90,0]) Rhombus();
				rotate([90,0,0]) Square_Pyramid();
				rotate([-90,0,0]) Square_Pyramid();
			}
		}
	}

	for(z = [bbox[0][2]:a:bbox[1][2]+a],
		y = [bbox[0][1]:b:bbox[1][1]+b],
		x = [bbox[0][0]:a:bbox[1][0]+a]){
			translate([x,y,z]) Rhombic_Dodecahedron();
	}

}
