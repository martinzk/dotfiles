#ifndef CLOUDS_H
#define CLOUDS_H

#include "json.h"
namespace WeatherData {
struct Clouds {
  int all;

  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(all, "all");
  }
  auto parse(js::Deserializer &serializer) { serializer.parse(all, "all"); }
};

} // WeatherData

#endif /* CLOUDS_H */
