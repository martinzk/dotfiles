#ifndef JSON_H
#define JSON_H

#include "type_check.h"
#include <fstream>
#include <iostream>
#include <sstream>
#include <tuple>

namespace js {
// 4 - tuple adapter
template <typename T, typename... Args> struct tuple_adapter {

  std::array<const char *, sizeof...(Args)> names;
  std::tuple<Args...> &data;
  T &serializer;

  template <std::size_t I, typename Last> auto parse_i() const {
    serializer.parse(std::get<I>(data), names[I]);
  }

  template <std::size_t I, typename Head, typename Second, typename... Tail>
  auto parse_i() const {
    parse_i<I, Head>();
    parse_i<I + 1, Second, Tail...>();
  }

  auto parse() const { parse_i<0, Args...>(); }
};

struct Deserializer {
  std::ifstream file_stream;
  std::istringstream string_stream;
  std::string element;
  bool eof = false;
  int pos = 0;
  Deserializer(std::string file_path) {
    file_stream.open(file_path, std::ifstream::in);
  }

  // find the name of the type
  size_t end_of_type(const std::string &name) {
    auto end_of_type = element.find('"', pos + 2);
    auto actual_type = element.substr(pos + 2, end_of_type - pos - 2);
    if (actual_type.compare(name) == 0) {
      return end_of_type + 1;
    }
    return 0;
  }

  // root object unnamed
  template <typename T>
  typename std::enable_if<
      t_chk::has_parse<T, decltype(std::declval<Deserializer &>())>::value,
      void>::type
  parse(T &obj) {
    getline(file_stream, element);
    if (element.size() == 0) {
      eof = true;
      file_stream.close();
    } else {
      string_stream.str(element);
      pos = 0;
      obj.parse(*this);
      pos++;
    }
  }
  // objects with parse function
  template <typename T>
  typename std::enable_if<
      t_chk::has_parse<T, decltype(std::declval<Deserializer &>())>::value,
      void>::type
  parse(T &obj, const std::string name) {
    auto new_pos = end_of_type(name);
    if (new_pos != 0) {
      pos = new_pos + 1;
      obj.parse(*this);
      pos++;
    }
  }

  // string value types
  template <typename T>
  typename std::enable_if<t_chk::is_string<T>::value>::type
  parse(T &value, const std::string name) {
    auto new_pos = end_of_type(name);
    if (new_pos != 0) {
      pos = new_pos;
      auto end_of_value = element.find('"', pos + 2);
      value = element.substr(pos + 2, end_of_value - pos - 2);
      pos = end_of_value + 1;
    }
  }

  // char value types
  template <typename T>
  typename std::enable_if<t_chk::is_character<T>::value>::type
  parse(T &value, const std::string name) {
    auto new_pos = end_of_type(name);
    if (new_pos != 0) {
      pos = new_pos;
      size_t end_of_value = element.find('"', pos + 2);
      value = element[pos + 2];
      pos = end_of_value + 1;
    }
  }

  // numerical value types
  template <typename T>
  typename std::enable_if<t_chk::is_numeric<T>::value>::type
  parse(T &value, const std::string name) {
    auto new_pos = end_of_type(name);
    if (new_pos != 0) {
      pos = new_pos + 1;
      string_stream.seekg(pos);
      string_stream >> value;
      pos = string_stream.tellg();
    }
  }

  // container of string value types
  template <typename T>
  typename std::enable_if<t_chk::is_string_container<T>::value>::type
  parse(T &value, const std::string name) {
    using container_type =
        typename std::iterator_traits<t_chk::iterated_t<T>>::value_type;
    size_t new_pos = end_of_type(name) + 2;
    pos = new_pos;
    while (element[pos - 1] != ']') {
      auto el = container_type{};
      auto end_of_value = element.find('"', pos + 2);
      el = element.substr(pos + 1, end_of_value - pos - 1);
      pos = end_of_value + 2;
      value.insert(value.end(), el);
    }
  }

  // container of numerical value types
  template <typename T>
  typename std::enable_if<t_chk::is_numeric_container<T>::value>::type
  parse(T &value, const std::string name) noexcept {
    using container_type =
        typename std::iterator_traits<t_chk::iterated_t<T>>::value_type;
    size_t new_pos = end_of_type(name) + 2;
    pos = new_pos;
    while (element[pos - 1] != ']') {
      auto el = container_type{};
      string_stream.seekg(pos);
      string_stream >> el;
      pos = string_stream.tellg();
      this->insert(value, el);
      pos++;
    }
    insert_pos = 0;
  }

  // call insert if exists
  template <typename T, typename C>
  typename std::enable_if<t_chk::is_insertable<T, C>::value>::type
  insert(T &container, C &val) {
    container.insert(container.begin(), val);
  }

  // else use subscript operator
  int insert_pos = 0;
  template <typename T, typename C> auto insert(T &container, C &val) {
    container[insert_pos++] = val;
  }

  // container of bool value types
  template <typename T>
  typename std::enable_if<t_chk::is_bool_container<T>::value>::type
  parse(T &value, const std::string name) noexcept {
    using container_type =
        typename std::iterator_traits<t_chk::iterated_t<T>>::value_type;
    size_t new_pos = end_of_type(name) + 2;
    pos = new_pos;
    while (element[pos - 1] != ']') {
      auto el = container_type{};
      el = element[pos] == 't' ? true : false;
      if (el) {
        pos += 5;
      } else {
        pos += 6;
      }
      value.insert(value.end(), el);
    }
  }

