// libMesh includes
#include "libmesh/numeric_vector.h"

// MOOSE includes
#include "Assembly.h"
#include "MooseVariable.h"
#include "SystemBase.h"

// Mastodon includes
#include "ShearModulusIndicator.h"

registerMooseObject("MastodonApp", ShearModulusIndicator);

InputParameters
ShearModulusIndicator::validParams()
{
  InputParameters params = Indicator::validParams();
  params.addParam<MaterialPropertyName>("density",
                                        "density",
                                        "The density of the material.");
  // params.addParam<MaterialPropertyName>("shear_wave_speed", "Shear modulus of the material.");
  // params.addRequiredParam<Real>("shear_modulus", "Shear modulus of the material.");
  params.addRequiredParam<Real>("cutoff_frequency", "The cutoff frequency in Hertz.");
  params.addClassDescription("Computes the minimum element size based on the shear wave speed.");
  return params;
}

ShearModulusIndicator::ShearModulusIndicator(const InputParameters & parameters)
  : Indicator(parameters),
    _density(getMaterialProperty<Real>("density")),
    // _shear_wave_speed(getMaterialProperty<Real>("shear_wave_speed")),
    _shear_modulus(getMaterialProperty<Real>("shear_modulus")),
    _cutoff_frequency(getParam<Real>("cutoff_frequency")),
    _qrule(_assembly.qRule()),
    _indicator_var(_sys.getFieldVariable<Real>(_tid, name()))
{
}

void
ShearModulusIndicator::computeIndicator()
{
  _minimum_element_size.resize(_qrule->n_points());
  for (_qp = 0; _qp < _qrule->n_points(); ++_qp)
    _minimum_element_size[_qp] = 1.0 / _cutoff_frequency * std::sqrt(_shear_modulus[_qp] / _density[_qp]);

  Threads::spin_mutex::scoped_lock lock(Threads::spin_mtx);
  _solution.set(_indicator_var.nodalDofIndex(),
                *std::min_element(_minimum_element_size.begin(), _minimum_element_size.end()));
}
