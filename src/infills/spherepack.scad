module Infill_spherepack(radius){
	
	step = radius*2-radius/$fn; //divide by $fn, make sure low res spheres intersect
	
	for(x = [bbox[0][0]+radius+eps:step:bbox[1][0]+radius],
		y = [bbox[0][1]+radius+eps:step:bbox[1][1]+radius],
		z = [bbox[0][2]+radius+eps:step:bbox[1][2]+radius])
	{
		translate([x,y,z]) sphere(radius);
	}

}
		
