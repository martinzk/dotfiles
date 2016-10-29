#ifndef CITY_H
#define CITY_H

#include "coord.h"
#include "json.h"
#include <string>

namespace WeatherData {
struct City {
  int id;
  std::string name;
  std::string country;
  Coord coord;

  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(id, "id");
    serializer.parse(name, "name");
    serializer.parse(country, "country");
    serializer.parse(coord, "coord");
  }

  auto parse(js::Deserializer &serializer) {
    serializer.parse(id, "id");
    serializer.parse(name, "name");
    serializer.parse(country, "country");
    serializer.parse(coord, "coord");
  }
};

} // WeatherData
#endif /* CITY_H */
