This folder contains the Matlab code for the path planning solution to 
the following problem:
Consider n disks of known radius in the plane, in the rectangle
[ 0,xmax ] * [ 0,ymax ] without any other object than the n disks. Find
a path from an initial position of the disks to a desired final 
position, assuming the disks are not in a collision situation, neither in
the initial nor in the final configuration.

Analysis:
- The configuration space of this problem has dimension 2n and is static
(obstacles in the configuration space are only those positions of the
disks where they interfere).
- The PRM is a good candidate method to solve the problem, as:
   ° Once the graph is built, the algorithm will be able to solve multiple
     queries.
   ° Interference between the disks is very easy to check.
   ° Configurations are easy to visualize in the plane, which is good for
     a teaching situation.
   ° Reasonable metrics can be defined over the configuration space because
     all the configuration variables are Cartesian variables.
     
There are two main programs:
   ° prmCreate: create a PRM.
   ° prmSearch: search for a path between to configurations, using a 
        previously created PRM.
        
The prmCreate saves the graph and the defining parameters in a mat file
named GraphResults.mat, that the user is free to rename if they want to 
keep it. 
Suggestion: name the file in a way that reminds the main parameters, 
e.g. 3disks_5000_configs_20_neighbors_xy, where xy is a number, in case 
several graphs are created with the same parameters. All this information 
is in the mat file, but it's a convenient naming convention.

The program prmSearch follows these steps:
   ° Choose an existing PRM from the "graph" sub-folder of the current folder.
   ° Generate two collision free random configurations.
   ° Connect them to the existing graph.
   ° If successful search for a path.
   ° Draw the path.
   
The program can be tailored for other uses, it is just meant as an 
illustration.
