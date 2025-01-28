# OpenSCAD Files


## Utilities
The `hp_utils.scad` file contains some code that helps me speed up prototyping using `OpenSCAD`. 

1. Defines custom `move` and `mirror` commands that work with my mental models for shaping components. 
1. Some code to add filets in drawings
    - Filets create nicer paths for 3D printer printheads. 
    - The package [Round Anything](https://github.com/Irev-Dev/Round-Anything) is powerful but overkill for what I needed. The `minkowski` function is also not suitable.

Future additions:

- Hinges
- Boxes with lids screwed in at corners
- Boxes with snap-fit lids

## Projects

- LiDAR Bot
