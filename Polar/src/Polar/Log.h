#pragma once

#include "Core.h"
#include "spdlog/spdlog.h"
#include "spdlog/fmt/ostr.h"

namespace Polar {

	class POLAR_API Log
	{
	public:
		static void Init();

		inline static std::shared_ptr<spdlog::logger>& GetCoreLogger() { return s_CoreLogger; }
		inline static std::shared_ptr<spdlog::logger>& GetClientLogger() { return s_ClientLogger; }
	private:
		static std::shared_ptr<spdlog::logger> s_CoreLogger;
		static std::shared_ptr<spdlog::logger> s_ClientLogger;
	};

}

// Core log macros
#define POLAR_CORE_TRACE(...)		::Polar::Log::GetCoreLogger()->trace(__VA_ARGS__)
#define POLAR_CORE_INFO(...)		::Polar::Log::GetCoreLogger()->info(__VA_ARGS__)
#define POLAR_CORE_WARN(...)		::Polar::Log::GetCoreLogger()->warn(__VA_ARGS__)
#define POLAR_CORE_ERROR(...)		::Polar::Log::GetCoreLogger()->error(__VA_ARGS__)
#define POLAR_CORE_CRITICAL(...)	::Polar::Log::GetCoreLogger()->critical(__VA_ARGS__)

// Client log macros
#define POLAR_TRACE(...)		::Polar::Log::GetClientLogger()->trace(__VA_ARGS__)
#define POLAR_INFO(...)			::Polar::Log::GetClientLogger()->info(__VA_ARGS__)
#define POLAR_WARN(...)			::Polar::Log::GetClientLogger()->warn(__VA_ARGS__)
#define POLAR_ERROR(...)		::Polar::Log::GetClientLogger()->error(__VA_ARGS__)
#define POLAR_CRITICAL(...)		::Polar::Log::GetClientLogger()->critical(__VA_ARGS__)
