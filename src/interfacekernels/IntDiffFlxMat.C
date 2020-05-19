//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "IntDiffFlxMat.h"

registerMooseObject("MastodonApp", IntDiffFlxMat);

InputParameters
IntDiffFlxMat::validParams()
{
  InputParameters params = InterfaceKernel::validParams();
  params.addParam<MaterialPropertyName>("D", "D", "The diffusion coefficient.");
  params.addParam<MaterialPropertyName>(
      "D_neighbor", "D_neighbor", "The neighboring diffusion coefficient.");
  return params;
}

IntDiffFlxMat::IntDiffFlxMat(const InputParameters & parameters)
  : InterfaceKernel(parameters),
    _D(getMaterialProperty<Real>("D")),
    _D_neighbor(getNeighborMaterialProperty<Real>("D_neighbor"))
{
}

Real
IntDiffFlxMat::computeQpResidual(Moose::DGResidualType type)
{
  Real r = 0;

  Real res =
      _D[_qp] * _grad_u[_qp] * _normals[_qp] - _D_neighbor[_qp] * _grad_neighbor_value[_qp] * _normals[_qp];

  switch (type)
  {
    case Moose::Element:
      r = res * _test[_i][_qp];
      break;

    case Moose::Neighbor:
      r = res * _test_neighbor[_i][_qp];
      break;
  }

  return r;
}

Real
IntDiffFlxMat::computeQpJacobian(Moose::DGJacobianType type)
{
  Real jac = 0;

  switch (type)
  {
    case Moose::ElementElement:
      jac = _D[_qp] * _grad_phi[_j][_qp] * _normals[_qp] * _test[_i][_qp];

    case Moose::NeighborNeighbor:
      jac = -_D_neighbor[_qp] * _grad_phi_neighbor[_j][_qp] * _normals[_qp] * _test_neighbor[_i][_qp];
      break;

    case Moose::NeighborElement:
      jac = _D[_qp] * _grad_phi[_j][_qp] * _normals[_qp] * _test_neighbor[_i][_qp];
      break;

    case Moose::ElementNeighbor:
      jac = -_D_neighbor[_qp] * _grad_phi_neighbor[_j][_qp] * _normals[_qp] * _test[_i][_qp];
      break;
  }

  return jac;
}
