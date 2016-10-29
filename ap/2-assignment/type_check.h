#ifndef TYPE_CHECK_H
#define TYPE_CHECK_H

#include "detection.h"
#include <iostream>

namespace t_chk {

// has insert function
template <typename T, typename C>
using insert_t = decltype(
    std::declval<T &>().insert(std::declval<T &>().end(), std::declval<C &>()));

template <typename T, typename C>
using is_insertable = is_detected<insert_t, T, C>;

// iteratable type
template <typename C>
using iterated_t = decltype(std::begin(std::declval<C &>()));

// container types
template <typename C> using is_container = is_detected<iterated_t, C>;

// enumerate the character types to consider:
template <typename T, typename C = typename std::remove_cv<T>::type>
struct is_character
    : std::conditional_t<std::is_same<C, char>::value ||
                             std::is_same<C, unsigned char>::value ||
                             std::is_same<C, signed char>::value ||
                             std::is_same<C, wchar_t>::value,
                         std::true_type, std::false_type> {};

// enumerate the numeric types to consider:
template <typename T, typename C = typename std::remove_cv<T>::type>
struct is_integer
    : std::conditional_t<
          std::is_same<C, short int>::value ||
              std::is_same<C, unsigned short int>::value ||
              std::is_same<C, int>::value || std::is_same<C, long int>::value ||
              std::is_same<C, unsigned long int>::value ||
              std::is_same<C, long long int>::value ||
              std::is_same<C, unsigned long long int>::value ||
              std::is_same<C, double>::value || std::is_same<C, float>::value,
          std::true_type, std::false_type> {};

// boolean type
template <typename T, typename C = typename std::remove_cv<T>::type>
struct is_bool : std::conditional_t<std::is_same<C, bool>::value,
                                    std::true_type, std::false_type> {};

// numerical types: primary template
template <typename T, typename = void> struct is_numeric : std::false_type {};

// numerical types: specialization
template <typename T>
struct is_numeric<T, std::enable_if_t<is_integer<T>::value>> : std::true_type {
};

// strings types: primary template
template <typename T, typename = void> struct is_string : std::false_type {};

// pointer types: specialization
template <typename T>
struct is_string<
    T, std::enable_if_t<std::is_pointer<std::remove_reference_t<T>>::value>>
    : is_character<std::remove_pointer_t<std::remove_reference_t<T>>> {};

// string containers: specialization
template <typename T>
struct is_string<T, typename std::enable_if<is_container<T>::value>::type>
    : is_character<typename std::iterator_traits<iterated_t<T>>::value_type> {};

// container of numerical values: primary template
template <typename T, typename = void>
struct is_string_container : std::false_type {};

// container of numerical values: specialization
template <typename T>
struct is_string_container<
    T, typename std::enable_if<is_container<T>::value>::type>
    : is_string<typename std::iterator_traits<iterated_t<T>>::value_type> {};

// container of numerical values: primary template
template <typename T, typename = void>
struct is_numeric_container : std::false_type {};

// container of numerical values: specialization
template <typename T>
struct is_numeric_container<
    T, typename std::enable_if<is_container<T>::value>::type>
    : is_numeric<typename std::iterator_traits<iterated_t<T>>::value_type> {};

// container of bool primary template
template <typename T, typename = void>
struct is_bool_container : std::false_type {};

// container of bool specialization
template <typename T>
struct is_bool_container<T,
                         typename std::enable_if<is_container<T>::value>::type>
    : is_bool<typename std::iterator_traits<iterated_t<T>>::value_type> {};

// parse function
template <class T, class C>
using parsable_t = decltype(std::declval<T &>().parse(std::declval<C &>()));

// parse function
template <class T, class C> using has_parse = is_detected<parsable_t, T, C>;
} // t_chk

#endif /* TYPE_CHECK_H */
