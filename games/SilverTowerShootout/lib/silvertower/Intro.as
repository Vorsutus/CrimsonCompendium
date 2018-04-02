package lib.silvertower {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.Video;
	import flash.media.SoundMixer;

	public class Intro extends MovieClip {
		private var startIntro:MovieClip;
		private var falling:MovieClip;
		private var scroll:MovieClip;
		
		private var myRequest10:URLRequest = new URLRequest("lib/silvertower/IntroMusic.mp3");
		private var mySound10:Sound = new Sound();
		
		public function Intro() {
			
			startIntro = new IntroMovieFLV();
			startIntro.x = 0;
			startIntro.y = 0;
			
			mySound10.load(myRequest10);
			
			falling = new Falling();
			falling.x = 300;
			falling.y = 200;
			
			scroll = new IntroText();
			scroll.x = 275;
			scroll.y = 241
			
			mySound10.play();
			addChild(startIntro);
			addChild(falling);
			TweenLite.to(falling, 10, {x:100, y:-100, scaleX:2.5, scaleY:2.5, rotation:80, ease:Back.easeIn});
			addChild(scroll);
			addEventListener(MouseEvent.CLICK, skipForward);
			}
		
		private function skipForward(evt:MouseEvent):void {
			removeChild(startIntro);
			removeChild(falling);
			removeChild(scroll)
			SoundMixer.stopAll();
			removeEventListener(MouseEvent.CLICK, skipForward);
			var game:SilverTowerShootoutGame = new SilverTowerShootoutGame();
			addChild(game);
			}
	}
}