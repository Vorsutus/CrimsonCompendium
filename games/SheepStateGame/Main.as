package {
	import agent.Agent;
	import agent.WolfAgent;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.text.TextField;

	public class Main extends MovieClip 
	{
		private var agents:Vector.<Agent>;
		private var wolfAgents:Vector.<WolfAgent>;
		private var dogvx:Number;
		private var dogvy:Number;
		private var Night:MovieClip = new Nighttime();
		private var pen:MovieClip = new Pen();
		private var winScreen:MovieClip = new Win_screen();
		private var loseScreen:MovieClip = new Lose_screen();
		public var lassie:MovieClip = new tempSheepDog();
		public var wolf:MovieClip = new tempWolf();
		public var numOfSheep:Number;
		public var numOfWolves:Number;
		public var low:Number = 4;
		public var high:Number= 10;
		public var randomNum:Number = Math.floor(Math.random() * (1 + high - low)) + low;
		public var gameNumCycles:int = 0;
		public static var lasX:Number;
		public static var lasY:Number;
		
		private var dingSoundRequest:URLRequest = new URLRequest("Sounds/Ding.mp3");
		private var ding:Sound = new Sound();
		private var winSoundRequest:URLRequest = new URLRequest("Sounds/Win.mp3");
		private var win:Sound = new Sound();
		private var failSoundRequest:URLRequest = new URLRequest("Sounds/Fail.mp3");
		private var fail:Sound = new Sound();
		private var forestSoundRequest1:URLRequest = new URLRequest("Sounds/ForestSounds.mp3");
		private var forest1:Sound = new Sound();
		private var dogBarkRequest2:URLRequest = new URLRequest("Sounds/DogBark.mp3");
		private var bark2:Sound = new Sound();
		
		public static var sheepFleeBAHRequest:URLRequest = new URLRequest("Sounds/SheepSound1.mp3");
		public static var fleebah:Sound = new Sound();
		public static var sheepherdBAHRequest:URLRequest = new URLRequest("Sounds/SheepSound2.mp3");
		public static var herdbah:Sound = new Sound();
		public static var wolfCryRequest:URLRequest = new URLRequest("Sounds/WolfCry1.mp3");
		public static var cryWolf:Sound = new Sound();
		public static var wilhelmRequest:URLRequest = new URLRequest("Sounds/WilhelmScream1.mp3");
		public static var wilhelm:Sound = new Sound();
		public static var morningRequest:URLRequest = new URLRequest("Sounds/MorningSong.mp3");
		public static var morning:Sound = new Sound();	
		public static var wolfScore:Number = 0;
		public var day:Number = 1;
		public var score:Number = 0;
		public var dead:Number = 0;
		public var stuff:Agent = new Agent();
		public var Sheep:Agent = new Agent();
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			
			herdbah.load(sheepherdBAHRequest);
			fleebah.load(sheepFleeBAHRequest);
			cryWolf.load(wolfCryRequest);
			wilhelm.load(wilhelmRequest);
			morning.load(morningRequest);
			win.load(winSoundRequest);
			fail.load(failSoundRequest);
			ding.load(dingSoundRequest);
			
			stop();
			var startMenu:StartScreen = new StartScreen();
			addChild(startMenu);
			startMenu.x = stage.stageWidth/2;
			startMenu.y = stage.stageHeight/2;
			
			startMenu.StartButton.addEventListener(MouseEvent.CLICK, startDirectionHandler);
		}
		
		private function startDirectionHandler(evt:MouseEvent):void {
			ding.play();
			removeChild(evt.currentTarget.parent);
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startDirectionHandler);
			
			var directionMenu:DirectionScreen = new DirectionScreen();
			addChild(directionMenu);
			directionMenu.x = 290;
			directionMenu.y = 295;
			
			directionMenu.OKButton.addEventListener(MouseEvent.CLICK, startGameHandler);
			}
			
		private function startGameHandler(evt:MouseEvent):void {
			ding.play();
			removeChild(evt.currentTarget.parent);
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);
			gotoAndPlay(1);
			init();
			}
			
		private function init(e:Event = null):void 
		{			
			dogvx = 0;
			dogvy = 0;
			lassie.x = 500;
			lassie.y = 450;
			
			numOfSheep = randomNum;
			numOfWolves = 1;
			
			bark2.load(dogBarkRequest2);
			forest1.load(forestSoundRequest1);
			forest1.play();
			morning.play();
			
			addEventListener(Event.ENTER_FRAME, gameloop);
			
			agents = new Vector.<Agent>();
			for (var i:int = 0; i < numOfSheep; i++) 
			{
				var a:Agent = new Agent();
				this.addChildAt(a,10);
				agents.push(a);
				a.x = 10;
				a.y = 300;
				
			this.addChildAt(lassie,10);
				
			}
			
			wolfAgents = new Vector.<WolfAgent>();
			for (var j:int = 0; j < numOfWolves; j++) 
			{
				var w:WolfAgent = new WolfAgent();
				this.addChildAt(w,10);
				wolfAgents.push(w);
				w.x = 650;
				w.y = 255;
			}
			
			addChild(pen);
			
			pen.x = 640;
			pen.y = 570;
			
			addChild(Night);
			
			Night.x = 300;
			Night.y = 300;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);	
		}
			
		private function keyPressedDown(event:KeyboardEvent):void 
		{
			if(event.keyCode == 65 || event.keyCode == 37) {
				//left (65)
				dogvx = -3;
				lassie.scaleX = 1
				lassie.gotoAndPlay(2);
				}
				
			else if (event.keyCode == 68 || event.keyCode == 39) {
				//right (68)
				dogvx = 3;
				lassie.scaleX =-1
				lassie.gotoAndPlay(2);
				}
			else if (event.keyCode == 83 || event.keyCode == 40) {
				//down (83)
				dogvy = 3;
				lassie.gotoAndPlay(2);
				}
			else if (event.keyCode == 87 || event.keyCode == 38) {
				//up (87)
				dogvy = -3;
				lassie.gotoAndPlay(2);
				}
			else if (event.keyCode == Keyboard.SPACE) {
				bark2.play();
				lassie.gotoAndPlay(25);
				}				
			}
			
		private function keyPressedUp (event:KeyboardEvent):void {
				if (event.keyCode == 65 || event.keyCode == 68) {
					dogvx = 0;
					}
				if (event.keyCode == 83 || event.keyCode == 87) {
					dogvy = 0;
					}
				if (event.keyCode == 37 || event.keyCode == 39) {
					dogvx = 0;
					}
				if (event.keyCode == 38 || event.keyCode == 40) {
					dogvy = 0;
					}	
				if (dogvx < 3 && dogvy < 3){
					lassie.gotoAndStop(1);
					}
				}
				
		public function addToScore():void {
				score++;
				ding.play();
				}
				
		public function moveDog():void 
			{
			lassie.x += dogvx;
			lassie.y += dogvy;
				
			if (lassie.x + dogvx > stage.stageWidth || lassie.x + dogvx < 0) {
				lassie.x = Math.max(0, Math.min(stage.stageWidth, lassie.x));
				dogvx *= 1;
				}
			
			if (lassie.y + dogvy > 100) {
				lassie.y = Math.max(0, Math.min(stage.stageHeight - 100, lassie.y));
				dogvy *= 1;
				}
				
			if (lassie.y + dogvy < 360) {
				lassie.y = Math.max(0, Math.max(stage.stageHeight - 360, lassie.y));
				dogvy *= 1;
				}
			
			lasX = lassie.x;
			lasY = lassie.y;
			}
			
		private function addMoreSheep():void {
			for (var i:int = 0; i < numOfSheep; i++) {
				var a:Agent = new Agent();
				this.addChildAt(a,10);
				agents.push(a);
				
				if(gameNumCycles == 1660) {
					a.x = 599;
					a.y = stage.stageHeight/2;
					}
					
				if(gameNumCycles == 3320) {
					a.x = 1;
					a.y = stage.stageHeight/2;
					}
				}
			}
		
			private function addMoreWolves():void {
			for (var j:int = 0; j < numOfWolves; j++) {
				var w:WolfAgent = new WolfAgent();
				this.addChildAt(w,10);
				wolfAgents.push(w);
				
				if(gameNumCycles == 1660) {
					w.x = -50;
					w.y = stage.stageHeight/2;
					}
					
				if(gameNumCycles == 3320) {
					w.x = 650;
					w.y = stage.stageHeight/2;
					}
				}
			}	
			
		private function gameloop(e:Event):void 
		{			
			moveDog();
			gameNumCycles++
			dayBox.text = String(day);
			scoreBox.text = String(score);
			
				if(gameNumCycles == 1660) {
					day++;
					addMoreWolves();
					addMoreSheep();
					}
					
				if(gameNumCycles == 3320) {
					day++;
					addMoreWolves();
					addMoreSheep();
					}
					
				if(gameNumCycles == 4930) {
					gameEnd();
					}
			
			if (wolfScore >= 5){
				gameEnd();
				}
			
			for (var i:int = 0; i < agents.length; i++) 
			{
				agents[i].update(this);
			}
			
			for (var j:int = 0; j < wolfAgents.length; j++) 
			{
				wolfAgents[j].w_update(this);
			}
			
		}
		private function gameEnd():void{
			
			SoundMixer.stopAll();
			
			if (wolfScore == 5){
				addChild(loseScreen);
				fail.play();
				wolfScore = 0;
				}
			
			else if (score > wolfScore){
				addChild(winScreen);
				win.play();
				wolfScore = 0;
				}
				
			loseScreen.YourScore.text = String(score);
				
			winScreen.x = -300;
			winScreen.y = -300;
			
			loseScreen.x = 155;
			loseScreen.y = 325;
			
			removeEventListener(Event.ENTER_FRAME, gameloop);
		}
	}
}