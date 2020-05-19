//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

// Including the "Diffusion" Kernel here so we can extend it
#include "Diffusion.h"

class CoeffDiff : public Diffusion
{
public:
  static InputParameters validParams();

  CoeffDiff(const InputParameters & parameters);
  virtual ~CoeffDiff();

protected:
  virtual Real computeQpResidual();
  virtual Real computeQpJacobian();

  Real _D;
};
