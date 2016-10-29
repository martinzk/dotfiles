#ifndef WIND_H
#define WIND_H

#include "json.h"

namespace WeatherData {
struct Wind {
  float speed = 0, deg = 0;

  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(speed, "speed");
    serializer.parse(deg, "deg");
  }
  auto parse(js::Deserializer &serializer) {
    serializer.parse(speed, "speed");
    serializer.parse(deg, "deg");
  }
};

} // WeatherData

#endif /* WIND_H */
