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
![CC-CV Controller](images//CC_CV_controller.png)

The controller of any system is a very important piece of any control system design, as it allows the regulation of the system. In this case, I have designed a simple CC-CV Controller which uses switch logic to switch between Mode 0 (CC) and Mode 1 (CV). In the beginning of the experiment, the current error is given by $e_I = I_{ref} - I_{out}$, where $I_{ref}$ represents the charging current of 35 A and $I_{out}$ represents the EV battery charging output. The PI controller slowly drives this error to zero, allowing the system to regulate the current at 35 A.

Once the experiment transitions (this happens due to the CC-CV Logic implementation) to Mode 1 (CV Mode), the current controller is no longer active, and the voltage controller now regulates the output voltage. The same idea as before, the voltage error is given by $e_V = V_{ref} - V_{out}$, where $V_{ref}$ represents the reference voltage of 295 V, and $V_{out}$ represents the EV battery output voltage.

For the best explanation, let's think about an example to see how this controller might work. For instance, if the EV battery outputs 33.4 A (this could be due to oscillating factors or because it hasn't reached steady state), and we know the current reference is 35 A, it would produce a 1.6 A error in the system. The controller then increases the PWM duty cycle, allowing the buck converter to transfer more current to the system.

### External Portable Charger 
![](images//External_Portable_Battery_Power_Source.png)

The External Portable Battery Charger provides a parameterized value of a 430 V DC source. To allow the charging process to work, this value must always be greater than the EV battery's initial terminal voltage (approximately 294.8 V at 5% SOC before charging begins). Additionally, its battery capacity is modeled at 6.8 Ah, allowing it to store approximately 2.924 kWh of energy. This is an important parameter to know, especially in the design of more highly complex charging systems. We will get to a more detailed analysis in the EV Battery subsystem.

### EV Battery/Plant
![](images//EV_Battery_Plant.png)

Now that we know a little about what the External Portable Charger does, let's analyze the Plant of this control system design. The EV battery we have parameterized is an approximated model of the Cadillac Lyriq 2024 (all of the data information can be found in the data/ portion of this project). Since we couldn't model a much more detailed battery pack, which is usually done using cells in series and parallel with specific dimensions, we have constructed a much simpler Simscape model for the purpose of simulation time and simplicity. The EV battery nominal voltage is 350 V without any initial conditions. With the initial condition applied at 5% SOC, the voltage has decreased to approximately 294.8 V. The battery capacity is modeled as 309 Ah, providing approximately 108.15 kWh (when fully charged). Since we have modeled this experiment at 5% SOC, the EV battery stores approximately 5.41 kWh of energy and therefore needs approximately 102.74 kWh of additional energy to reach 100% SOC (fully charged). 

Now here is the interesting part of this EV vehicle. Since we know the portable charger stores around 2.924 kWh of energy, if we start our system with 5% SOC, it would take approximately 17 minutes for the portable charger capacity to become empty. This is constructed from the maximum charging power, 294.8 V × 35 A = 10.3 kW. Taking this value, 2.924 kWh / 10.3 kW = 0.284 hours ≈ 17 minutes (this is assuming ideal efficiency of the system). Thus, the system would go from 5% SOC to around 7.7% SOC, knowing that 2.924 kWh / 108.15 kWh × 100 ≈ 2.7%. This is all very important, as it allows us to compute how much mileage the external charger can provide to the EV battery until the capacity of the portable charger is empty. In this case, since the Cadillac Lyriq estimated energy consumption is around 314 Wh/mile, we can calculate 2924 Wh / 300 Wh/mile ≈ 9.31 miles of additional driving range.

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




