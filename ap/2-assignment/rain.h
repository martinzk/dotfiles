#ifndef RAIN_H
#define RAIN_H

#include "json.h"
#include <algorithm>
#include <memory>
#include <vector>

namespace WeatherData {
struct Rain {
  static std::vector<std::shared_ptr<Rain>> shared_objects;
  float three_h = 0;
  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(three_h, "3h");
  }
  auto parse(js::Deserializer &serializer) { serializer.parse(three_h, "3h"); }
  auto make_shared() {
    auto it = std::find_if(shared_objects.begin(), shared_objects.end(),
                           [obj = this](const auto &el_rain) {
                             return obj->three_h == el_rain->three_h;
                           });
    int index;
    if (it == shared_objects.end()) {
      shared_objects.push_back(std::make_shared<Rain>(*this));
      index = shared_objects.size() - 1;
    } else {
      index = std::distance(shared_objects.begin(), it);
    }
    return shared_objects[index];
  }
};

std::vector<std::shared_ptr<Rain>> Rain::shared_objects{};
} // WeatherData
#endif /* RAIN_H */
