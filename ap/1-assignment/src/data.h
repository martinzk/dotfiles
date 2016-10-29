#ifndef DATA_H
#define DATA_H
#include <map>
#include <string>
#include <memory>
#include "clouds.h"
#include "rain.h"
#include "snow.h"
#include "sys.h"
#include "weather.h"
#include "main.h"
#include "wind.h"
#include "persistent_lib.h"

namespace wdata {

class Data : public persistent::Persistent {
private:
  // only one instance of every dt_text
  static std::map<std::string, std::shared_ptr<std::string>> shared_dt_text;

public:
  int dt;
  Main main;
  // weather is a list in the JSON so we support that it is possible more than
  // one element is read
  std::vector<std::shared_ptr<Weather>> weather;
  std::shared_ptr<Clouds> clouds;
  Wind wind;
  std::shared_ptr<Rain> rain;
  std::shared_ptr<Snow> snow;
  std::shared_ptr<Sys> sys;
  std::shared_ptr<std::string> dt_text;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
};
}
#endif /* DATA_H */
