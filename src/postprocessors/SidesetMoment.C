//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "SidesetMoment.h"
#include "metaphysicl/raw_type.h"

registerMooseObject("MastodonApp", SidesetMoment);
registerMooseObject("MastodonApp", ADSidesetMoment);

template <bool is_ad>
InputParameters
SidesetMomentTempl<is_ad>::validParams()
{
  InputParameters params = SideIntegralPostprocessor::validParams();
  params.addClassDescription("Computes the product of integrated reaction force and lever arm in a "
                             "user-specified direction "
                             "on a sideset from the surface traction");
  params.addParam<MaterialPropertyName>("stress_tensor", "The rank two stress tensor name");
  params.addRangeCheckedParam<unsigned int>("stress_dir", 0, "stress_dir <= 2", "Stress direction");
  params.addCoupledVar("p", "The scalar pressure");
  params.addRequiredParam<RealVectorValue>(
      "ref_point", "Reference point on the sideset about which the moment is computed");
  params.addParam<bool>("use_radial", false, "Bool to indicate whether to use radial distance between current and reference points");
  // params.addRangeCheckedParam<RealVectorValue>(
  //     "leverarm_direction", 0, "leverarm_direction <= 2", "Lever arm direction");
  params.addParam<RealVectorValue>(
      "leverarm_direction", (1,0,0), "Lever arm direction");
  params.set<bool>("use_displaced_mesh") = true;
  return params;
}

template <bool is_ad>
SidesetMomentTempl<is_ad>::SidesetMomentTempl(const InputParameters & parameters)
  : SideIntegralPostprocessor(parameters),
    _tensor(isParamValid("stress_tensor")
                ? &getGenericMaterialProperty<RankTwoTensor, is_ad>("stress_tensor")
                : nullptr),
    _stress_dir(isParamValid("stress_dir") ? &getParam<unsigned int>("stress_dir") : nullptr),
    _p(isCoupled("p") ? &coupledValue("p") : nullptr),
    _ref_point(getParam<RealVectorValue>("ref_point")),
    _use_radial(getParam<bool>("use_radial")),
    _leverarm_direction(isParamValid("use_radial") ? &getParam<RealVectorValue>("leverarm_direction") : nullptr)
{
  if (_tensor && _p)
    mooseError(
        "In block ",
        name(),
        ", both the stress tensor and the pressure should not be provided at the same time.");
  if (_tensor && !_stress_dir)
    mooseError("In block ",
               name(),
               ", a direction vector should be provided along with the stress tensor.");
  if (!_tensor && !_p)
    mooseError(
        "In block ", name(), ", either the stress tensor or the pressure should be provided.");
}

// template <bool is_ad>
// Real
// SidesetMomentTempl<is_ad>::computeQpIntegral()
// {
//   if (_tensor)
//   {
//     RealVectorValue dir(0, 0, 0);
//     dir((*_stress_dir)) = 1;
//     if (!_use_radial)
//       return _normals[_qp] * (MetaPhysicL::raw_value((*_tensor)[_qp]) * dir) *
//              std::abs(_ref_point((*_leverarm_direction)) - _q_point[_qp]((*_leverarm_direction)));
//     else
//       return _normals[_qp] * (MetaPhysicL::raw_value((*_tensor)[_qp]) * dir) *
//              std::pow((std::pow(_ref_point(0) - _q_point[_qp](0),2) + std::pow(_ref_point(1) - _q_point[_qp](1),2)),0.5);
//   }
//   else
//   {
//     if (!_use_radial)
//       return std::abs((*_p)[_qp]) * std::abs(_ref_point((*_leverarm_direction)) - _q_point[_qp]((*_leverarm_direction)));
//     else
//     {
//       // std::cout << (*_p)[_qp] << " , " << std::pow((std::pow((_ref_point(0) - _q_point[_qp](0)),2) + std::pow((_ref_point(1) - _q_point[_qp](1)),2)),0.5) << std::endl;
//       return std::abs((*_p)[_qp]) * std::pow((std::pow((_ref_point(0) - _q_point[_qp](0)),2) + std::pow((_ref_point(1) - _q_point[_qp](1)),2)),0.5);
//     }
//   }
// }

template <bool is_ad>
Real
SidesetMomentTempl<is_ad>::computeQpIntegral()
{
  if (_tensor)
  {
    RealVectorValue dir(0, 0, 0);
    dir((*_stress_dir)) = 1;
    RealVectorValue diff1 = _ref_point - _q_point[_qp];
    if (!_use_radial)
      // return _normals[_qp] * (MetaPhysicL::raw_value((*_tensor)[_qp]) * dir) *
      //        std::abs(_ref_point((*_leverarm_direction)) - _q_point[_qp]((*_leverarm_direction)));
      return _normals[_qp] * (MetaPhysicL::raw_value((*_tensor)[_qp]) * dir) * (diff1(0) * (*_leverarm_direction)(0) + diff1(1) * (*_leverarm_direction)(1) + diff1(2) * (*_leverarm_direction)(2));
    else
      return _normals[_qp] * (MetaPhysicL::raw_value((*_tensor)[_qp]) * dir) *
             std::pow((std::pow(_ref_point(0) - _q_point[_qp](0),2) + std::pow(_ref_point(1) - _q_point[_qp](1),2)),0.5);
  }
  else
  {
    RealVectorValue diff1 = _ref_point - _q_point[_qp];
    if (!_use_radial)
      // return std::abs((*_p)[_qp]) * std::abs(_ref_point((*_leverarm_direction)) - _q_point[_qp]((*_leverarm_direction)));
      return ((*_p)[_qp]) * (diff1(0) * (*_leverarm_direction)(0) + diff1(1) * (*_leverarm_direction)(1) + diff1(2) * (*_leverarm_direction)(2));
    else
    {
      // std::cout << (*_p)[_qp] << " , " << std::pow((std::pow((_ref_point(0) - _q_point[_qp](0)),2) + std::pow((_ref_point(1) - _q_point[_qp](1)),2)),0.5) << std::endl;
      return std::abs((*_p)[_qp]) * std::pow((std::pow((_ref_point(0) - _q_point[_qp](0)),2) + std::pow((_ref_point(1) - _q_point[_qp](1)),2)),0.5);
    }
  }
}

template class SidesetMomentTempl<false>;
template class SidesetMomentTempl<true>;
