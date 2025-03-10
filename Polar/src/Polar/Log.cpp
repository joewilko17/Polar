#include "plpch.h"
#include "Log.h"
#include "spdlog/sinks/stdout_color_sinks.h"

namespace Polar {
    std::shared_ptr<spdlog::logger> Log::s_CoreLogger;
    std::shared_ptr<spdlog::logger> Log::s_ClientLogger;

    void Log::Init() {
        spdlog::set_pattern("%^[%T] %n: %v%$");

        // Initialize core logger with a synchronous console sink
        s_CoreLogger = spdlog::stdout_color_st("POLAR_ENGINE");
        s_CoreLogger->set_level(spdlog::level::trace);

        // Initialize client logger with a synchronous console sink
        s_ClientLogger = spdlog::stdout_color_st("APPLICATION");
        s_ClientLogger->set_level(spdlog::level::trace);
    }
}