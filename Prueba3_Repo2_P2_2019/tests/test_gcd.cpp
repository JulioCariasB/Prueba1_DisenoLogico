#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN

#include <iostream>
#include <chrono>
#include <random>
#include "doctest.h"
#include "VGCD.h"
#include "VGCD_GCD.h"

void reset(VGCD& m) {
    m.rst = 1;
    m.clk = 0;
    m.eval();
    m.clk = 1;
    m.eval();
    m.clk = 0;
    m.rst = 0;
    m.eval();
}

void clockPulse(VGCD& m) {
    m.clk = 1;
    m.eval();
    m.clk = 0;
    m.eval();
}

unsigned getRandNumber() {
    static unsigned seed = std::chrono::steady_clock::now().time_since_epoch().count();
    static std::default_random_engine re(seed);
    std::uniform_int_distribution<> dist(100, (1 << 24)-1);

    return dist(re);
}

static const unsigned finalState = 5;

std::vector<std::tuple<unsigned, unsigned, unsigned>> tests = {
    {134, 567, 1},
    {132, 567, 3},
    {51492, 20636, 28},
    {53316, 33876, 36},
    {5416, 9236, 4},
    {5416, 9232, 8},
    {5406, 9231, 51},
    {5395, 9230, 65},
};

TEST_CASE("GCD test") {
    VGCD m;
    std::vector<int> expected{1, 1, 1, 1, 1, 0};

    for (auto& p : tests) {
        std::vector<int> states{0, 0, 0, 0, 0, 0};
        
        reset(m);
        m.a = std::get<0>(p);
        m.b = std::get<1>(p);
        m.eval();
        
        while (m.GCD->cs != finalState) {
            states[m.GCD->cs] = 1;
            clockPulse(m);
        }
        
        CHECK(states == expected);
        CHECK(m.result == std::get<2>(p));
    }
}
