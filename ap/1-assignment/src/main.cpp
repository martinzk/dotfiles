#include "main.h"

using namespace persistent;

namespace wdata {

void Main::accept(Deserializer *parser) {
  parser->parse(temp, "temp");
  parser->parse(temp_min, "temp_min");
  parser->parse(temp_max, "temp_max");
  parser->parse(pressure, "pressure");
  parser->parse(sea_level, "sea_level");
  parser->parse(grnd_level, "grnd_level");
  parser->parse(humidity, "humidity");
  parser->parse(temp_kf, "temp_kf");
}
void Main::accept(Serializer *parser) const {
  parser->parse(temp, "temp");
  parser->parse(temp_min, "temp_min");
  parser->parse(temp_max, "temp_max");
  parser->parse(pressure, "pressure");
  parser->parse(sea_level, "sea_level");
  parser->parse(grnd_level, "grnd_level");
  parser->parse(humidity, "humidity");
  parser->parse(temp_kf, "temp_kf");
}
}
