module Infill_dynkowski(size, points){

	module Square_Pyramid(p){
		center = [bbox[0][0]+model_size[0]/2,bbox[0][1]+model_size[1]/2,bbox[0][2]+model_size[2]/2];
		polyhedron( points=[ center+[0,1,0], center+[1,0,0], center+[0,-1,0], center+[-1,0,0], p ],
					triangles=[ [4,0,1],[4,1,2],[4,2,3],[4,3,0],[0,3,1],[2,1,3] ]);
	}

	minkowski(){
		for(p = points){
			Square_Pyramid(p);
			//translate(p) cube(2);
		}
		cube(size);
	}

}
