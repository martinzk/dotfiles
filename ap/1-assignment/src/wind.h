#ifndef WIND_H_
#define WIND_H_
#include "persistent_lib.h"

namespace wdata {

class Wind : public persistent::Persistent {
public:
  double speed, deg;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
};
}
#endif
