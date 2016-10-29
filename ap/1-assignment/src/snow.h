#ifndef SNOW_H_
#define SNOW_H_
#include "persistent_lib.h"
#include <map>
#include <memory>

namespace wdata {
class Snow : public persistent::Persistent {
private:
  static std::map<double, std::shared_ptr<Snow>> shared_snow;

public:
  double three_hour;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
  std::shared_ptr<Snow> getSharedInstance();
};
}
#endif
