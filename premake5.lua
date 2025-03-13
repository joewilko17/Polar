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
IncludeDir["glm"] = "Polar/vendor/glm"

group "Dependencies"
include "Polar/vendor/GLFW"
include "Polar/vendor/Glad"
include "Polar/vendor/imgui"
group ""

project "Polar"
	location "Polar"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "plpch.h"
	pchsource "Polar/src/plpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}"
	}

	links 
	{ 
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	 -- Disable warnings for fmtlib files
	 filter "files:**/fmt/**"
	 disablewarnings { "26495", "4265", "26812" }

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"POLAR_PLATFORM_WINDOWS",
			"POLAR_BUILD_DLL",
			"GLFW_INCLUDE_NONE",
			"_CRT_SECURE_NO_WARNINGS"
		}

		buildoptions
		{
			"/utf-8"
		}

	filter "configurations:Debug"
		defines "POLAR_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "POLAR_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "POLAR_DIST"
		runtime "Release"
		optimize "on"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

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
		"Polar/src",
		"Polar/vendor",
		"%{IncludeDir.glm}"
	}

	links
	{
		"Polar"
	}

	filter "system:windows"
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
		symbols "on"

	filter "configurations:Release"
		defines "POLAR_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "POLAR_DIST"
		runtime "Release"
		optimize "on"
