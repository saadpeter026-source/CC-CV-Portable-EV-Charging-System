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
* images/ – System diagrams, subsystem figures, and simulation screenshots.
* tests/ – Simulation test cases and validation results.
* data/ – Battery parameter spreadsheets and supporting datasets.
* docs/ – Project presentation and additional documentation.
 - src/
* main.m – Main MATLAB script used to run the project.
* Portable_Charging_System.slx – Main Simulink model of the portable EV charging system.

## Required Software and Toolboxes

## Installation

## Running the Project

## System-Level Architecture

## Project Features

## Simulation Results

## Testing and Verification

## Future Work

## References

## License
