bbox = [[0,0,0],[1,1,1]];
modelpath = "../models/sphere.off";

module infill(type){
	if(type==1){
		union(){
			child();
			translate([-1,-1,-10]) cube([2,2,20]);
		}
	}
}

module model(){
	import(modelpath);
}


module section_view(){
	difference(){
		child();
		translate([0,-15,-15]) cube([30,30,30]);
	};
}


//section_view()
module shell(){
	difference(){
		child();
		scale(0.9) model();
	};
}

section_view() infill(1) shell() model();
