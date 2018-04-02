package agent 
{
	import Main;
	import agent.Agent;
	import agent.states.WolfChaseState;
	import agent.states.WolfFleeState;
	import agent.states.WolfStalkState;
	import agent.states.WolfSniffState;
	import agent.states.IWolfAgentState;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.MovieClip;
	import agent.states.SheepFleeState;

	//import flash.events.MouseEvent;
	
	public class WolfAgent extends MovieClip
	{
				
		public static const WOLFSTALK:IWolfAgentState = new WolfStalkState();
		public static const WOLFCHASE:IWolfAgentState = new WolfChaseState();
		public static const WOLFFLEE:IWolfAgentState = new WolfFleeState();
		public static const WOLFSNIFF:IWolfAgentState = new WolfSniffState();
		
		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var _wolfPreviousState:IWolfAgentState; //The previous executing state
		private var _wolfCurrentState:IWolfAgentState; //The currently executing state
	
		public var wolfVelocity:Point = new Point();
		public var wolfSpeed:Number = 0;
		private var _wpointer:Shape;
		private var _wtf:TextField;
		public var wolf:MovieClip;
		
		public var wolfFleeRadius:Number = 75; //If the target is "seen" within this radius, we want to flee
		public var wolfNumCycles:int = 0; //Number of updates that have executed for the current state. Timing utility.
		public var chaseRadius:Number = 150; //If the target is "seen" within this radius, we want to chase
				
		public static var wolfX:Number;
		public static var wolfY:Number;
		
		public var sheep:Agent = new Agent();
		
		public function WolfAgent() 
		{
			//constructor code
			
			//Boring stuff here
			_wtf = new TextField();
			_wtf.defaultTextFormat = new TextFormat("_sans", 15);
			_wtf.autoSize = TextFieldAutoSize.LEFT;
			_wpointer = new Shape();
			var g:Graphics = _wpointer.graphics;
			g.beginFill(0);
			g.drawCircle(0, 0, 5);
			g.endFill();
			g.moveTo(0, -5);
			g.beginFill(0);
			g.lineTo(10, 0);
			g.lineTo(0, 5);
			g.endFill();
			//addChild(_wpointer);
			addChild(_wtf);
			//control circle alphas with last number 0-1
			graphics.lineStyle(0, 0xFF0000, 0);
			graphics.drawCircle(0, 0, wolfFleeRadius);
			graphics.lineStyle(0, 0x00FF00,0);
			graphics.drawCircle(0, 0, chaseRadius);
			
			wolf = new tempWolf();
			wolf.x = _wpointer.x ;
			wolf.y = _wpointer.y + 15;
			addChild(wolf);
			_wolfCurrentState = WOLFSNIFF; //Set the initial state
				
		}
		
		/**
		 * Outputs a line of text above the agent's head
		 * @param	str
		 */
		
		public function wolfSay(str:String):void 
		{
			_wtf.text = str;
			_wtf.y = -_wtf.height - 2;
		}
		
		/**
		 * Trig utility methods
		 */
						
		public function get canSeeLassie ():Boolean {
			var lassieDot:Number = Main.lasX * wolfVelocity.x + Main.lasY * wolfVelocity.y;
			return lassieDot > 0;
		}
		
		public function get canSeeSheep ():Boolean {
			var sheepDot:Number = Agent.sheepX * wolfVelocity.x + Agent.sheepY * wolfVelocity.y;
			return sheepDot > 0;
		}
		
		public function get distanceToLassie():Number {
			var wdx:Number = x - Main.lasX;
			var wdy:Number = y - Main.lasY;
			return Math.sqrt(wdx * wdx + wdy * wdy);
		}
		
		public function get distanceToSheep():Number {
			var wdx:Number = x - Agent.sheepX;
			var wdy:Number = y - Agent.sheepY;
			return Math.sqrt(wdx * wdx + wdy * wdy);
		}
		
		public function randomDirectionWolf():void {
			var w:Number = Math.random() * 6.28;
			wolfVelocity.x = Math.cos(w);
			wolfVelocity.y = Math.sin(w);
		}
		
		public function faceLassie(multiplier:Number = 1):void {
			var wdx:Number = Main.lasX - x;
			var wdy:Number = Main.lasY - y;
			var rad:Number = Math.atan2(wdy, wdx);
			wolfVelocity.x = multiplier*Math.cos(rad);
			wolfVelocity.y = multiplier*Math.sin(rad);
		}
		
		public function faceSheep(multiplier:Number = 1):void {
			var wdx:Number = Agent.sheepX - x;
			var wdy:Number = Agent.sheepY - y;
			var rad:Number = Math.atan2(wdy, wdx);
			wolfVelocity.x = multiplier*Math.cos(rad);
			wolfVelocity.y = multiplier*Math.sin(rad);
		}
			
		/**
		 * Update the current state, then update the graphics
		 */
		 
		public function w_update(main:Main):void {
			if (!_wolfCurrentState) return; //If there's no behavior, we do nothing
			wolfNumCycles++; 
			_wolfCurrentState.w_update(this);
			x += wolfVelocity.x*wolfSpeed;
			y += wolfVelocity.y*wolfSpeed;
			wolfX = x;
			wolfY = y;
			
			/*if (x + wolfVelocity.x < 0) {
				x = Math.max(0, Math.max(stage.stageWidth-700, x));
				wolfVelocity.x *= -1;
			}
			
			if (x + wolfVelocity.x > 600) {
				x = Math.max(0, Math.min(stage.stageWidth+100, x));
				wolfVelocity.x *= -1;
			}*/
			

			x = Math.max(-200, Math.min(stage.stageWidth+200, x));
			
			if (y + wolfVelocity.y > 100) {
				y = Math.max(0, Math.min(stage.stageHeight-100, y));
				wolfVelocity.y *= -1;

			}
			if (y + wolfVelocity.y < 360) {
				y = Math.max(0, Math.max(stage.stageHeight-360, y));
				wolfVelocity.y *= -1;

			}	
			
			if (x + wolfVelocity.x > 800) {
				wolfVelocity.x *= -1;
				wolfSpeed = 4;
			}
			
			if (x + wolfVelocity.x < -200) {
				wolfVelocity.x *= -1;
				wolfSpeed = 4;
			}	
			
			if (wolfVelocity.x < 0) {
				wolf.scaleX = -1;
			}
			
			if (wolfVelocity.x > 0) {
				wolf.scaleX = 1;
			}
			_wpointer.rotation = RAD_DEG * Math.atan2(wolfVelocity.y, wolfVelocity.x);
		}
		
		public function setWolfState(newWolfState:IWolfAgentState):void {
			if (_wolfCurrentState == newWolfState) return;
			
			if (_wolfCurrentState) {
				_wolfCurrentState.w_exit(this);
			}
			_wolfPreviousState = _wolfCurrentState;
			_wolfCurrentState = newWolfState;
			_wolfCurrentState.w_enter(this);
			wolfNumCycles = 0;
		}
		
		public function get wolfPreviousState():IWolfAgentState { return _wolfPreviousState; }
		
		public function get wolfCurrentState():IWolfAgentState { return _wolfCurrentState; }
		
	}
}