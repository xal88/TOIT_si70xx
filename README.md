# SI70xx

**A low level TOIT driver for the Silabs Si70xx/HTU21D  sensor family.**

[ derived and based on the work from https://github.com/toitware/toit-si7006/ ]

These sensors are combined temperature and humidity sensors with different accuracy.

```
SI7006 addr: 0x40, device_id 0x06
SI7013 addr: 0x41, device_id 0x0D
SI7020 addr: 0x40, device_id 0x14
SI7021 addr: 0x40, device_id 0x15
HTU21D is the same as SI7021
```

Documentation is available at
* [Silicon Lab Hardware] https://www.silabs.com/sensors/humidity/si7006-13-20-21-34
* [Silicon Lab API] https://docs.silabs.com/gecko-platform/latest/hardware-driver/api/group-si70xx

## Usage
A simple usage example.

``` toit
import gpio
import serial.protocols.i2c as i2c
import .si70xx show *
import math

main:
  sda := gpio.Pin 21
  scl := gpio.Pin 22
  bus := i2c.Bus --sda=sda --scl=scl --frequency=100_000
  i2c_device := bus.device Si70xx.I2C_ADDRESS_40
  sensor := Si70xx i2c_device

  print "Device Type: $sensor.device_type"
  print "Firmware: $sensor.firmware"
  print "SerialNr#: $sensor.serial_number"
  
  print "Temperature: $(%0.1f sensor.temperature)C"
  print "Humidity: $(sensor.humidity.round)%"
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].
