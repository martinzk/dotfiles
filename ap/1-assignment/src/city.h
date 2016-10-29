#ifndef CITY_H
#define CITY_H
#include <map>
#include <string>
#include <memory>
#include "coord.h"
#include "persistent_lib.h"

namespace wdata {

class City : public persistent::Persistent {
public:
  static std::map<std::string, std::shared_ptr<std::string>> shared_country;
  int id;
  std::string name;
  std::shared_ptr<std::string> country;
  Coord coord;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
};
}
#endif /* CITY_H */
