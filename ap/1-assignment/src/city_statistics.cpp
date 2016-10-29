#include "city_statistics.h"
#include "weather_data.h"
#include <cmath>

using namespace std;
using namespace wdata;
using namespace persistent;

namespace wstat {

void CityStatistics::accept(Serializer *parser) const {
  parser->parse(city, "city");
  parser->parse(avg_daytime_temp, "avg_daytime_temp");
  parser->parse(avg_nighttime_temp, "avg_nighttime_temp");
  parser->parse(daytime_variance, "daytime_variance");
  parser->parse(nighttime_variance, "nighttime_variance");
}
void CityStatistics::accept(Deserializer *parser) {
  parser->parse(city, "city");
  parser->parse(avg_daytime_temp, "avg_daytime_temp");
  parser->parse(avg_nighttime_temp, "avg_nighttime_temp");
  parser->parse(daytime_variance, "daytime_variance");
  parser->parse(nighttime_variance, "nighttime_variance");
}

void CityStatistics::visit(WeatherData &weatherData) noexcept {
  city = weatherData.city;
  int days = 0;
  bool daytime = false;
  double total_day = 0;
  double total_night = 0;
  int i = 0;
  vector<double> daytime_values;
  vector<double> nighttime_values;
  for (auto data : weatherData.data) {
    i++;
    if (daytime) {
      total_day += data->main.temp;
      daytime_values.push_back(data->main.temp);
    } else {
      total_night += data->main.temp;
      nighttime_values.push_back(data->main.temp);
    }
    // 00:00 - 12:00 is nighttime, 12:00 - 24:00 is daytime
    if (i > 3)
      daytime = true;
    if (i > 7) {
      daytime = false;
      i = 0;
      days++;
    }
  }
  // nbr of days times nbr of temps per daytime/nighttime
  avg_daytime_temp = total_day / (days * 4);
  avg_nighttime_temp = total_night / (days * 4);
  double temp_var = 0;
  for (auto day_temp : daytime_values) {
    temp_var += pow(day_temp - avg_daytime_temp, 2);
  }
  daytime_variance = temp_var / (days * 4);
  temp_var = 0;
  for (auto night_temp : nighttime_values) {
    temp_var += pow(night_temp - avg_nighttime_temp, 2);
  }
  nighttime_variance = temp_var / (days * 4);
}
}
