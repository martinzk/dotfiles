#ifndef MAIN_H
#define MAIN_H

#include "json.h"
#include <algorithm>
#include <memory>
#include <vector>

namespace WeatherData {
struct Main {
  float temp, temp_min, temp_max, pressure, sea_level, grnd_level;
  int humidity;
  std::shared_ptr<float> temp_kf;
  static std::vector<std::shared_ptr<float>> shared_temp_kf;

  auto temp_kf_make_shared(float &temp_temp_kf) {
    auto it = std::find_if(shared_temp_kf.begin(), shared_temp_kf.end(),
                           [temp_temp_kf = temp_temp_kf](const auto &temp_kf) {
                             return temp_temp_kf == *temp_kf;
                           });
    int index;
    if (it == shared_temp_kf.end()) {
      shared_temp_kf.push_back(std::make_shared<float>(temp_temp_kf));
      index = shared_temp_kf.size() - 1;
    } else {
      index = std::distance(shared_temp_kf.begin(), it);
    }
    return shared_temp_kf[index];
  }

  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(temp, "temp");
    serializer.parse(temp_min, "temp_min");
    serializer.parse(temp_max, "temp_max");
    serializer.parse(pressure, "pressure");
    serializer.parse(sea_level, "sea_level");
    serializer.parse(grnd_level, "grnd_level");
    serializer.parse(humidity, "humidity");
    if (temp_kf)
      serializer.parse(*temp_kf, "temp_kf");
  }
  auto parse(js::Deserializer &serializer) {
    serializer.parse(temp, "temp");
    serializer.parse(temp_min, "temp_min");
    serializer.parse(temp_max, "temp_max");
    serializer.parse(pressure, "pressure");
    serializer.parse(sea_level, "sea_level");
    serializer.parse(grnd_level, "grnd_level");
    serializer.parse(humidity, "humidity");
    float temp_temp_kf = 0.0;
    serializer.parse(temp_temp_kf, "temp_kf");
    if (temp_temp_kf != 0.0) {
      temp_kf = temp_kf_make_shared(temp_temp_kf);
    }
  }
};
std::vector<std::shared_ptr<float>> Main::shared_temp_kf{};
} // WeatherData

#endif /* MAIN_H */
