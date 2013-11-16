#define BUFSIZE 256

namespace VariableWrapper
{

	void Write_to_openscad(std::string path,double bbox[2][3], char modelpath[], int infillmode){

		path.replace(path.begin()+path.find("topper"),path.end(),"variables.scad");

		std::ofstream varout(path.c_str());
		char buffer[BUFSIZE];

		snprintf(buffer,BUFSIZE,"bbox = [[%f,%f,%f],[%f,%f,%f]];",bbox[0][0], bbox[0][1], bbox[0][2], bbox[1][0], bbox[1][1], bbox[1][2]);
		varout<<buffer<<std::endl;

		snprintf(buffer,BUFSIZE,"model_path = \"%s\";", modelpath);
		varout<<buffer<<std::endl;
		
		snprintf(buffer,BUFSIZE,"infill_mode = %d;", infillmode);
		varout<<buffer<<std::endl;

		return;
	}

}
