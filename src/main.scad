include <variables.scad>;

shell_width = 1.5;

module model(){
	import(model_path);
}

module section_view(){
	difference(){
		children(0);
		translate([bbox[0][0],0,bbox[0][2]]) cube([model_size[0],model_size[1],model_size[2]]);
	};
}

module shell(){
	difference(){
		children(0);
		resize([model_size[0]-shell_width,model_size[1]-shell_width,model_size[2]-shell_width]) model();
	};
}


module infill(infill_mode){
	if(type==1){
		union(){
			children(0);
			translate([-1,-1,-10]) cube([2,2,20]);
		}
	}
}


resize(newsize=[30,60,10]) sphere(r=10);  
