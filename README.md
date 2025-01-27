# OpenSCAD Files

This repo contains some code that helps me speed up prototyping using `OpenSCAD`. 

- `hp_utils.scad`
    1. Defines custom `move` and `mirror` commands that work with how I construct my designs in my head. 
    1. Some code to add filets in drawings
        - Filets create nicer paths for 3D printer printheads. 
        - The package [Round Anything](https://github.com/Irev-Dev/Round-Anything) is powerful but overkill for what I needed. The `minkowski` function is also not suitable.

Future:

- Hinges
- Boxes with lids screwed in at corners
- Boxes with snap-fit lids
