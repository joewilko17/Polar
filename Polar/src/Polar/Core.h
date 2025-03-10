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

#define BIT(x) (1 << x)