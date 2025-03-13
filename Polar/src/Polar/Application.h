#pragma once

#include "Core.h"

#include "Window.h"
#include "Polar/LayerStack.h"
#include "Events/Event.h"
#include "Polar/Events/ApplicationEvent.h"

#include "ImGui/ImGuiLayer.h"

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

		inline static Application& Get() { return *s_Instance;}
		inline Window& GetWindow() { return *m_Window;  }
	private:
		bool OnWindowClose(WindowCloseEvent& e);
		std::unique_ptr<Window> m_Window;
		ImGuiLayer* m_ImGuiLayer;
		bool m_Running = true;
		LayerStack m_LayerStack;
	private:
		static Application* s_Instance;
	};

	// To be defined in CLIENT
	Application* CreateApplication();

}