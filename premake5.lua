workspace "Polar"
	architecture "x64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Polar/vendor/GLFW/include"
IncludeDir["Glad"] = "Polar/vendor/Glad/include"
IncludeDir["ImGui"] = "Polar/vendor/imgui"

include "Polar/vendor/GLFW"
include "Polar/vendor/Glad"
include "Polar/vendor/imgui"

project "Polar"
	location "Polar"
	kind "SharedLib"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "plpch.h"
	pchsource "Polar/src/plpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}"
	}

	links 
	{ 
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"

		defines
		{
			"POLAR_PLATFORM_WINDOWS",
			"POLAR_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		buildoptions
		{
			"/utf-8"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
		}

	filter "configurations:Debug"
		defines "POLAR_DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "POLAR_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines "POLAR_DIST"
		runtime "Release"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Polar/vendor/spdlog/include",
		"Polar/src"
	}

	links
	{
		"Polar"
	}

	filter "system:windows"
		cppdialect "C++17"
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
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "POLAR_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines "POLAR_DIST"
		runtime "Release"
		optimize "On"