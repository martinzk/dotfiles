/*
  Name: Martin Zimmer Kristensen
  Compiler: clang version 3.9.0
        clang++ -std=c++14 -Wall -g -pthread main.cpp -o main.out
  json.h: detects whether an object contains a parse function and if it does
  calls it. If it does not contain a parse function we consider it as basic
  type and parse it to/from the file.
  type-check.h: used by json.h for detection of types.
  detection.h: used by type-check.h for detection.
  hourly_16.json has to be in same directory as executable
 */

#include "city-statistics.h"
#include "country-statistics.h"
#include "element.h"
#include "json.h"
#include <algorithm> // for_each, find_if
#include <chrono>
#include <future> // async
#include <vector>

using namespace std::chrono;
using Element = typename WeatherData::Element;
using CityStatistics = typename Statistics::CityStatistics;
using CountryStatistics = typename Statistics::CountryStatistics;

// 6b - demonstration
int main() {
  auto deserializer = js::Deserializer{"hourly_16.json"};
  auto elements = std::vector<Element>{};
  while (!deserializer.eof) {
    auto element = Element{};
    deserializer.parse(element);
    elements.push_back(element);
  }
  // 7 - compute city statistics
  auto city_statistics = std::vector<CityStatistics>{};
  // function for computing city statistics
  auto compute_cities = [&city_statistics =
                             city_statistics](const auto &elements) noexcept {
    auto compute_city = [](const auto &element) noexcept {
      auto avg_temp_day = 0.00, avg_temp_night = 0.00;
      auto daytime_from = "12:00:00", nighttime_from = "00:00:00";
      auto count = 0;
      std::for_each(
          element.data.begin(), element.data.end(),
          [
                &avg_temp_night = avg_temp_night, &avg_temp_day = avg_temp_day,
                daytime_from = daytime_from, nighttime_from = nighttime_from,
                &count = count
          ](auto data) {
            ++count;
            if (daytime_from <= data.dt_txt->substr(11, std::string::npos)) {
              avg_temp_day += data.main.temp;
            } else {
              avg_temp_night += data.main.temp;
            }
          });
      auto city_statistic =
          CityStatistics{element.city.name, avg_temp_night / (count / 2),
                         avg_temp_day / (count / 2)};
      return city_statistic;
    };
    for (auto el : elements) {
      city_statistics.push_back(compute_city(el));
    }
  };

  // 7 - compute country statistics
  auto country_statistics = std::vector<CountryStatistics>{};
  // function for computing country statistics
  auto compute_countries = [&country_statistics = country_statistics](
      const auto &elements) noexcept {
    auto compute_country = [&country_statistics = country_statistics](
        const auto &element) noexcept {
      auto country_statistic = CountryStatistics{};
      auto it = std::find_if(
          country_statistics.begin(), country_statistics.end(),
          [element = element](const auto &country_stat) noexcept {
            return element.city.country.compare(country_stat.country) == 0;
          });
      int index;
      if (it == country_statistics.end()) {
        country_statistic.country = element.city.country;
        country_statistics.push_back(country_statistic);
        index = country_statistics.size() - 1;
      } else {
        index = std::distance(country_statistics.begin(), it);
      }
      std::for_each(element.data.begin(), element.data.end(), [
        index = index, &country_statistics = country_statistics
      ](const auto &data) noexcept {
        if (data.main.temp_max > country_statistics[index].temp_max) {
          country_statistics[index].temp_max = data.main.temp_max;
        } else if (data.main.temp_min < country_statistics[index].temp_min) {
          country_statistics[index].temp_min = data.main.temp_min;
        }
      });
    };
    std::for_each(elements.begin(), elements.end(), compute_country);
  };

  // 8 - concurrency features
  auto t1 = high_resolution_clock::now();
  auto future_countries =
      std::async(std::launch::async, compute_countries, elements);
  auto future_cities = std::async(std::launch::async, compute_cities, elements);
  future_countries.wait();
  future_cities.wait();

  auto t2 = high_resolution_clock::now();
  auto duration = duration_cast<microseconds>(t2 - t1).count();

  std::cout << duration << std::endl;

  country_statistics.clear();
  city_statistics.clear();

  t1 = high_resolution_clock::now();
  compute_countries(elements);
  compute_cities(elements);
  t2 = high_resolution_clock::now();
  duration = duration_cast<microseconds>(t2 - t1).count();

  std::cout << duration;
  /*
    with O2:
    async 7576188
    sync 6841028
    without optimizations:
    async 21995028
    sync 23839428
  */

  auto serializer = js::Serializer{"citystat.json"};
  auto serializer2 = js::Serializer{"countrystat.json"};
  auto cityparse = std::async(
      std::launch::async,
      [&serializer = serializer, city_statistics = city_statistics ]() {
        for (const auto element : city_statistics) {
          serializer.parse(element);
        }
      });
  auto countryparse = std::async(
      std::launch::async,
      [&serializer = serializer2, country_statistics = country_statistics ]() {
        for (const auto element : country_statistics) {
          serializer.parse(element);
        }
      });
  cityparse.wait();
  countryparse.wait();
  return 0;
}
