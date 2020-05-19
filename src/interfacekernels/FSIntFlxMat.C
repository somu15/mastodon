//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

// #include "FSIntFlxMat.h"
// #include <iostream>
//
// registerMooseObject("MastodonApp", FSIntFlxMat);
//
// InputParameters
// FSIntFlxMat::validParams()
// {
//   InputParameters params = InterfaceKernel::validParams();
//   params.addParam<MaterialPropertyName>("D", "D", "The density.");
//   params.addParam<MaterialPropertyName>("D_neighbor", "D_neighbor", "The density.");
//   return params;
// }
//
// FSIntFlxMat::FSIntFlxMat(const InputParameters & parameters)
//   : InterfaceKernel(parameters),
//   _D(getMaterialProperty<Real>("D")),
//   _D_neighbor(getNeighborMaterialProperty<Real>("D_neighbor")),
//     _u_dotdot(dotDot()),
//     _du_dotdot_du(dotDotDu())
// {
// }
//
// Real
// FSIntFlxMat::computeQpResidual(Moose::DGResidualType type)
// {
//   Real r = 0;
//
//   Real res =
//       _D_neighbor[_qp] * _grad_neighbor_value[_qp] * _normals[_qp] + _D[_qp] * _u_dotdot[_qp];
//
//   switch (type)
//   {
//     case Moose::Element:
//       r = res * _test[_i][_qp];
//       break;
//
//     case Moose::Neighbor:
//       r = res * _test_neighbor[_i][_qp];
//       break;
//
//   }
//   std::cout << _test[_i][_qp] * _D_neighbor[_qp] * _grad_neighbor_value[_qp] * _normals[_qp] + _test_neighbor[_i][_qp] * _D[_qp] * _u_dotdot[_qp] << std::endl;
//   return r;
// }
//
// Real
// FSIntFlxMat::computeQpJacobian(Moose::DGJacobianType type)
// {
//   Real jac = 0;
//
//   switch (type)
//   {
//     case Moose::ElementElement:
//       jac = _D[_qp] * _du_dotdot_du[_qp] * _test[_i][_qp];
//
//     case Moose::NeighborNeighbor:
//       jac = _D_neighbor[_qp] * _grad_phi_neighbor[_j][_qp] * _normals[_qp] * _test_neighbor[_i][_qp];
//       break;
//
//     case Moose::ElementNeighbor:
//       jac = _D_neighbor[_qp] * _grad_phi_neighbor[_j][_qp] * _normals[_qp] * _test[_i][_qp];
//       break;
//
//     case Moose::NeighborElement:
//       jac = _D[_qp] * _du_dotdot_du[_qp] * _test_neighbor[_i][_qp];
//       break;
//
//   }
//
//   return jac;
// }

#include "FSIntFlxMat.h"
#include <iostream>

registerMooseObject("MastodonApp", FSIntFlxMat);

InputParameters
FSIntFlxMat::validParams()
{
  InputParameters params = InterfaceKernel::validParams();
  params.addParam<MaterialPropertyName>("D", "D", "The density.");
  params.addParam<MaterialPropertyName>("D_neighbor", "D_neighbor", "The density.");
  return params;
}

FSIntFlxMat::FSIntFlxMat(const InputParameters & parameters)
  : InterfaceKernel(parameters),
  _D(getMaterialProperty<Real>("D")),
  _D_neighbor(getNeighborMaterialProperty<Real>("D_neighbor")),
    _u_dotdot(dotDot()),
    _du_dotdot_du(dotDotDu())
{
}

Real
FSIntFlxMat::computeQpResidual(Moose::DGResidualType type)
{
  Real r = 0;

  Real res =
      _grad_u[_qp] * _normals[_qp] * _D[_qp] + _neighbor_value[_qp];// _D_neighbor[_qp] * _grad_neighbor_value[_qp] * _normals[_qp] + _D[_qp] * _u_dotdot[_qp];

  switch (type)
  {
    case Moose::Element:
      r = res * _test[_i][_qp];
      break;

    case Moose::Neighbor:
      r = res * _test_neighbor[_i][_qp];
      break;

  }
  std::cout << _grad_u[_qp] * _normals[_qp] * _D[_qp] + _neighbor_value[_qp] << std::endl;
  return r;
}

Real
FSIntFlxMat::computeQpJacobian(Moose::DGJacobianType type)
{
  Real jac = 0;

  switch (type)
  {
    case Moose::ElementElement:
      jac = _grad_phi[_j][_qp] * _normals[_qp] * _D[_qp] * _test[_i][_qp];

    case Moose::NeighborNeighbor:
      jac = _phi_neighbor[_j][_qp] * _test_neighbor[_i][_qp];
      break;

    case Moose::ElementNeighbor:
      jac = _grad_phi[_j][_qp] * _normals[_qp] * _D[_qp] * _test_neighbor[_i][_qp]; // _phi_neighbor[_j][_qp] * _test[_i][_qp];
      break;

    case Moose::NeighborElement:
      jac = _phi_neighbor[_j][_qp] * _test[_i][_qp]; // _grad_phi[_j][_qp] * _normals[_qp] * _D[_qp] * _test_neighbor[_i][_qp];
      break;

  }

  return jac;
}
