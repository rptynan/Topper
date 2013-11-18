#define BUFSIZE 1024

namespace VariableWrapper
{

	void Write_to_openscad(char path[],double bbox[2][3], char modelpath[], int infillmode){

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

		return;
	}

}
