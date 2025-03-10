#include <Polar.h>

class Sandbox : public Polar::Application
{
public:
	Sandbox()
	{

	}

	~Sandbox()
	{

	}
};

Polar::Application* Polar::CreateApplication()
{
	return new Sandbox();
}