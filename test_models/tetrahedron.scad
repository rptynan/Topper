a = 30;

polyhedron(
	points=[[+1,-1/sqrt(3),-1/sqrt(6)],
			[-1,-1/sqrt(3),-1/sqrt(6)],
			[0,2/sqrt(3),-1/sqrt(6)],
			[0,0,3/sqrt(6)] ]*a,
	triangles=[ [3,0,1],[3,1,2],[3,2,0],[0,2,1] ]
);  
