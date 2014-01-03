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
typedef Polyhedron::Point_iterator Point_iterator;
typedef CGAL::Point_3<Kernel> Point;

#include "VariableWrapper.h"


int main(int argc, char *argv[]){
	

//Input and path findings
	//Start and checks
	char abspathuser[BUFSIZE], abspathmodel[BUFSIZE], abspathexec[BUFSIZE], abspathoutput[BUFSIZE];
	if( argc!=4 ){
		std::cout<<"usage: topper [model] [infillnumber] [output]"<<'\n';
		return 0;
	}
	//User's pwd
	realpath(".",abspathuser);
	strcat(abspathuser,"/");
	std::cout<<"Absolute path to user's directory: "<<abspathuser<<std::endl;
	//Executable's path
	strcpy(abspathexec,abspathuser);
	strcat(abspathexec,argv[0]);
	abspathexec[strlen(abspathexec)-6]='\0';
	std::cout<<"Absolute path to executable's directory: "<<abspathexec<<std::endl;
	//Model's path
	if(argv[1][0]!='/' && argv[1][0]!='\\') strcpy(abspathmodel,abspathuser);
	strcat(abspathmodel,argv[1]);
	std::cout<<"Absolute path to input model: "<<abspathmodel<<std::endl;
	//Infill
	int infillmode = atoi(argv[2]);
	//Output path
	if(argv[3][0]!='/' && argv[3][0]!='\\') strcpy(abspathoutput,abspathuser);
	strcat(abspathoutput,argv[3]);
	std::cout<<"Absolute path to output: "<<abspathoutput<<std::endl;


//Loading model into CGAL
	std::ifstream modelin(abspathmodel);
	Polyhedron model;
	modelin>>model;
	double bbox[2][3];	//bbox[min,max][x,y,z]
	for( Point_iterator p = model.points_begin(); p != model.points_end(); ++p ){
		if( p->x() < bbox[0][0] ) bbox[0][0] = p->x();
		if( p->y() < bbox[0][1] ) bbox[0][1] = p->y();
		if( p->z() < bbox[0][2] ) bbox[0][2] = p->z();
		if( p->x() > bbox[1][0] ) bbox[1][0] = p->x();
		if( p->y() > bbox[1][1] ) bbox[1][1] = p->y();
		if( p->z() > bbox[1][2] ) bbox[1][2] = p->z();
	}

//Finding points not too near each other for dynkowski infill
	int mindist = VariableWrapper::Fetch_I4_mindist(abspathexec);
	bool baddist;
	std::vector<Point> i4points;
	std::vector<bool> visited(model.size_of_vertices());
	visited[0]=true;
	i4points.push_back(model.vertices_begin()->point());
	
	Point_iterator qp = model.points_begin();
	for( int q =0 ; qp != model.points_end(); ++q, ++qp ){
		
		baddist=false;
		Point_iterator vp = model.points_begin();
		for( int v = 0; v<visited.size(); ++v, ++vp){
			
			if( visited[v] && CGAL::squared_distance( *vp, *qp )/100 < mindist ){
				baddist=true;
			}
		}
		if(!baddist){
			i4points.push_back(*qp);
			visited[q]=true;
		}
	
	}

//Transfer to OpenSCAD
	VariableWrapper::Write_to_openscad(abspathexec,bbox,abspathmodel,infillmode,model,i4points);


//Starting Geomview
	if(0){
		std::getchar();
		CGAL::Geomview_stream gview(CGAL::Bbox_3(bbox[0][0],bbox[0][1],bbox[0][2],bbox[1][0],bbox[1][1],bbox[1][2]));
		gview.set_bg_color(CGAL::Color(0, 200, 200));
		//gview.clear();
		gview<<CGAL::VIOLET<<model;
		//Pause at end
		std::getchar();
	}

//Output from Openscad
	char cmd[BUFSIZE];
	snprintf(cmd,BUFSIZE,"openscad %smain.scad -o %s",abspathexec,abspathoutput);
	std::system(cmd);


	return 0;
}
