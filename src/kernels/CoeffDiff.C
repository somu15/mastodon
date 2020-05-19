//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CoeffDiff.h"

registerMooseObject("MastodonApp", CoeffDiff);

InputParameters
CoeffDiff::validParams()
{
  InputParameters params = Diffusion::validParams();
  params.addRequiredParam<Real>("D", "The diffusivity coefficient.");
  return params;
}

CoeffDiff::CoeffDiff(const InputParameters & parameters)
  : Diffusion(parameters),

    _D(getParam<Real>("D"))
{
}

CoeffDiff::~CoeffDiff() {}

Real
CoeffDiff::computeQpResidual()
{
  return _D * Diffusion::computeQpResidual();
}

Real
CoeffDiff::computeQpJacobian()
{
  return _D * Diffusion::computeQpJacobian();
}
