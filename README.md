# Generation-of-Joint-Angles
Generate joint angles of a robotic manipulator according to the expected trajectory

Run the Project2_Final.m to generate the joint angles of the manipulaor, which can then be tested in RobotStudio. The .m file
takes 'arm' and 'trajectory' as the input to generate the 'angles' file. The first term in the first row of arm file is the 
number of links in the manipulator. The second term gives the lamda value for the damped least squares equation. 
The rows below give the lenghts of the various links. The first term in the first row of the trajectory file is the number of
intermediate frames generated for the trajectory, and the second term is again lambda. The rows below give the x and y 
co-ordinates for the tool-tip.
The check-angles file can be used to see the error in the expected posittion of the tool-tip  compared to the generated positions.
