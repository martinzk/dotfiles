#ifndef COORD_H
#define COORD_H
#include "persistent_lib.h"

namespace wdata {
class Coord : public persistent::Persistent {
public:
  double lon;
  double lat;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
};
}
#endif /* COORD_H */
