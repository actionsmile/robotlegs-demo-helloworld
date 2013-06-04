package robotlegs.bender.demos.simpleapp {
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.demos.simpleapp.controller.appconfig.SimpleAppLaunch;
	import robotlegs.bender.demos.simpleapp.controller.appconfig.SimpleAppPrepare;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	import flash.display.Sprite;

	public class RL2SimpleApplication extends Sprite {
		/**
		 * @private
		 */
		private var context : IContext;
		/**
		 * @private
		 */
		private var appHolder : Sprite;

		public function RL2SimpleApplication() {
			this.appHolder = new Sprite();
			this.context = new	Context().
							install(MVCSBundle).
							configure(new ContextView(this.appHolder), SimpleAppPrepare).
							afterInitializing(this.onContextInitedHandler);
			this.context.initialized && this.onContextInitedHandler();
			this.addChild(this.appHolder);
		}

		/**
		 * @private <code>IContext</code> inited. Lets launch this app
		 */
		private function onContextInitedHandler() : void {
			this.context.configure(SimpleAppLaunch);
		}
	}
}