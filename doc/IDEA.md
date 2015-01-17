
### Thermostat

##### #1
```
ThermostatManager
  ThermostatData

ThermostatOff < ThermostatManager
ThermostatAuto < ThermostatManager
ThermostatManual < ThermostatManager

```

##### #2
```
Thermostat
  manager = ThermostatManager

ThermostatOff < ThermostatManager
ThermostatAuto < ThermostatManager
ThermostatManual < ThermostatManager

```
