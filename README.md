# UCol-Educational-Robot
Educational robot recycled at Universidad de Colima


# Procedure to use the control interface of the

## manipulator

1. Execute the Matlab file GUI_Welcome.m, which opens a window with this name that describes the robot manipulator.
2. Click on the blue information icon, whose symbol is “!”.
3. Press the green button called “Empezar” or Start in English, which loads the control interface, as well as the Simulink files corresponding to the vision and control of the manipulator.

## Control interface

* The user can observe the objects and their positions by sequentially pressing the Activate Webcam and Show Image buttons. On the other hand, pressing the Deactivate Wencam button stops acquiring data from the camera.

* The robot moves to its initial position using the Activate Home button. This button must be pressed to start using the manipulator, or after it has finished its work. On the other hand, the Deactivate Home button omits the manipulator initialization routine.

* Once the manipulator is in its initial position, press the Start Experiment button, which activates the Red, Yellow, Circle and Square buttons. Select the color and shape of the object, and then press the Search button so that the manipulator goes to the object and picks it up. It is necessary to select the shape and color of the object, otherwise the manipulator will not move; this routine can be repeated until the manipulator has collected all the objects.

* The Stop button is used to finish the manipulator routine and to stop all Matlab-Simulink programs.
