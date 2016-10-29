#include "wind.h"

using namespace persistent;

namespace wdata {

void Wind::accept(Deserializer *parser) {
  parser->parse(speed, "speed");
  parser->parse(deg, "deg");
}
void Wind::accept(Serializer *parser) const {
  parser->parse(speed, "speed");
  parser->parse(deg, "deg");
}
}
