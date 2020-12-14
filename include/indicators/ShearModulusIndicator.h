#ifndef SHEARMODULUSINDICATOR_H
#define SHEARMODULUSINDICATOR_H

// MOOSE includes
#include "Indicator.h"

// libMesh includes
#include "libmesh/quadrature.h"

/**
 * Computes the minimum element size.
 */
class ShearModulusIndicator : public Indicator
{
public:
  static InputParameters validParams();
  ShearModulusIndicator(const InputParameters & params);

protected:
  /// Computes the minimum element size based on the shear wave speed
  virtual void computeIndicator() override;

  /// Density of the material
  const MaterialProperty<Real> & _density;

  /// Shear modulus of the material
  // const Real & _shear_modulus;
  const MaterialProperty<Real> & _shear_modulus;

  /// Maximum frequency
  const Real & _cutoff_frequency;

  /// Storage for the compute minimum value on a element.
  std::vector<Real> _minimum_element_size;

  /// The current quadrature rule
  const QBase * const & _qrule;

  /// The quadrature point index for looping
  unsigned int _qp;

  /// The variable for storing indicator value
  MooseVariable & _indicator_var;
};

#endif // SHEARMODULUSINDICATOR_H
