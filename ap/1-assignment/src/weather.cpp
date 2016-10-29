#include "weather.h"

using namespace persistent;
using namespace std;

namespace wdata {

map<pair<int, string>, shared_ptr<Weather>> Weather::shared_weather;

void Weather::accept(Deserializer *parser) {
  parser->parse(id, "id");
  parser->parse(main, "main");
  parser->parse(description, "description");
  parser->parse(icon, "icon");
}
void Weather::accept(Serializer *parser) const {
  parser->parse(id, "id");
  parser->parse(main, "main");
  parser->parse(description, "description");
  parser->parse(icon, "icon");
}
shared_ptr<Weather> Weather::getSharedInstance() {
  pair<int, string> weather_key(this->id, this->icon);
  if (shared_weather.find(weather_key) == shared_weather.end())
    // if not we create a shared instance and add it to the map
    shared_weather[weather_key] = make_shared<Weather>(*this);
  // retrieve the shared instance into our container
  return shared_weather[weather_key];
}
}
