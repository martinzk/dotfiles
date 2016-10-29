#ifndef WEATHER_H_
#define WEATHER_H_
#include <string>
#include <map>
#include "persistent_lib.h"

namespace wdata {

class Weather : public persistent::Persistent {
private:
  static std::map<std::pair<int, std::string>, std::shared_ptr<Weather>>
      shared_weather;

public:
  int id;
  std::string main, description, icon;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
  std::shared_ptr<Weather> getSharedInstance();
};
}
#endif
