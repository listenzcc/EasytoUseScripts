
# My Easy-to-Use Powershell Toolbox


# Easy-to-Log Package

- Author: Chuncheng Zhang
- Date: 2021-02-25
- Version: 0.0

## Description

The aim is to provide a reuseable logging management in python.
The core is the logging package.

It frees your hands from noisy logging settings.
By default,
- It logs on both terminal and file, in a well-organized format.
- The terminal uses the level of INFO.
- The file uses the level of DEBUG.
- The format has several columns and well spaced.

## Contains

- logger.py: The main logging class.

## Typical Using

```python
from EasyLogging.logger import new_logger

# Set the logger and you can just use it
logger = new_logger(name='projectName', filepath='logFile.log')
```


# Easy-to-Set Package

- Author: Chuncheng Zhang
- Date: 2021-02-25
- Version: 0.0

## Description

The aim is to provide a reuseable setting management in python.
The core is the configparser package.

It can be used to manage your program settings,
in the structure of **Section:Option -> Value**.
The settings can be **quickly accessed** by the manager.
And the settings can be easily **saved** to .ini files and **displayed** by pandas DataFrame.
Additionally, it requires only one line to **restore** your settings.

## Contains

- config.py: The main configure class.

## Typical Using

```python
from EasySetting.config import Config

# Init config or Restore from file
cfg = Config(cfg_file='configFile.ini')

# Save config
cfg.save()

# Display using DataFrame
cfg.display()
```
