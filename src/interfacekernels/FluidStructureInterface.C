//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

// #include "FluidStructureInterface.h"
//
// registerMooseObject("MastodonApp", FluidStructureInterface);
//
// InputParameters
// FluidStructureInterface::validParams()
// {
//   InputParameters params = InterfaceKernel::validParams();
//   params.addParam<MaterialPropertyName>("D", "D", "The diffusion coefficient.");
//   params.addParam<MaterialPropertyName>(
//       "D_neighbor", "D_neighbor", "The neighboring diffusion coefficient.");
//   return params;
// }
//
// FluidStructureInterface::FluidStructureInterface(const InputParameters & parameters)
//   : InterfaceKernel(parameters),
//     _D(getMaterialProperty<Real>("D")),
//     _D_neighbor(getNeighborMaterialProperty<Real>("D_neighbor"))
// {
// }
//
// Real
// FluidStructureInterface::computeQpResidual(Moose::DGResidualType type)
// {
//   Real r = 0;
//
//   switch (type)
//   {
//     case Moose::Element:
//       r = _test[_i][_qp] * -_D_neighbor[_qp] * _grad_neighbor_value[_qp] * _normals[_qp];
//       break;
//
//     case Moose::Neighbor:
//       r = _test_neighbor[_i][_qp] * _D[_qp] * _grad_u[_qp] * _normals[_qp];
//       break;
//   }
//
//   return r;
// }
//
// Real
// FluidStructureInterface::computeQpJacobian(Moose::DGJacobianType type)
// {
//   Real jac = 0;
//
//   switch (type)
//   {
//     case Moose::ElementElement:
//     case Moose::NeighborNeighbor:
//       break;
//
//     case Moose::NeighborElement:
//       jac = _test_neighbor[_i][_qp] * _D[_qp] * _grad_phi[_j][_qp] * _normals[_qp];
//       break;
//
//     case Moose::ElementNeighbor:
//       jac = _test[_i][_qp] * -_D_neighbor[_qp] * _grad_phi_neighbor[_j][_qp] * _normals[_qp];
//       break;
//   }
//
//   return jac;
// }

#include "FluidStructureInterface.h"
#include <iostream>

registerMooseObject("MastodonApp", FluidStructureInterface);

InputParameters
FluidStructureInterface::validParams()
{
  InputParameters params = InterfaceKernel::validParams();
  params.addParam<MaterialPropertyName>("D", "D", "The density.");
  // params.addParam<MaterialPropertyName>(
  //     "D_neighbor", "D_neighbor", "The neighboring diffusion coefficient.");
  return params;
}

FluidStructureInterface::FluidStructureInterface(const InputParameters & parameters)
  : InterfaceKernel(parameters),
    _D(getMaterialProperty<Real>("D")),
    _u_dotdot(dotDot()),
    _du_dotdot_du(dotDotDu())
    // _D_neighbor(getNeighborMaterialProperty<Real>("D_neighbor"))
{
}

Real
FluidStructureInterface::computeQpResidual(Moose::DGResidualType type)
{
  Real r = 0;

  switch (type)
  {
    // case Moose::Element:
    //   r = _test[_i][_qp] * -_D[_qp] * _u_dotdot[_qp];// * _normals[_qp];
    //   break;
    //
    // case Moose::Neighbor:
    //   r = _test_neighbor[_i][_qp] * _grad_neighbor_value[_qp] * _normals[_qp];
    //   break;

    case Moose::Element:
      r = _test[_i][_qp] * _grad_neighbor_value[_qp] * _normals[_qp];// * _normals[_qp];
      break;

    case Moose::Neighbor:
      r = _test_neighbor[_i][_qp] * -_D[_qp] * _u_dotdot[_qp];
      break;
  }

  return r;
  // std::cout << _grad_neighbor_value[_qp] * _normals[_qp] << std::endl;
  // std::cout << -_D[_qp] * _u_dotdot[_qp] << std::endl;
}

Real
FluidStructureInterface::computeQpJacobian(Moose::DGJacobianType type)
{
  Real jac = 0;

  switch (type)
  {
    case Moose::ElementElement:
    case Moose::NeighborNeighbor:
      break;

    // case Moose::NeighborElement:
    //   jac = _test_neighbor[_i][_qp] * -_D[_qp] * _du_dotdot_du[_qp];//' * _normals[_qp];
    //   break;
    //
    // case Moose::ElementNeighbor:
    //   jac = _test[_i][_qp] * _grad_phi_neighbor[_j][_qp] * _normals[_qp];
    //   break;

    case Moose::NeighborElement:
      jac = _test_neighbor[_i][_qp] * -_D[_qp] * _du_dotdot_du[_qp];//' * _normals[_qp];
      break;

    case Moose::ElementNeighbor:
      jac = _test[_i][_qp] * _grad_phi_neighbor[_j][_qp] * _normals[_qp];
      break;

  }

  return jac;
}
