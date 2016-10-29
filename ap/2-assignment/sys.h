#ifndef SYS_H
#define SYS_H

#include "json.h"
#include <string.h>

namespace WeatherData {
struct Sys {
  std::string pod;

  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(pod, "pod");
  }
  auto parse(js::Deserializer &serializer) { serializer.parse(pod, "pod"); }
};

} // WeatherData

#endif /* SYS_H */
