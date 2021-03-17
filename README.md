
# Redneck Skeeter Trucks

This script adds the ability to open the compartment doors and toggle all scene lighting on Redneck Modification's Skeeter trucks.

## Compatible trucks

- 2018 F550 Crew & Single Cab
- 2016 RAM 5500 Crew Cab & Single Cab
- 2020 RAM 5500 Crew & Single Cab

## Features

- Open and close the compartment doors from outside of the vehicle.
- Toggle the compartment lights.
- Toggle left, right, rear, and ground scene lights from outside of the vehicle.

## Installation

### Installing

Simply add the `Skeeter-Trucks` resource to your FiveM server and ensure it is started.

### Usage

Once you exit a Skeeter truck, you will see help text telling you the state of the compartments and each light, and the hotkey to toggle them.

## Known issues

- If the compartment doors are open, they close and instantly re-open when toggling lights. This should be able to be compensated for by setting `openInstantly` to `true` on `SetVehicleDoorOpen()`, however it does not seem to be working in this case.
 
## Contributors

- [IceTheDev](https://github.com/IceTheDev)
- [Scullyy](https://github.com/Scullyy)
- [CharlesHacks](https://github.com/CharlesHacks)
