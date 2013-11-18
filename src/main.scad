include <variables.scad>;

shell_width = 1.5;
eps_scale = 2;
eps = .00001;

module Model(){
	import(model_path);
}

module Section_View(){
	difference(){
		children(0);
		translate([bbox[0][0]-2+(model_size[0]/2),
				bbox[0][1]-model_size[1]/2,
				bbox[0][2]-model_size[1]/2]) 
			scale(eps_scale) 
			cube([model_size[0],model_size[1],model_size[2]]); }
}

module Shell(){
	difference(){
		children(0);
		//#resize([model_size[0]-2*shell_width, model_size[1]-2*shell_width, model_size[2]-2*shell_width])
		#scale(0.8)
		//translate([0.5,0.5,0.5]*shell_width)
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
Section_View() Shell() Model();
