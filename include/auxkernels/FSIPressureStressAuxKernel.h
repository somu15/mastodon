//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

// Local includes
#include "AuxKernel.h"

/**
 * FSIPressureStressAuxKernel takes pressure in the fluid domain as input and converts it
 * to a displacement in the vertical direction (i.e., wave height if the location is on surface)
 */
class FSIPressureStressAuxKernel : public AuxKernel
{
public:
  static InputParameters validParams();

  FSIPressureStressAuxKernel(const InputParameters & parameters);

  virtual ~FSIPressureStressAuxKernel() {}

protected:
  virtual Real computeValue();

  /// Pressure input
  // const VariableValue & _pressure;
};
