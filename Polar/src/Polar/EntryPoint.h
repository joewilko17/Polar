#ifdef POLAR_PLATFORM_WINDOWS

extern Polar::Application* Polar::CreateApplication();

int main(int argc, char** argv)
{
	printf("Polar Engine v0.1");
	Polar::Log::Init();
	auto app = Polar::CreateApplication();
	app->Run();
	delete app;
}

#endif