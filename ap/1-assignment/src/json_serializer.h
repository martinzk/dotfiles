#ifndef JSON_SERIALIZER
#define JSON_SERIALIZER
#include <string>
#include <fstream>
#include <sstream>
#include <memory>
#include <list>
#include <vector>
#include "persistent_lib.h"

namespace persistent {
// definition of a Json Serializer
class WriteJson : public Serializer {
private:
  // template for int, float, and double types because they are similar in JSON
  template <typename T>
  void parseNumerics(const T &field, const std::string &type) {
    if (element.back() != '[' && element.back() != '{') {
      element += ',';
    }
    element += "\"" + type + "\":" + std::to_string(field);
  }
  // template for containers with basic types using push_back.
  // the containers begin and end iterator is passed as argument.
  template <typename Iterator>
  void parseContainers(Iterator first, Iterator last, const std::string &type) {
    if (element.back() != '[' && element.back() != '{') {
      element += ",";
    }
    element += "\"" + type + "\":[";
    if (first != last) {
      for (; first != last; ++first) {
        if (element.back() != '[')
          element += ',';
        element += std::to_string(*first);
      }
    }
    element += "]";
  }
  // template for containers of class types using their iterators
  template <typename Iterator>
  void parseObjContainers(Iterator first, Iterator last,
                          const std::string &type) {
    if (element.back() != '[' && element.back() != '{') {
      element += ",";
    }
    element += "\"" + type + "\":[";
    if (first != last) {
      for (; first != last; ++first) {
        if (element.back() != '[')
          element += ',';
        element += '{';
        (*first)->accept(this);
        element += '}';
      }
    } else
      element += "{}"; // empty std::list
    element += "]";
  }

public:
  WriteJson(const std::string filename);
  void parse(const Root &object) override;
  void parse(const Persistent &object, const std::string &&type) override;
  void parse(const int &field, const std::string &&type) override;
  void parse(const float &field, const std::string &&type) override;
  void parse(const double &field, const std::string &&type) override;
  void parse(const bool &field, const std::string &&type) override;
  void parse(const std::string &field, const std::string &&type) override;
  void parse(const std::shared_ptr<Persistent> objects[], int size,
             const std::string &&type) override;
  void parse(const std::vector<std::shared_ptr<Persistent>> &objects,
             const std::string &&type) override;
  void parse(const std::vector<int> &objects,
             const std::string &&type) override;
  void parse(const std::vector<float> &objects,
             const std::string &&type) override;
  void parse(const std::vector<double> &objects,
             const std::string &&type) override;
  void parse(const std::vector<bool> &objects,
             const std::string &&type) override;
  void parse(const std::list<std::shared_ptr<Persistent>> &,
             const std::string &&type) override;
  void parse(const std::list<int> &objects, const std::string &&type) override;
  void parse(const std::list<float> &objects,
             const std::string &&type) override;
  void parse(const std::list<double> &objects,
             const std::string &&type) override;
  void parse(const std::list<bool> &objects, const std::string &&type) override;
};
}
#endif
