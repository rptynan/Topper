#include <iostream>
#include <fstream>

#include <CGAL/Simple_cartesian.h>
#include <CGAL/Polyhedron_3.h>
#include <CGAL/IO/Geomview_stream.h>
#include <CGAL/IO/Polyhedron_iostream.h>
#include <CGAL/IO/Polyhedron_geomview_ostream.h>

typedef CGAL::Simple_cartesian<double> Kernel;
typedef CGAL::Polyhedron_3<Kernel> Polyhedron;
typedef	Polyhedron::Vertex_iterator Vertex_iterator;


int main(int argc, char *argv[]){
	
	if( argc<2 ){
		std::cout<<"Model path not specified"<<'\n';
		return 0;
	}
	std::ifstream modelin(argv[1]);
	Polyhedron model;
	modelin>>model;

	double bbox[2][3]; //bbox[min,max][x,y,z]
	for( Vertex_iterator v = model.vertices_begin(); v != model.vertices_end(); ++v ){
		if( v->point().x() < bbox[0][0] ) bbox[0][0] = v->point().x();
		if( v->point().y() < bbox[0][1] ) bbox[0][1] = v->point().y();
		if( v->point().z() < bbox[0][2] ) bbox[0][2] = v->point().z();
		if( v->point().x() > bbox[1][0] ) bbox[1][0] = v->point().x();
		if( v->point().y() > bbox[1][1] ) bbox[1][1] = v->point().y();
		if( v->point().z() > bbox[1][2] ) bbox[1][2] = v->point().z();
	}
	
	CGAL::Geomview_stream gview(CGAL::Bbox_3(bbox[0][0],bbox[0][1],bbox[0][2],bbox[1][0],bbox[1][1],bbox[1][2]));
	gview.set_line_width(4);
	gview.set_trace(true);
	gview.set_bg_color(CGAL::Color(0, 200, 200));
	//gview.clear();
	
	gview.set_wired(true);
	gview<<CGAL::RED;
	gview<<model;

	std::getchar();
	return 0;

}
