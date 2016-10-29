#ifndef SNOW_H
#define SNOW_H

#include "json.h"
#include <algorithm>
#include <memory>
#include <vector>

namespace WeatherData {
struct Snow {
  static std::vector<std::shared_ptr<Snow>> shared_objects;
  float three_h = 0;
  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(three_h, "3h");
  }
  auto parse(js::Deserializer &serializer) { serializer.parse(three_h, "3h"); }
  auto make_shared() {
    auto it = std::find_if(shared_objects.begin(), shared_objects.end(),
                           [obj = this](const auto &snow) {
                             return obj->three_h == snow->three_h;
                           });
    int index;
    if (it == shared_objects.end()) {
      shared_objects.push_back(std::make_shared<Snow>(*this));
      index = shared_objects.size() - 1;
    } else {
      index = std::distance(shared_objects.begin(), it);
    }
    return shared_objects[index];
  }
};
std::vector<std::shared_ptr<Snow>> Snow::shared_objects{};
} // WeatherData

#endif /* SNOW_H */
