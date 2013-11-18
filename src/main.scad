include <variables.scad>;

shell_width = 1.5;
eps_scale = 2;
eps = .00001;

module Model(){
	import(model_path);
}

module Section_View(plane){
	difference(){
		children(0);
		translate([plane[0]*model_size[0],
			plane[1]*model_size[1],
			plane[2]*model_size[2]])
			cube([model_size[0],model_size[1],model_size[2]]*eps_scale,center=true); 
	}
}

module Shell(){
	
	difference(){
		cube([model_size[0],model_size[1],model_size[2]]*epscale);
		Model();
	}
	
}

module Infill(){
	//Test Infill
	if(infill_mode==0){
		union(){
			children(0);
			rotate([0,30,0]) translate([10,10,0]) cube([2,2,60]);
		}
	}
}

module Trim(){
	difference(){
		children(0);
		difference(){
			translate([bbox[0][0]-model_size[0],bbox[0][1]-model_size[1],bbox[0][2]-model_size[2]]/2) scale(eps_scale) Model();
			Model();
		}
	}
}

//Trim() Infill() 
//Section_View() Shell() Model();  
//Section_View() Shell() Model();
//Section_View([1.2,0,0]) Model();
//Shell();
