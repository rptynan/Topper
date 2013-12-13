include <variables.scad>;
include <infills/spherepack.scad>;
include <infills/octtess.scad>;
include <infills/rhomtess.scad>;

$fn=6;
shell_width = 1.5;
nozzle_width = 0.5;
eps_scale = 2;
eps = .00001;
I1_radius=7;
I2_side=15;
I3_height=10;

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

module Normal_Fix(){
	difference(){
		children(0);
		translate(bbox[1]/2) cube([eps,eps,model_size[2]*eps_scale],center=true);
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

module Infill(){
	//Test Infill
	if(infill_mode==0){
			Trim() rotate([45,0,0]) translate([0,0,bbox[0][2]]*2) cube([2,2,model_size[2]*2]);
	}
	//Sphere Pack
	if(infill_mode==1){
		Trim() Infill_spherepack(I1_radius);
	}
	//Truncated Octohedron Pack
	if(infill_mode==2){
		Trim() Infill_octtess(I2_side);
	}
	//Rhombic Dodecahedron Pack
	if(infill_mode==3){
		Trim() Infill_rhomtess(I3_height);
	}

}




Section_View([1,0,0]) 
//Normal_Fix()
union(){
	Infill();
	Shell() Model();
};

