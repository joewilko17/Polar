#include "plpch.h"
#include "Application.h"

#include "Polar/Events/ApplicationEvent.h"
#include "Polar/Log.h"

namespace Polar {

	Application::Application()
	{
	}

	Application::~Application()
	{
	}

	void Application::Run()
	{
		WindowResizeEvent e(1920, 1080);
		POLAR_TRACE(e.ToString());
		while (true);
	}

}