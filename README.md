# Guideline 36 Savings Calculator
This repository contains models, analysis scripts, and preliminary calculator for estimating savings potential of ASHRAE Guideline 36 control sequences.

## Savings Calculator
A preliminary calculator to estimate savings is implemented in ``G36_savings_calculator.xlsx`` based on simualation results from the models within this repository.  See the README sheet within the spreadsheet for more information.

## Models
To simulate the models, please follow the steps below:

1. Install Git LFS first if you have not installed it on your system.

2. Update your ``modelica-buildings`` branch to ``issue1129_energyPlus_zone`` to the latest commits.

3. If the branch ``issue1129_energyPlus_zone`` is behind ``master``, please merge ``master`` to ``issue1129_energyPlus_zone`` branch. This will be the base branch for the use with the models.

4. Clone this repo and check out to the ``main`` branch.

5. See ``BestInClass.DetailedZoning`` for models that can be run.

6. You can also run models in batches using the script ``process/simulate.py`` (BuildingsPy installation is requried) and be careful with the output folders.

7. If your Dymola version is under 2021, set ``Hidden.AvoidDoubleComputation = true`` in the Dymola command window before simulating the models.
