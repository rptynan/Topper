#include <iostream>
#include <fstream>

#include <CGAL/Simple_cartesian.h>
#include <CGAL/Polyhedron_3.h>
#include <CGAL/IO/Geomview_stream.h>
#include <CGAL/IO/Polyhedron_iostream.h>
#include <CGAL/IO/Polyhedron_geomview_ostream.h>

typedef CGAL::Simple_cartesian<double> Kernel;
typedef CGAL::Polyhedron_3<Kernel> Polyhedron;


int main(int argc, char *argv[]){
	
	CGAL::Geomview_stream gview(CGAL::Bbox_3(-10,-10,-10,60,60,60));
	gview.set_line_width(4);
	gview.set_trace(true);
	gview.set_bg_color(CGAL::Color(0, 200, 200));
	//gview.clear();

	std::ifstream modelin(argv[1]);
	Polyhedron model;
	modelin>>model;
	
	gview<<CGAL::RED;
	gview<<model;

	std::getchar();
	return 0;

}
