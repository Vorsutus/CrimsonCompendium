package lib.silvertower {
	
	import flash.display.MovieClip
	import lib.silvertower.Particle;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.utils.getTimer;
    import flash.events.TimerEvent;
    import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.text.*; 
	import lib.silvertower.EnemyFood;
	import flash.media.SoundMixer;
	
	public class SilverTowerShootoutGame extends MovieClip {
		//declaring Variables
		private var shotGunLocation:Point;
		private var shotGunAngle:Number;
		private var shotPointer:MovieClip;
		private var handPointer:MovieClip;
		private var shotRet:MovieClip;
		
		private var vx:Number;
		private var vy:Number;
		
		private var shotMaster:MovieClip;
		private var handMaster:MovieClip;
		private var handBlastMaster:MovieClip;
		private var shotBlastMaster:MovieClip;
		
		private var barrageCount:Number;
		private var barrageSpacing:Number;
		
		private var difficulty:Number;
		private var difficultyRate:Number;
		
		private var enemyFoods:Array;
		private var enemyFoodsLayer:Sprite;
		private var touchLayer:Sprite;
		
		private var enemyFoodSpawnDelay:Number;
		private var enemyFoodSpawnCounter:Number;
		
		private var hud:MovieClip;
		private var backGround:MovieClip;
		private var health:MovieClip;
		private var damage:MovieClip;
				
		private var myRequest1:URLRequest = new URLRequest("lib/silvertower/GunSound.mp3");
		private var mySound1:Sound = new Sound();
		private var myRequest2:URLRequest = new URLRequest("lib/silvertower/ShotgunSound.mp3");
		private var mySound2:Sound = new Sound();
		private var myRequestMain:URLRequest = new URLRequest("lib/silvertower/MainMusic.mp3");
		private var mySoundMain:Sound = new Sound();
		private var myRequest3:URLRequest = new URLRequest("lib/silvertower/EndingMusic.mp3");
		private var mySound3:Sound = new Sound();
		
		private var gameStartTime:uint;
		private var gameTime:uint;
		private var gameTimeField:TextField;
		private var gameTimeFormat:TextFormat = new TextFormat();
		
		private static const pointsForMatch:int = 100;
		private var gameScoreField:TextField;
		private var gameScore:int;
		
		private var statusCheck:String = "From STSG";
		
		public function SilverTowerShootoutGame() {
			// constructor code

			difficultyRate = 0.1;
			difficulty = 3;
			
			enemyFoodSpawnDelay = enemyFoodSpawnCounter = 100;
			
			enemyFoods = new Array();
			
			vx = 0;
			vy = 0;
			
			shotPointer = new shotGunPointer();
			shotPointer.x = 55;
			shotPointer.y = 400;

			handPointer = new handGunPointer();
			handPointer.x = 520;
			handPointer.y = 400;
			
			shotRet = new retical();
			shotRet.x = 250;
			shotRet.y = 200;
			
			shotMaster = new shotGunMaster();
			shotMaster.x = shotPointer.x;
			shotMaster.y = shotPointer.y;
			
			handMaster = new handGunMaster();
			handMaster.x = handPointer.x;
			handMaster.y = handPointer.y;
		
			handBlastMaster = new handGunFireMaster();
			handBlastMaster.x = handPointer.x;
			handBlastMaster.y = handPointer.y;
			
			shotBlastMaster = new shotGunFireMaster();
			shotBlastMaster.x = shotPointer.x;
			shotBlastMaster.y = shotPointer.y;
				
			backGround = new DeathVallyFLV();
			backGround.x = -35;
			backGround.y = 0;
					
			hud = new HUD();
			hud.x = 0;
			hud.y = 0;
			
			health = new HealthBar;
			health.x = 190;
			health.y = 360;
			
			damage = new MortalWounds();
			damage.x = 0-75;
			damage.y = -50;
						
			mySound1.load(myRequest1);
			mySound2.load(myRequest2);
			mySound3.load(myRequest3);
			mySoundMain.load(myRequestMain);
			
			gameTimeField = new TextField();
			gameTimeField.x = 250;
			gameTimeField.y = 365;
			gameTimeField.width = 300;
			gameTimeField.height = 100;	
			gameTimeField.textColor = 0x000000;
			gameTimeField.defaultTextFormat = gameTimeFormat
			
			gameTimeFormat.size = 40;
			gameTimeFormat.font = "Vineta BT"
			
			gameStartTime = getTimer();
			gameTime = 0;
			
			gameScoreField = new TextField();
			gameScoreField.x = 400;
			gameScoreField.y = 100;
			gameScore = 0;
			
			enemyFoodsLayer = new Sprite();
			touchLayer = new Sprite();
			
			mySoundMain.play();
			
			addChild(backGround);
			addChild(enemyFoodsLayer);
			addChild(hud);
			addChild(health);
			addChild(gameTimeField);
			addChild(gameScoreField);
			addChild(touchLayer);
			addChild(shotRet);
			addChild(shotPointer);
			addChild(shotBlastMaster);
			addChild(shotMaster);
			addChild(handPointer);
			addChild(handBlastMaster);
			addChild(handMaster);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ADDED_TO_STAGE, setupTouchLayer);
			addEventListener(Event.ENTER_FRAME,showTime);
			}
				
		private function onEnterFrame(event:Event):void {
						
			//when frame begins get the angle of the shotgun and handgun position controllers
			this.shotPointer.rotation = getAngle(shotPointer.x, shotPointer.y, shotRet.x, shotRet.y);
			this.handPointer.rotation = getAngle(handPointer.x, handPointer.y, mouseX, mouseY);
			shotRet.x += vx;
			shotRet.y += vy;
			
			//Change shotgun and handgun frames to match angle of shot-retical and mouse-aim
			var handGunAngle:Number = handPointer.rotation;
			var shotGunAngle:Number = shotPointer.rotation;
			
			//switch statement to find what angle is true and go to corresponding frame for shotgun and handgun illustrations
			switch (true) {
				case handGunAngle <= 18:
					handMaster.gotoAndPlay(1);
				break; 
				case handGunAngle >= 19 && handGunAngle <= 36:
					handMaster.gotoAndPlay(3);
				break;
				case handGunAngle >= 37 && handGunAngle <= 54:
					handMaster.gotoAndPlay(5);
				break;
				case handGunAngle >= 55 && handGunAngle <= 72:
					handMaster.gotoAndPlay(7);
				break;
				case handGunAngle >= 73:
					handMaster.gotoAndPlay(9);
				break;
				}

			switch (true) {
				case shotGunAngle >= 150:
					shotMaster.gotoAndPlay(5);
				break; 
				case shotGunAngle >= 121 && shotGunAngle <= 149:
					shotMaster.gotoAndPlay(3);
				break;
				case shotGunAngle <= 120:
					shotMaster.gotoAndPlay(1);
				break;
				}
				
			for each (var enemyFood:Particle in enemyFoods) {
				enemyFood.update();
				}
			makeEnemyFoods();
			}
			
		public function showTime(event:Event) {
			gameTime = getTimer()-gameStartTime;
			gameTimeField.text = "Time: "+clockTime(gameTime);
			}
			
			
		public function clockTime(ms:int) {
			var seconds:int = Math.floor(ms/1000);
			var minutes:int = Math.floor(seconds/60);
			seconds -= minutes*60;	
			var timeString:String = minutes+":"+String(seconds+100).substr(1,2);
				
			
			//previously had a bunch of cases for background clips, but updated them all into one
			switch (true) {
				case minutes == 1 && seconds == 46:
					removeChild(backGround);
					removeChild(enemyFoodsLayer);
					removeChild(gameTimeField);
					removeChild(touchLayer);
					//removeChild(damage);
					var splash:MovieClip = new SplashScreen();
					splash.x = 0;
					splash.y = 25;
					addChild(splash);
					splash.gotoAndPlay(1);
					removeEventListener(Event.ENTER_FRAME,showTime);
					removeEventListener(Event.ADDED_TO_STAGE, setupTouchLayer);
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				break;
				}
			return timeString;
			}
			
		public function showGameScore() {
			gameScoreField.text = "Score: "+String(gameScore);
			//gameScore += pointsForMatch;
			showGameScore();
			}
						
		private function setupTouchLayer(event:Event):void {
			
			//touch layer for listening to when mouse and keys are pressed on the stage
			touchLayer.graphics.beginFill(0x000000, 0);
			touchLayer.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			touchLayer.graphics.endFill();
			
			//keyPressedDown is also fireShotGun controller
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			stage.addEventListener(MouseEvent.CLICK, fireHandGun);
			}
			
		private function makeEnemyFoods():void {
			enemyFoodSpawnCounter++;
			
			if (enemyFoodSpawnCounter > enemyFoodSpawnDelay) {
				enemyFoodSpawnCounter = 0;
				enemyFoodSpawnDelay -= difficultyRate;
				difficulty += difficultyRate;
				makeEnemyFood();
				}
			}
			
		public function makeEnemyFood():void {
			var i:int;
			for (i = 0; i < Math.floor(difficulty); i++) {
				var newEnemyFood:EnemyFood = new EnemyFoodMaster();
				
				newEnemyFood.x = Math.random() * 300 + 75;
				newEnemyFood.y = 290;
				
				TweenLite.to(newEnemyFood, 4, {x:250, y:360, scaleX:20, scaleY:20, ease:Quint.easeIn});
				
				newEnemyFood.yVel = (-Math.random() * difficulty) - 5;
				newEnemyFood.xVel = (-Math.random() * difficulty) - 5;
				newEnemyFood.sinMeter = -Math.random() * 10;
				newEnemyFood.bobValue = Math.random() * difficulty;
				
				addEventListener(Particle.PURGE_EVENT, purgeEnemyFoodHandler);
				
				enemyFoodsLayer.addChild(newEnemyFood);
				enemyFoods.push(newEnemyFood);
				}
				 
			for each (var enemyFood:EnemyFood in enemyFoods) {
				if (enemyFood.status == "Attacking") {
					trace ("DAMAGE DAMAGE DAMAGE");
					health.width -= 10;
					}
				if (health.width <= 80) {
					addChild(damage);
					damage.gotoAndPlay(1);
					}
				if (health.width <= 40) {
					damage.gotoAndPlay(50);
					}
				if (health.width < 1) {
					SoundMixer.stopAll();					
					//removeChild(backGround);
					//removeChild(enemyFoodsLayer);
					//removeChild(gameTimeField);
					//removeChild(touchLayer);
					//removeChild(damage);
					var gameover:MovieClip = new GameOver();
					gameover.x = 100;
					gameover.y = 125;
					addChild(gameover);
					gameover.gotoAndPlay(1);
					mySound3.play();
					removeEventListener(Event.ENTER_FRAME,showTime);
					removeEventListener(Event.ADDED_TO_STAGE, setupTouchLayer);
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					}
				}
			}
		
/*		public function createDeathMenu() {
			removeEventListener(Event.ENTER_FRAME,showTime);
			removeEventListener(Event.ADDED_TO_STAGE, setupTouchLayer);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			var endingScene:TryAgain = new TryAgain();
			addChild(endingScene);
			}*/	
			
		private function purgeEnemyFoodHandler(event:Event):void {
			var targetEnemyFood:Particle = Particle(event.target);
			purgeEnemyFood(targetEnemyFood);
			}
			
		private function purgeEnemyFood(targetEnemyFood:Particle):void {
			targetEnemyFood.removeEventListener(Particle.PURGE_EVENT, purgeEnemyFoodHandler);
			try {
				var i:int;
				for (i = 0; i < enemyFoods.length; i++) {
					if (enemyFoods[i].name == targetEnemyFood.name) {
						enemyFoods.splice(i, 1);
						enemyFoodsLayer.removeChild(targetEnemyFood);
						i = enemyFoods.length;
						}
					}
				}
				
			catch(event:Error) {
				trace("Failed to delete enemyFood!", event);
				}
			}
				
		private function fireHandGun(event:MouseEvent):void {

			//matches gun blast object to barrel position
			var tracerAngle:Number = handPointer.rotation;
			
			switch (true) {
				case tracerAngle <= 18:
					handBlastMaster.gotoAndPlay(2);
				break; 
				case tracerAngle >= 19 && tracerAngle <= 36:
					handBlastMaster.gotoAndPlay(5);
				break;
				case tracerAngle >= 37 && tracerAngle <= 54:
					handBlastMaster.gotoAndPlay(8);
				break;
				case tracerAngle >= 55 && tracerAngle <= 72:
					handBlastMaster.gotoAndPlay(11);
				break;
				case tracerAngle >= 73:
					handBlastMaster.gotoAndPlay(14);
				break;
				}
				
				mySound1.play();
				hud.gotoAndPlay(3);
				
			for each (var enemyFood:EnemyFood in enemyFoods) {
				if (enemyFood.status != "Dead" && enemyFood.hitTestPoint(mouseX, mouseY)) {
					var j:uint;
					enemyFood.destroy();
					}
				}
			}
						
		private function keyPressedDown(event:KeyboardEvent):void {
			if(event.keyCode == 65) {
				//left (65)
				vx = -7;
				}
			else if (event.keyCode == 68) {
				//right (68)
				vx = 7;
				}
			else if (event.keyCode == 83) {
				//down (83)
				vy = 7;
				}
			else if (event.keyCode == 87) {
				//up (87)
				vy = -7;
				}
			else if (event.keyCode == Keyboard.SPACE) {
				fireShotGun();
				}
			}
			
		private function keyPressedUp (event:KeyboardEvent):void {
				if (event.keyCode == 65 || event.keyCode == 68) {
					vx = 0;
					}
				else if (event.keyCode == 83 || event.keyCode == 87) {
					vy = 0;
					}
				}
				
		private function fireShotGun():void {
			
			//matches shotgun blast object to doublebarrel position
			var shotTracerAngle:Number = shotPointer.rotation;
			
				switch (true) {
				case shotTracerAngle >= 150:
					shotBlastMaster.gotoAndPlay(8);
				break; 
				case shotTracerAngle >= 121 && shotTracerAngle <= 149:
					shotBlastMaster.gotoAndPlay(5);
				break;
				case shotTracerAngle <= 120:
					shotBlastMaster.gotoAndPlay(2);
				break;
				}
				mySound2.play();
				hud.gotoAndPlay(3);
				
			for each (var enemyFood:EnemyFood in enemyFoods) {	
				if (enemyFood.status != "Dead" && enemyFood.hitTestPoint(shotRet.x, shotRet.y)) {
					enemyFood.destroy();
					}
				}
			}
						
		private function getAngle (x1:Number, y1:Number, x2:Number, y2:Number) {
			var radians:Number = Math.atan2(y1-y2, x1-x2);
			return rad2deg(radians);
			}
			
		private function rad2deg(rad:Number):Number {
			return rad * (180/Math.PI);
			}
	}
}