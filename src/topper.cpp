#include <iostream>
#include <vector>
#include <fstream>
#include <cstring>

#include <CGAL/Simple_cartesian.h>
#include <CGAL/Polyhedron_3.h>
#include <CGAL/IO/Geomview_stream.h>
#include <CGAL/IO/Polyhedron_iostream.h>
#include <CGAL/IO/Polyhedron_geomview_ostream.h>

typedef CGAL::Simple_cartesian<double> Kernel;
typedef CGAL::Polyhedron_3<Kernel> Polyhedron;
typedef Polyhedron::Vertex_iterator Vertex_iterator;

#include "VariableWrapper.h"


int main(int argc, char *argv[]){
	

//Input and path findings
	//Start and checks
	char abspathuser[BUFSIZE], abspathmodel[BUFSIZE], abspathexec[BUFSIZE];
	if( argc<2 ){
		std::cout<<"Model path not specified"<<'\n';
		return 0;
	}
	//User's pwd
	realpath(".",abspathuser);
	strcat(abspathuser,"/");
	std::cout<<"Absolute path to user's directory: "<<abspathuser<<std::endl;
	//Model's path
	strcpy(abspathmodel,abspathuser);
	strcat(abspathmodel,argv[1]);
	std::cout<<"Absolute path to model: "<<abspathmodel<<std::endl;
	//Executable's path
	strcpy(abspathexec,abspathuser);
	strcat(abspathexec,argv[0]);
	abspathexec[strlen(abspathexec)-6]='\0';
	std::cout<<"Absolute path to executable's directory: "<<abspathexec<<std::endl;
	//More checks
	if( argc<3 ){
		std::cout<<"Infill not specified"<<'\n';
		return 0;
	}
	int infillmode = atoi(argv[2]);


//Loading model into CGAL
	std::ifstream modelin(abspathmodel);
	Polyhedron model;
	modelin>>model;
	double bbox[2][3];	//bbox[min,max][x,y,z]
	for( Vertex_iterator v = model.vertices_begin(); v != model.vertices_end(); ++v ){
		if( v->point().x() < bbox[0][0] ) bbox[0][0] = v->point().x();
		if( v->point().y() < bbox[0][1] ) bbox[0][1] = v->point().y();
		if( v->point().z() < bbox[0][2] ) bbox[0][2] = v->point().z();
		if( v->point().x() > bbox[1][0] ) bbox[1][0] = v->point().x();
		if( v->point().y() > bbox[1][1] ) bbox[1][1] = v->point().y();
		if( v->point().z() > bbox[1][2] ) bbox[1][2] = v->point().z();
	}


//Transfer to OpenSCAD
		VariableWrapper::Fetch_I4_mindist(abspathexec);
        VariableWrapper::Write_to_openscad(abspathexec,bbox,abspathmodel,infillmode,model);


//Starting Geomview
	std::getchar();
	CGAL::Geomview_stream gview(CGAL::Bbox_3(bbox[0][0],bbox[0][1],bbox[0][2],bbox[1][0],bbox[1][1],bbox[1][2]));
	gview.set_bg_color(CGAL::Color(0, 200, 200));
	//gview.clear();
	gview<<CGAL::VIOLET<<model;

//Pause at end
	std::getchar();
	return 0;

}
