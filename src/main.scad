include <variables.scad>;
include <configuration.scad>;
include <infills/spherepack.scad>;
include <infills/octtess.scad>;
include <infills/rhomtess.scad>;
include <infills/dynkowski.scad>;


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

//Hollows the model to make the shell
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
				//Using the sphere is more computationally intensive
				cube(2*shell_width,center=true);
				//sphere(shell_width,$fn=6);
			}
		}
	}
}
  
//Trims off any infill outside the model
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
		difference(){
			Model();
			Trim() Infill_octtess(I2_side);
		}
	}
	//Rhombic Dodecahedron Pack
	if(infill_mode==3){
		difference(){
			Model();
			Trim() Infill_rhomtess(I3_height);
		}
	}
	//Dynamic Minkowski Support
	if(infill_mode==4){
		Trim() Infill_dynkowski(I4_size,I4_points);
	}
}




Section_View([1,0,0]) 
union(){
	color("Turquoise",0.5) Infill();
	color("Orange",0.5) Shell() Model();
};
