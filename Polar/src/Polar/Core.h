#pragma once

#ifdef POLAR_PLATFORM_WINDOWS
	#ifdef POLAR_BUILD_DLL
		#define POLAR_API __declspec(dllexport)
	#else
		#define POLAR_API __declspec(dllimport)
	#endif
#else
		#error  POLAR only supports windows
#endif

#ifdef POLAR_ENABLE_ASSERTS
	#define POLAR_ASSERT(x, ...) { if(!(x)) { POLAR_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
	#define POLAR_CORE_ASSERT(x, ...) { if(!(x)) { POLAR_CORE_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
#else
	#define POLAR_ASSERT(x, ...)
	#define POLAR_CORE_ASSERT(x, ...)
#endif

#define BIT(x) (1 << x)