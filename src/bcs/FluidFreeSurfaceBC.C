//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "FluidFreeSurfaceBC.h"

registerMooseObject("MooseApp", FluidFreeSurfaceBC);

defineLegacyParams(FluidFreeSurfaceBC);

InputParameters
FluidFreeSurfaceBC::validParams()
{
  InputParameters params = ArrayIntegratedBC::validParams();
  params.addParam<RealEigenVector>("alpha", "Ratio between directional gradient and solution");
  params.addClassDescription("Imposes the Robin boundary condition $\\partial_n "
                             "\\vec{u}=-\\frac{\\vec{\\alpha}}{2}\\vec{u}$.");
   params.addRequiredCoupledVar("velocity", "The velocity variable.");
   params.addRequiredCoupledVar("acceleration", "The acceleration variable.");
  return params;
}

FluidFreeSurfaceBC::FluidFreeSurfaceBC(const InputParameters & parameters)
  : ArrayIntegratedBC(parameters),
    _alpha(isParamValid("alpha") ? getParam<RealEigenVector>("alpha")
                                 : RealEigenVector::Ones(_count)),
   _u_old(valueOld()),
   _vel_old(coupledValueOld("velocity")),
   _accel_old(coupledValueOld("acceleration"))
{
  _alpha /= 2;
}

RealEigenVector
FluidFreeSurfaceBC::computeQpResidual()
{
  return _alpha.cwiseProduct(_u[_qp]) * _test[_i][_qp];
}

RealEigenVector
FluidFreeSurfaceBC::computeQpJacobian()
{
  return _test[_i][_qp] * _phi[_j][_qp] * _alpha;
}

// #include "FluidFreeSurfaceBC.h"
// #include "SubProblem.h"
//
// registerMooseObject("MooseApp", FluidFreeSurfaceBC);
//
// defineLegacyParams(FluidFreeSurfaceBC);
//
// InputParameters
// FluidFreeSurfaceBC::validParams()
// {
//   InputParameters params = ArrayIntegratedBC::validParams();
//   params.addParam<RealEigenVector>("alpha", "Ratio between directional gradient and solution");
//   params.addClassDescription("Imposes the Robin boundary condition $\\partial_n "
//                              "\\vec{u}=-\\frac{\\vec{\\alpha}}{2}\\vec{u}$.");
//   return params;
// }
//
// FluidFreeSurfaceBC::FluidFreeSurfaceBC(const InputParameters & parameters)
//   : ArrayIntegratedBC(parameters),
//     _alpha(isParamValid("alpha") ? getParam<RealEigenVector>("alpha")
//                                  : RealEigenVector::Ones(_count))
// {
//   _u_dotdot = &(_var.uDotDot());
// }
//
// RealEigenVector
// FluidFreeSurfaceBC::computeQpResidual()
// {
//   return _alpha.cwiseProduct((*_u_dotdot)[_qp]) * _test[_i][_qp];
// }
//
// RealEigenVector
// FluidFreeSurfaceBC::computeQpJacobian()
// {
//   return _test[_i][_qp] * _phi[_j][_qp] * _alpha;
// }
