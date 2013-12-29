include <../variables.scad>;
module Infill_rhomtess(height){

	a = sqrt(2)*height;
	b = height;

	module Rhombus(){
		translate([0,0,-a/2]) linear_extrude(a)
		polygon( points=[ [0,b/2],[a/2,0],[0,-b/2],[-a/2,0] ],
				paths=[ [0,1,2,3] ]);
		
	}

	module Square_Pyramid(){
		polyhedron( points=[ [0,1,0],[1,0,0],[0,-1,0],[-1,0,0],[0,0,1]*b ],
					triangles=[ [4,0,1],[4,1,2],[4,2,3],[4,3,0],[0,3,1],[2,1,3] ]);
	}

	module Rhombic_Dodecahedron(){
		resize([a-infill_width,a-infill_width,(2*b)-infill_width]) 
		rotate([90,0,0])//Rotated 90 to prevent horizontal overhang
		hull(){
			Rhombus();
			rotate([0,90,0]) Rhombus();
			rotate([90,0,0]) Square_Pyramid();
			rotate([-90,0,0]) Square_Pyramid();
		}
	}

	for(z = [bbox[0][2]:2*b:bbox[1][2]+b],
		y = [bbox[0][1]:a:bbox[1][1]+(a/2)],
		x = [bbox[0][0]:a:bbox[1][0]+(a/2)]){
			translate([x,y,z]) Rhombic_Dodecahedron();
	}
	for(z = [bbox[0][2]+b:2*b:bbox[1][2]+2*b],
		y = [bbox[0][1]+(a/2):a:bbox[1][1]+a/2],
		x = [bbox[0][0]+(a/2):a:bbox[1][0]+a/2]){
			translate([x,y,z]) Rhombic_Dodecahedron();
	}

}
//Flat side to opposite side = a
//4 acute angles meeting point to opposite = 2*b
