workspace "Polar"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Polar"
	location "Polar"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "plpch.h"
	pchsource "Polar/src/plpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include"
	}
	
	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"POLAR_PLATFORM_WINDOWS",
			"POLAR_BUILD_DLL"
		}

		buildoptions 
		{ 
			"/utf-8" 
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

		filter "configurations:Debug"
			defines "POLAR_DEBUG"
			symbols "On"

		filter "configurations:Release"
			defines "POLAR_RELEASE"
			symbols "On"

		filter "configurations:Dist"
			defines "POLAR_DIST"
			symbols "On"
	
project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs
	{
		"Polar/src",
		"Polar/vendor/spdlog/include"
	}

	links
	{
		"Polar"
	}
	
	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"POLAR_PLATFORM_WINDOWS"
		}

		buildoptions 
		{ 
			"/utf-8" 
		}


		filter "configurations:Debug"
			defines "POLAR_DEBUG"
			symbols "On"

		filter "configurations:Release"
			defines "POLAR_RELEASE"
			symbols "On"

		filter "configurations:Dist"
			defines "POLAR_DIST"
			symbols "On"

