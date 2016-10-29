#ifndef RAIN_H_
#define RAIN_H_
#include "persistent_lib.h"
#include <map>
#include <memory>

namespace wdata {
class Rain : public persistent::Persistent {
private:
  static std::map<double, std::shared_ptr<Rain>> shared_rain;

public:
  double three_hour;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
  std::shared_ptr<Rain> getSharedInstance();
};
}
#endif
