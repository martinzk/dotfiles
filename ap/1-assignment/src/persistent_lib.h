#ifndef PERSISTENT_LIB_H
#define PERSISTENT_LIB_H
#include <string>
#include <fstream>
#include <sstream>
#include <memory>
#include <list>
#include <vector>

namespace persistent {

// Forward declaration of serializer and deserializer because they and
// Persistent are dependant
// Serializer and Deserializer are visitors
class Serializer;
class Deserializer;

// visitable Persistent classes can accept a serializer and deserializer visitor
class Persistent {
public:
  virtual void accept(Serializer *) const = 0;
  virtual void accept(Deserializer *) = 0;
};

// for the root json element
class Root : public Persistent {};

class Deserializer {
private:
public:
  // I use these four methods to define a container to be parsed. The reason is
  // that we do not know beforehand how many element we are going to pass into
  // the container, and we need to create a new object every time we do so.
  // However, we do not know inside the runtime derived type of the object. I
  // could have made a function like this:
  // void parse(vector<shared_ptr<Persistent>> &, shared_ptr<Persistent> (*)(),
  //   std::string &&type) override;
  // were the function pointer arguments simply returns a new object. This makes
  // it more difficult to refer to a shared instance and decided therefore not
  // to. It also means that any type of container is supported as it is the
  // implementers job to move the object into a container.
  virtual void parseListBegin(const std::string &&type) = 0;
  virtual void parseListElement(Persistent &) = 0;
  virtual void parseListEnd() = 0;
  virtual bool moreElements() = 0;
  virtual void parse(Root &) = 0;
  virtual void parse(int &, const std::string &&type) = 0;
  virtual void parse(float &, const std::string &&type) = 0;
  virtual void parse(double &, const std::string &&type) = 0;
  virtual void parse(std::string &, const std::string &&type) = 0;
  virtual void parse(Persistent &, const std::string &&type) = 0;
};

class Serializer {
private:
protected:
  // std::string to build JSON element
  std::string element;
  // (output) file stream
  std::ofstream stream;

public:
  virtual void parse(const Root &) = 0;
  virtual void parse(const int &, const std::string &&type) = 0;
  virtual void parse(const float &, const std::string &&type) = 0;
  virtual void parse(const double &, const std::string &&type) = 0;
  virtual void parse(const bool &field, const std::string &&type) = 0;
  virtual void parse(const std::string &, const std::string &&type) = 0;
  virtual void parse(const Persistent &, const std::string &&type) = 0;
  // C array support
  virtual void parse(const std::shared_ptr<Persistent> objects[], int size,
                     const std::string &&type) = 0;
  // The supported containers. This is easily expanded in a manner similar to
  // what is already implemented. Of course the same template (parseContainers)
  // can not be used for all STL types as not all of them uses push_back like
  // the ones supported in this library, but that is simply a matter of defining
  // a new template for the new kinds of containers
  // If we did not have inheritance from an pure abstract class we could have
  // defined templates for every type like the ones defined in the derived
  // JsonSerializer, but this would of course not give us the advantages of
  // the Visitor Pattern.
  virtual void parse(const std::vector<std::shared_ptr<Persistent>> &,
                     const std::string &&type) = 0;
  virtual void parse(const std::vector<int> &objects,
                     const std::string &&type) = 0;
  virtual void parse(const std::vector<float> &objects,
                     const std::string &&type) = 0;
  virtual void parse(const std::vector<double> &objects,
                     const std::string &&type) = 0;
  virtual void parse(const std::vector<bool> &objects,
                     const std::string &&type) = 0;
  virtual void parse(const std::list<std::shared_ptr<Persistent>> &,
                     const std::string &&type) = 0;
  virtual void parse(const std::list<int> &objects,
                     const std::string &&type) = 0;
  virtual void parse(const std::list<float> &objects,
                     const std::string &&type) = 0;
  virtual void parse(const std::list<double> &objects,
                     const std::string &&type) = 0;
  virtual void parse(const std::list<bool> &objects,
                     const std::string &&type) = 0;
};
}
#endif

// 4480 + 4412 + 3411 + 2063 + 4239 = 18.605
