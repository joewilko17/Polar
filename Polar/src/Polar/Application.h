#pragma once

#include "Core.h"
#include "Events/Event.h"
#include "Polar/Events/ApplicationEvent.h"
#include "Window.h"
#include "Polar/LayerStack.h"

namespace Polar {

	class POLAR_API Application
	{
	public:
		Application();
		virtual ~Application();
		void OnEvent(Event& e);
		void Run();

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* overlay);
	private:
		bool OnWindowClose(WindowCloseEvent& e);
		std::unique_ptr<Window> m_Window;
		bool m_Running = true;
		LayerStack m_LayerStack;
	};

	// To be defined in CLIENT
	Application* CreateApplication();

}