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

-- External libraries
group "Dependencies"
		include "Polar/vendor/GLFW"
		include "Polar/vendor/Glad"
		include "Polar/vendor/imgui"
group ""


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
		"opengl32.lib",
		"dwmapi.lib"
	}
	
	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
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
			symbols "On"
			runtime "Release"

		filter "configurations:Release"
			defines "POLAR_RELEASE"
			symbols "On"
			runtime "Release"

		filter "configurations:Dist"
			defines "POLAR_DIST"
			symbols "On"
			runtime "Release"
	
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
			"/utf-8", 
			"/MD"
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

