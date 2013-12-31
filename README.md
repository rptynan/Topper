Topper - Infills for your 3D models
===========================


Getting Started
-------------------
Clone the repo, make a build and compile, like so: 

    mkdir build && cd build
    cmake..
    >make;

After that you can run it like this:

    ./topper [input_model] [infill_number] [output_model]

Input models **must**  be in **.off** format, while output files can be in any format openscad supports (which are .stl / .off / .csg).

There are currently four infills, numbered below.

| Number | Infill                            | Picture         |
|:------:| --------------------------------- | --------------- |
| 1      | Sphere Packing                    | ![alt-text][I1] |
| 2      | Truncated Octohedron Tessellation | ![alt-text][I2] |
| 3      | Rhombic Dodecahedron Tessellation | ![alt-text][I3] |
| 4      | Dynamic Struct to Vertex Support  | ![alt-text][I4] |



----------------------------------------------------------------

[I1]:https://dl.dropboxusercontent.com/u/9795990/hosted_images/Github-Topper-Readme/1.png "1"
[I2]:https://dl.dropboxusercontent.com/u/9795990/hosted_images/Github-Topper-Readme/2.png "2"
[I3]:https://dl.dropboxusercontent.com/u/9795990/hosted_images/Github-Topper-Readme/3.png "3"
[I4]:https://dl.dropboxusercontent.com/u/9795990/hosted_images/Github-Topper-Readme/4.png "4"
