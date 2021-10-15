import gpio
import serial.protocols.i2c as i2c
import si70xx show *
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
  
  temperature := (sensor.read_temperature)
  humidity := (sensor.read_humidity)
  
  // for dewpoint calculation
  // dew = (bα(T,RH)) / (a - α(T,RH))
  // α(T,RH) = ln(RH/100) + aT/(b+T)
  a := 17.62
  b := 243.12
  c := math.log humidity/100.0
  c = c + (a * temperature/( b + temperature ) )
  dew := "$(%0.1f ((b * c ) / (a - c)) )"

  THD := {
    "Temperature": "$(%0.1f temperature)",
    "Humidity": "$(humidity.round)",
    "Dewpoint": dew,
  }
  
  print THD