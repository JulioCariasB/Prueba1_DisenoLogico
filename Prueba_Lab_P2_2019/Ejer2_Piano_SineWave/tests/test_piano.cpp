#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN

#include <iostream>
#include <chrono>
#include <random>
#include "doctest.h"
#include "SineWave.h"

double computeError(const std::vector<unsigned char>& samples)
{
    unsigned count = samples.size();
    double inc = 2.0 * M_PI / count;
    double angle = 0.0;
    double constant = 255 / 2.0;
    double error = 0.0;

    for (unsigned i = 0; i < count; i++) {
        error += fabs( ((sin(angle) * constant + constant)) - static_cast<double>(samples[i]) );
        angle += inc; 
    }
    return error / static_cast<double>(count);
}

TEST_CASE("Sine Wave test") {
    std::vector<uint8_t> samples = getSamples();

    double error = computeError(samples);
    std::cout << "Error: " << error << '\n';
    CHECK(error < 0.6);
}
