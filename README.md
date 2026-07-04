# Portable EV Charging System

## Abstract
Imagine owning an electric vehicle (EV) that runs out of charge just before reaching your destination. In this situation, you may need to tow the vehicle to the nearest charging station or pay for a mobile EV charging service, both of which can be expensive and time-consuming. An emergency portable charging station stored inside the vehicle could provide enough temporary charge to safely reach the nearest charging station.

The system consists of an external battery to represent a portable emergency charging station, an EV battery model (plant), a DC-DC buck converter (actuator), a closed-loop CC-CV charging controller, thermal models for the EV battery and buck converter, SOC and CC-CV logic using Stateflow, and a feedback system to continuously monitor and regulate the charging process.

## Project Objectives
* Demonstrate the operation of a portable EV charging system.
* Verify that the EV battery charges successfully and the State of Charge (SOC) increases.
* Validate the closed-loop CC-CV charging strategy.
* Test the charging system using a commercial Panasonic lithium-ion cell.
* Test the charging system using a larger EV battery based on the 2024 Cadillac Lyriq battery specifications.
* Monitor the thermal behavior of the IGBT and EV battery during the charging process.

## Repository Structure
| Folder/File | Description |
|-------------|-------------|
| `images/` | System diagrams, subsystem figures, and simulation screenshots. |
| `tests/` | Simulation test cases and validation results. |
| `data/` | Battery parameter spreadsheets and supporting datasets. |
| `docs/` | Project presentation and additional documentation. |
| `main.m` | Main MATLAB script used to run the project. |
| `Portable_Charging_System.slx` | Main Simulink model of the portable EV charging system. |

## Required Software and Toolboxes
| Software / Toolbox |
|--------------------|
| MATLAB |
| Simulink |
| Simscape Electrical |
| Stateflow |

## System-Level Architecture (Block Level)
The figure below illustrates the closed-loop control system architecture of the portable EV charging system.

![Control System Block](images/Control%20System%20Block.png)

## Flowchart Architecture
![Closed-Loop Charging System Flowchart](images/Closed-Loop%20Charging%20System%20Flowchart.png)

## Subsystem Descriptions
### CC-CV Logic 
![CC-CV Logic Subsystem](images/cc_cv_logic.png)

Let's first talk about the CC-CV Logic subsystem and its purpose in this system-level design. Simply put, the subsystem first has to analyze the feedback loop of the output voltage of the EV system and decide between two modes: Mode 0 being CC mode and Mode 1 being CV mode. In this case, the output voltage must satisfy the condition of Vout ≥ 294.35V before transitioning to CV mode. In pseudocode, we can say if Vout < 294.35, then conduct using Mode 0 or CC mode; else, if Vout >= 294.35, transition the state from CC to CV mode or Mode 1. In the process, it has to continuously provide an output mode to the CC-CV Controller subsystem and decide, based on another threshold (we'll get to this), if it should switch between the controllers.

### Charge Termination Current Logic
![SOC Logic](images//SOC_logic.png)

Charge termination current logic is also another part of the CC-CV system and its characteristics. The purpose of this logic is to initiate a current cutoff once the battery is fully charged. In this experiment's case, I have modeled the termination current as C/10. C in this model represents the total capacity of the EV battery (309 Ah). C/10 outputs exactly 30.9 A. The condition of this Stateflow logic continues to operate in charging mode as long as the Iref output (CC-CV Controller current reference) is the same as the input reference, 35 A, representing the charging current. Once the system detects both Mode 1 (CV Mode) and Icharge ≤ 30.9 A, it transitions from Charging to Charging Finished, switching the current automatically to 0 A. This subsystem is particularly useful for handling battery overcharging in a CC-CV charging system.

### CC-CV Controller
## Testing and Verification

## Future Work

## References
MathWorks Documentation – Buck Converter Block
https://www.mathworks.com/help/sps/ref/buckconverter.html

EV Database – 2024 Cadillac Lyriq 600 E4 Specifications
https://ev-database.org/car/2243/Cadillac-Lyriq-600-E4

Panasonic Battery Group – NCR18500 Lithium-Ion Battery Datasheet
https://www.alldatasheet.com/datasheet-pdf/pdf/597037/PANASONICBATTERY/NCR18500.html

MathWorks Documentation – Buck Converter Thermal Model
https://www.mathworks.com/help/sps/ug/buck-converter-thermal-model.html

MathWorks Documentation – Battery State of Health Estimation
https://www.mathworks.com/help/simscape-battery/ug/battery-state-of-health-estimation.html




