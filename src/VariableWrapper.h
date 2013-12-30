#define BUFSIZE 10240

namespace VariableWrapper
{

	void Write_to_openscad(char tpath[],double bbox[2][3], char modelpath[], int infillmode, Polyhedron model, std::vector<Point> i4points){

		char path[BUFSIZE];
		strcpy(path,tpath);
		strcat(path,"variables.scad");
		std::ofstream varout(path);
		std::cout<<"Absolute path to variables.scad: "<<path<<std::endl;
		char buffer[BUFSIZE];

		snprintf(buffer,BUFSIZE,"bbox = [[%f,%f,%f],[%f,%f,%f]];",bbox[0][0], bbox[0][1], bbox[0][2], bbox[1][0], bbox[1][1], bbox[1][2]);
		varout<<buffer<<std::endl;

		snprintf(buffer,BUFSIZE,"model_size = [%f,%f,%f];", bbox[1][0]-bbox[0][0],bbox[1][1]-bbox[0][1],bbox[1][2]-bbox[0][2]);
		varout<<buffer<<std::endl;

		snprintf(buffer,BUFSIZE,"model_path = \"%s\";", modelpath);
		varout<<buffer<<std::endl;
		
		snprintf(buffer,BUFSIZE,"infill_mode = %d;", infillmode);
		varout<<buffer<<std::endl;

		std::string points = "model_points = [";
		for( Point_iterator p = model.points_begin(); p != model.points_end(); ++p ){
			snprintf(buffer,BUFSIZE,"[%f,%f,%f],",p->x(),p->y(),p->z());
			points+=buffer;
		}
		points[points.length()-1]=']';
		points+=";";
		varout<<points<<std::endl;

		points = "i4_points = [";
		for( std::vector<Point>::iterator p = i4points.begin(); p != i4points.end(); ++p){
			snprintf(buffer,BUFSIZE,"[%f,%f,%f],",p->x(),p->y(),p->z());
			points+=buffer;
		}
		points[points.length()-1]=']';
		points+=";";
		varout<<points<<std::endl;

		return;
	}


	int Fetch_I4_mindist(char tpath[]){
		
		char path[BUFSIZE];
		strcpy(path,tpath);
		strcat(path,"configuration.scad");
		std::ifstream configin(path);
		std::cout<<"Absolute path to configuration.scad: "<<path<<std::endl;
		std::string line;
		while(1){
			std::getline(configin,line);
			if(line.find("I4_mindist") != std::string::npos){
				std::cout<<"I4_mindist equals "<<line.substr( line.find("=")+1, line.length()-line.find("=")-2 )<<std::endl;
				return atoi(line.substr( line.find("=")+1, line.length()-line.find("=")-2 ).c_str());
			}
		}
		std::cout<<"Error: I4_mindist not found in configurationscad"<<std::endl;
	
	}

}
