#ifndef DATA_H
#define DATA_H

#include "clouds.h"
#include "json.h"
#include "main.h"
#include "rain.h"
#include "snow.h"
#include "sys.h"
#include "weather.h"
#include "wind.h"
#include <algorithm>
#include <memory>
#include <string>
#include <vector>

using str_shared_ptr = std::shared_ptr<std::string>;
namespace WeatherData {
struct Data {
  int dt;
  Main main;
  std::vector<Weather> weather;
  Clouds clouds;
  Wind wind;
  std::shared_ptr<Snow> snow;
  std::shared_ptr<Rain> rain;
  Sys sys;
  str_shared_ptr dt_txt = std::make_shared<std::string>();
  static std::vector<str_shared_ptr> shared_dt_txt;

  auto dt_txt_make_shared() {
    auto it = std::find_if(shared_dt_txt.begin(), shared_dt_txt.end(),
                           [&this_dt_txt = dt_txt](const auto &dt_txt) {
                             return *this_dt_txt == *dt_txt;
                           });
    int index;
    if (it == shared_dt_txt.end()) {
      shared_dt_txt.push_back(std::make_shared<std::string>(*this->dt_txt));
      index = shared_dt_txt.size() - 1;
    } else {
      index = std::distance(shared_dt_txt.begin(), it);
    }
    return shared_dt_txt[index];
  }

  auto parse(js::Serializer &serializer) const noexcept {
    serializer.parse(dt, "dt");
    serializer.parse(main, "main");
    serializer.parse(weather, "weather");
    serializer.parse(clouds, "clouds");
    serializer.parse(wind, "wind");
    if (snow)
      serializer.parse(*snow, "snow");
    if (rain)
      serializer.parse(*rain, "rain");
    serializer.parse(sys, "sys");
    serializer.parse(*dt_txt, "dt_txt");
  }

  // No shared objects 17.1
  auto parse(js::Deserializer &serializer) {
    serializer.parse(dt, "dt");
    serializer.parse(main, "main");
    serializer.parse(weather, "weather");
    serializer.parse(clouds, "clouds");
    serializer.parse(wind, "wind");
    auto temp_snow = Snow{};
    serializer.parse(temp_snow, "snow");
    if (temp_snow.three_h != 0) {
      snow = temp_snow.make_shared();
    }
    auto temp_rain = Rain{};
    serializer.parse(temp_rain, "rain");
    if (temp_rain.three_h != 0) {
      rain = temp_rain.make_shared();
    }
    // 16.9
    serializer.parse(sys, "sys");
    serializer.parse(*dt_txt, "dt_txt");
    this->dt_txt = dt_txt_make_shared();
    // 12
  }
};
std::vector<str_shared_ptr> Data::shared_dt_txt{};
} // WeatherData

#endif /* DATA_H */
