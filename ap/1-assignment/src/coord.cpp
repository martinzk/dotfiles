#include "coord.h"

using namespace persistent;

namespace wdata {
void Coord::accept(Deserializer *parser) {
  parser->parse(lon, "lon");
  parser->parse(lat, "lat");
}
void Coord::accept(Serializer *parser) const {
  parser->parse(lon, "lon");
  parser->parse(lat, "lat");
}
}
