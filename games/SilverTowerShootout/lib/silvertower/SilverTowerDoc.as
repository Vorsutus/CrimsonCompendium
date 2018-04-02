package lib.silvertower {
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class SilverTowerDoc extends MovieClip {
		
		public function SilverTowerDoc() {
			stage.scaleMode = StageScaleMode.NO_BORDER;
			//stage.displayState = StageDisplayState.FULL_SCREEN;
			createStartMenu();
			}
									
		private function createStartMenu(): void {
			var startMenu:StartScreen = new StartScreen();
			addChild(startMenu);
			startMenu.StartButton.addEventListener(MouseEvent.CLICK, startGameHandler);
			}

		private function startGameHandler(evt:MouseEvent):void {
			removeChild(evt.currentTarget.parent);
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);
			createIntro();
			}
		
		private function createIntro():void {
			var goToIntro:Intro = new Intro();
			addChild(goToIntro);
			}
	}
}