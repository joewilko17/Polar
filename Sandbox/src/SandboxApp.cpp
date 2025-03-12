#include <Polar.h>



class ExampleLayer : public Polar::Layer
{
public:
	ExampleLayer()
		: Layer("Example") {}


	void OnUpdate() override
	{
		if (Polar::Input::IsKeyPressed(POLAR_KEY_TAB))
			POLAR_TRACE("Tab key is pressed (poll)");
	}

	void OnEvent(Polar::Event& event) override
	{
		//POLAR_TRACE("{0}", event.ToString());
		if (event.GetEventType() == Polar::EventType::KeyPressed)
		{
			Polar::KeyPressedEvent& e = (Polar::KeyPressedEvent&)event;
			if (e.GetKeyCode() == POLAR_KEY_TAB)
				POLAR_TRACE("Tab key is pressed (event)!");
			POLAR_TRACE("{0}", (char)e.GetKeyCode());
		}
	}

};

class Sandbox : public Polar::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
		PushOverlay(new Polar::ImGuiLayer());
	}

	~Sandbox()
	{

	}
};

Polar::Application* Polar::CreateApplication()
{
	return new Sandbox();
}