  // container of objects with parse function
  template <typename T>
  typename std::enable_if<
      t_chk::is_container<T>::value &&
          t_chk::has_parse<
              typename std::iterator_traits<t_chk::iterated_t<T>>::value_type,
              decltype(std::declval<Deserializer &>())>::value,
      void>::type
  parse(T &value, const std::string name) {
    using container_type =
        typename std::iterator_traits<t_chk::iterated_t<T>>::value_type;
    size_t new_pos = end_of_type(name) + 2;
    pos = new_pos;
    while (element[pos - 1] != ']') {
      auto el = container_type{};
      el.parse(*this);
      value.insert(value.end(), el);
      pos += 2;
    }
  }

  // tuple object
  template <typename... Args>
  auto parse(std::array<const char *, sizeof...(Args)> n,
             std::tuple<Args...> &t) {
    tuple_adapter<decltype(*this), Args...>{n, t, *this}.parse();
  }
};

struct Serializer {
  std::string element;
  std::ofstream stream;
  Serializer(std::string file_path) {
    stream.open(file_path);
    element = "";
  }

  // root object unnamed
  template <typename T>
  typename std::enable_if<
      t_chk::has_parse<T, decltype(std::declval<Serializer &>())>::value,
      void>::type
  parse(const T &obj) noexcept {
    element += "{";
    obj.parse(*this);
    element += "}\n";
    stream << element;
    element = "";
  }
  // objects with parse function
  template <typename T>
  typename std::enable_if<
      t_chk::has_parse<T, decltype(std::declval<Serializer &>())>::value,
      void>::type
  parse(const T &obj, const std::string name) noexcept {
    if (element.back() != '{' && element.back() != '[') {
      element += ',';
    }
    element += "\"" + name + "\":{";
    obj.parse(*this);
    element += "}";
  }

  // string or character value type
  template <typename T>
  typename std::enable_if<t_chk::is_string<T>::value ||
                          t_chk::is_character<T>::value>::type
  parse(const T &value, const std::string name) noexcept {
    if (element.back() != '{' && element.back() != '[') {
      element += ',';
    }
    element += "\"" + name + "\":\"" + value + "\"";
  }

  // numerical value type
  template <typename T>
  typename std::enable_if<t_chk::is_numeric<T>::value>::type
  parse(const T &value, const std::string name) noexcept {
    if (element.back() != '{' && element.back() != '[') {
      element += ',';
    }
    element += "\"" + name + "\":" + std::to_string(value);
  }

  // bool value type
  template <typename T>
  typename std::enable_if<t_chk::is_bool<T>::value>::type
  parse(const T &value, const std::string name) {
    if (element.back() != '{' && element.back() != '[') {
      element += ',';
    }
    element += "\"" + name + "\":";
    element += value ? "true" : "false";
  }

  // container of strings
  template <typename T>
  typename std::enable_if<t_chk::is_string_container<T>::value>::type
  parse(const T &value, const std::string name) noexcept {
    if (element.back() != '{' && element.back() != '[') {
      element += ',';
    }
    element += "\"" + name + "\":[";
    for (auto val : value) {
      if (element.back() != '[')
        element += ',';
      element += '"' + val + '"';
    }
    element += "]";
  }

  // container of numerical values
  template <typename T>
  typename std::enable_if<t_chk::is_numeric_container<T>::value>::type
  parse(const T &value, const std::string name) noexcept {
    if (element.back() != '{' && element.back() != '[') {
      element += ',';
    }
    element += "\"" + name + "\":[";
    for (auto val : value) {
      if (element.back() != '[')
        element += ',';
      element += std::to_string(val);
    }
    element += "]";
  }

  // container of bools
  template <typename T>
  typename std::enable_if<t_chk::is_bool_container<T>::value>::type
  parse(const T &value, const std::string name) noexcept {
    if (element.back() != '{' && element.back() != '[') {
      element += ',';
    }
    element += "\"" + name + "\":[";
    for (auto val : value) {
      if (element.back() != '[')
        element += ',';
      element += val ? "true" : "false";
    }
    element += "]";
  }

  // container of objects with parse function
  template <typename T>
  typename std::enable_if<
      t_chk::is_container<T>::value &&
          t_chk::has_parse<
              typename std::iterator_traits<t_chk::iterated_t<T>>::value_type,
              decltype(std::declval<Serializer &>())>::value,
      void>::type
  parse(const T &value, const std::string name) noexcept {
    if (element.back() != '{' && element.back() != '[') {
      element += ',';
    }
    element += "\"" + name + "\":[";
    for (auto val : value) {
      if (element.back() != '[')
        element += ',';
      element += "{";
      val.parse(*this);
      element += "}";
    }
    element += "]";
  }

  // tuple object
  template <typename... Args>
  auto parse(std::array<const char *, sizeof...(Args)> n,
             std::tuple<Args...> t) noexcept {
    tuple_adapter<decltype(*this), Args...>{n, t, *this}.parse();
  }
};

} // js

#endif /* JSON_H */
