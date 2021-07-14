//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "FSIPressureStressAuxKernel.h"
#include "RankTwoScalarTools.h"
#include "MooseVariableFieldBase.h"

registerMooseObject("MastodonApp", FSIPressureStressAuxKernel);

InputParameters
FSIPressureStressAuxKernel::validParams()
{
  InputParameters params = AuxKernel::validParams();
  params.addClassDescription("Calculates the wave heights given pressures.");
  // params.addRequiredCoupledVar("pressure", "pressure variable");
  return params;
}

FSIPressureStressAuxKernel::FSIPressureStressAuxKernel(const InputParameters & parameters)
  : AuxKernel(parameters) // ,
    // _pressure(coupledValue("pressure"))
{
}

Real
FSIPressureStressAuxKernel::computeValue()
{
  // return _pressure[_qp];
  return _u[_qp];
}
