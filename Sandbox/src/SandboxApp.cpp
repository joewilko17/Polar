#include <Polar.h>



class ExampleLayer : public Polar::Layer
{
public:
	ExampleLayer()
		: Layer("Example") {}


	void OnUpdate() override
	{
		POLAR_INFO("ExampleLayer::Update");
	}

	void OnEvent(Polar::Event& event) override
	{
		POLAR_TRACE("{0}", event.ToString());
	}

};

class Sandbox : public Polar::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
	}

	~Sandbox()
	{

	}
};

Polar::Application* Polar::CreateApplication()
{
	return new Sandbox();
}