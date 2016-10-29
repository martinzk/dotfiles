#ifndef MAIN_H
#define MAIN_H
#include "persistent_lib.h"

namespace wdata {
class Main : public persistent::Persistent {
public:
  double temp, temp_min, temp_max, pressure, sea_level, grnd_level, temp_kf;
  int humidity;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
};
}
#endif /* MAIN_H */
