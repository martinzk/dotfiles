#ifndef CLOUDS_H_
#define CLOUDS_H_
#include "persistent_lib.h"
#include <map>
#include <memory>

namespace wdata {
class Clouds : public persistent::Persistent {
private:
  static std::map<int, std::shared_ptr<Clouds>> shared_clouds;

public:
  int all;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
  std::shared_ptr<Clouds> getSharedInstance();
};
}
#endif
