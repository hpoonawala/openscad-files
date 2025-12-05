# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [1.0.1] 

### Changed 

- The 3D printed board that mounts the RPLiDAR and RealSense now has longer spacers built-in. The spacers are required because the metal spacers used currently are too short. Without spacers the board would push down on the Raspberry Pi below it while being screwed in. 

## [1.0.0] 

### Changed 

- Custom motor driver board that replaces the `AtomMotionBase`. `AtomS3Lite` still used as companion controller.
- Replaced mount for `AtomMotionBase` with a custom mount.
- 3D printed components for carrying the battery case that powers the motors.

### Added 

- `custom_amb.scad` : `OpenSCAD` file for the custom mount

## [0.0.0] 

Undocumented
