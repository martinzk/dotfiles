#include "country_statistics.h"
#include "weather_data.h"

using namespace std;
using namespace persistent;
using namespace wdata;

namespace wstat {

void CountryStatistics::accept(Serializer *parser) const {
  parser->parse(country, "country");
  vector<shared_ptr<Persistent>> parsable(cities.begin(), cities.end());
  parser->parse(parsable, "city_statistics");
  parser->parse(temp_min, "temp_min");
  parser->parse(temp_max, "temp_max");
}
void CountryStatistics::accept(Deserializer *parser) {
  parser->parse(country, "country");
  parser->parseListBegin("city_statistics");
  do {
    CityStatistics city_stat_el;
    parser->parseListElement(city_stat_el);
    cities.push_back(make_shared<CityStatistics>(city_stat_el));
  } while (parser->moreElements());
  parser->parseListEnd();
  parser->parse(temp_min, "temp_min");
  parser->parse(temp_max, "temp_max");
}

void CountryStatistics::visit(WeatherData &weatherData) noexcept {
  for (auto data : weatherData.data) {
    if (data->main.temp_max > temp_max) {
      temp_max = data->main.temp_max;
    }
    if (data->main.temp_min < temp_min) {
      temp_min = data->main.temp_min;
    }
  }
}
}
