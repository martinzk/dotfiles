#ifndef WEATHER_H
#define WEATHER_H

#include "json.h"
#include <algorithm>
#include <memory>
#include <string>
#include <vector>

namespace WeatherData {
struct Weather {
  static std::vector<std::shared_ptr<Weather>> shared_objects;
  int id;
  std::string main, description, icon;

  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(id, "id");
    serializer.parse(main, "main");
    serializer.parse(description, "description");
    serializer.parse(icon, "icon");
  }
  auto parse(js::Deserializer &serializer) {
    serializer.parse(id, "id");
    serializer.parse(main, "main");
    serializer.parse(description, "description");
    serializer.parse(icon, "icon");
  }
  std::shared_ptr<Weather> make_shared() {

    auto it = std::find_if(shared_objects.begin(), shared_objects.end(),
                           [obj = this](const auto weather) {
                             return weather->id == obj->id &&
                                    weather->main == obj->main &&
                                    weather->description == obj->description &&
                                    weather->icon == obj->icon;
                           });
    int index;
    if (it == shared_objects.end()) {
      shared_objects.push_back(std::make_shared<Weather>(*this));
      index = shared_objects.size() - 1;
    } else {
      index = std::distance(shared_objects.begin(), it);
    }
    return shared_objects[index];
  }
};

std::vector<std::shared_ptr<Weather>> shared_objects{};
} // WeatherData

#endif /* WEATHER_H */
