package agent 
{
	import Main;
	import agent.WolfAgent;	
	import agent.states.SheepHerdState;
	import agent.states.SheepWanderState;
	import agent.states.SheepGrazeState;
	import agent.states.SheepFleeState;
	import agent.states.SheepPenState;
	import agent.states.SheepDeadState;
	import agent.states.IAgentState;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.MovieClip;

	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.media.Sound;
	
	
	public class Agent extends MovieClip
	{
		public static const SHEEPGRAZE:IAgentState = new SheepGrazeState(); //Define possible states as static constants
		public static const SHEEPHERD:IAgentState = new SheepHerdState();
		public static const SHEEPWANDER:IAgentState = new SheepWanderState();
		public static const SHEEPFLEE:IAgentState = new SheepFleeState();
		public static const SHEEPPEN:IAgentState = new SheepPenState();
		public static const SHEEPDEAD:IAgentState = new SheepDeadState();

		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var _previousState:IAgentState; //The previous executing state
		private var _currentState:IAgentState; //The currently executing state
		public static var sheepCurrentState:IAgentState;
		private var _pointer:Shape;
		private var _tf:TextField;
		public var velocity:Point = new Point();
		public var speed:Number = 0;
		
		
		public var fleeRadius:Number = 75; //If the target is "seen" within this radius, we want to flee
		public var numCycles:int = 0; //Number of updates that have executed for the current state. Timing utility.
		
		public static var sheepX:Number;
		public static var sheepY;Number;
		
		public static var sheepSpeed:Number;
		
		public var sheep:MovieClip = new tempSheep;
		
		private var _main:Main;
		private var _dead:Main;
		
		public var deadScore:Number = 0;
		
		public function Agent() 
		{
			//constructor code
			_tf = new TextField();
			_tf.defaultTextFormat = new TextFormat("_sans", 10);
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_pointer = new Shape();
			var g:Graphics = _pointer.graphics;
			g.beginFill(0);
			g.drawCircle(0, 0, 5);
			g.endFill();
			g.moveTo(0, -5);
			g.beginFill(0);
			g.lineTo(10, 0);
			g.lineTo(0, 5);
			g.endFill();
			addChild(_tf);
			graphics.lineStyle(0, 0xFF0000, 0);
			graphics.drawCircle(0, 0, fleeRadius);
			graphics.lineStyle(0, 0x00FF00, 0);
			
			addChild(sheep);
			
			_currentState = SHEEPGRAZE; //Set the initial state
			
		}
		
		/**
		 * Outputs a line of text above the agent's head
		 * @param	str
		 */
		
		public function say(str:String):void 
		{
			_tf.text = str;
			_tf.y = -_tf.height - 15;
		}
		
		/**
		 * Trig utility methods
		 */
						
		public function get canSeeLassie ():Boolean {
			var dot:Number = Main.lasX * velocity.x + Main.lasY * velocity.y;
			return dot > 0;
		}
		
		public function get canSeeWolf ():Boolean {
			var wolfdot:Number = WolfAgent.wolfX * velocity.x + WolfAgent.wolfY * velocity.y;
			return wolfdot > 0;
		}
		
		public function get distanceToLassie():Number {
			var dx:Number = x - Main.lasX;
			var dy:Number = y - Main.lasY;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public function get distanceToWolf():Number {
			var dx:Number = x - WolfAgent.wolfX;
			var dy:Number = y - WolfAgent.wolfY;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public function randomDirectionSheep():void {
			var a:Number = Math.random() * 6.28;
			velocity.x = Math.cos(a);
			velocity.y = Math.sin(a);
		}
				
		public function faceLassie(multiplier:Number = 1):void {
			var dx:Number = Main.lasX - x;
			var dy:Number = Main.lasY - y;
			var rad:Number = Math.atan2(dy, dx);
			velocity.x = multiplier*Math.cos(rad);
			velocity.y = multiplier*Math.sin(rad);
		}
		
		public function faceWolf(multiplier:Number = 1):void {
			var dx:Number = WolfAgent.wolfX - x;
			var dy:Number = WolfAgent.wolfY - y;
			var rad:Number = Math.atan2(dy, dx);
			velocity.x = multiplier*Math.cos(rad);
			velocity.y = multiplier*Math.sin(rad);
		}
		
		/**
		 * Update the current state, then update the graphics
		 */
		public function update(main:Main):void {
			if (!_currentState) return; //If there's no behavior, we do nothing
			numCycles++; 
			_currentState.update(this);
			sheepCurrentState = _currentState;
			x += velocity.x*speed;
			y += velocity.y*speed;
			sheepX = x;
			sheepY = y;
			sheepSpeed = speed;
			
			if (x + velocity.x > stage.stageWidth || x + velocity.x < 0) {
				x = Math.max(0, Math.min(stage.stageWidth, x));
				velocity.x *= -1;
			}
			if (y + velocity.y > 500 || y + velocity.y < 280) {
				y = Math.max(0, Math.min(stage.stageHeight, y));
				velocity.y *= -1;
			}
			else if (y > 490) {
					if (x < 350 && x > 250)
						if (Agent.SHEEPHERD){
							//y = 575;
							//x > 200 && x < 400;
							y = 595;
							x = 300;
							//setChildIndex(MovieClip(sheep), numChildren - 5);
							setState(SHEEPPEN);	
							}
					if (y == 595) {
						_main = main;
						_main.addToScore();
						}			
					}
				
			if (velocity.x < 0) {
				sheep.scaleX = -1;
			}
			
			if (velocity.x > 0) {
				sheep.scaleX = 1;
			}	
			
			_pointer.rotation = RAD_DEG * Math.atan2(velocity.y, velocity.x);
		}
			
		public function setState(newState:IAgentState):void {
			if (_currentState == newState) return;
			if (_currentState) {
				_currentState.exit(this);
			}
			_previousState = _currentState;
			_currentState = newState;
			_currentState.enter(this);
			numCycles = 0;
		}
		
		public function get previousState():IAgentState { return _previousState; }
		
		public function get currentState():IAgentState { return _currentState; }
		
	}
}