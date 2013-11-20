include <variables.scad>;
include <infills/spherepack.scad>;

shell_width = 1.5;
eps_scale = 2;
eps = .00001;
I1_radius=20;

module Model(){
	import(model_path);
}

module Universe(uscale){
		translate(bbox[0]+model_size/2) cube(model_size*eps_scale*uscale,center=true);
}

module Section_View(plane){
	difference(){
		children(0);
		translate([plane[0]*model_size[0], plane[1]*model_size[1], plane[2]*model_size[2]])
		Universe(1);
	}
}

module Shell(){
	
	difference(){
		Model();
		difference(){
			Model();
			minkowski(){
				difference(){
					Universe(2);
					Model();
				}
				cube(2*shell_width,center=true);
				//sphere(shell_width,$fn=6);
			}
		}
	}
	
}

module Infill(){
	//Test Infill
	if(infill_mode==0){
		union(){
			children(0);
			rotate([45,0,0]) translate([0,0,bbox[0][2]]*2) cube([2,2,model_size[2]*2]);
		}
	}
	//Sphere Pack
	if(infill_mode==1){
		Trim()
			union(){
				children(0);
				Infill_spherepack(I1_radius);
			}
	}
}

module Trim(){
	difference(){
		children(0);
		difference(){
			Universe(3);
			Model();
		}
	}
}

Section_View([1,0,0]) Infill() Shell() Model();
