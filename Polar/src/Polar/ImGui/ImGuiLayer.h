#pragma once

#include "Polar/Layer.h"

#include "Polar/Events/KeyEvent.h"
#include "Polar/Events/MouseEvent.h"
#include "Polar/Events/ApplicationEvent.h"

namespace Polar {
	
	class POLAR_API ImGuiLayer : public Layer
	{
	public:
		ImGuiLayer();
		~ImGuiLayer();

		virtual void OnAttach() override;
		virtual void OnDetach() override;
		virtual void OnImGuiRender() override;

		void Begin();
		void End();
	private:
		float m_Time = 0.0f;
	};
}

