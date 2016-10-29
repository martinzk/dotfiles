#ifndef ELEMENT_H
#define ELEMENT_H

#include "city.h"
#include "data.h"
#include "json.h"
#include <vector>

namespace WeatherData {
struct Element {
  City city;
  int time;
  std::vector<Data> data;

  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(city, "city");
    serializer.parse(time, "time");
    serializer.parse(data, "data");
  }

  auto parse(js::Deserializer &serializer) {
    serializer.parse(city, "city");
    serializer.parse(time, "time");
    serializer.parse(data, "data");
  }
};

} // WeatherData

#endif /* ELEMENT_H */
