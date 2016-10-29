#ifndef COORD_H
#define COORD_H

#include "json.h"

namespace WeatherData {

struct Coord {
  float lon, lat;

  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(lon, "lon");
    serializer.parse(lat, "lat");
  }
  auto parse(js::Deserializer &serializer) {
    serializer.parse(lon, "lon");
    serializer.parse(lat, "lat");
  }
};

} // WeatherData

#endif /* COORD_H */
