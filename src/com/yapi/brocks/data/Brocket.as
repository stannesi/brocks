package com.yapi.brocks.data
{	
	public class Brocket extends Object
	{
		
		private var _brock1:Brock;
		private var _brock2:Brock;
		private var _brock3:Brock;
		private var _brock4:Brock;
		
		private var _type:uint;
		private var _color:int;
		public static var _shadeX:int;

		public function Brocket(type:uint = 100)
		{
			this._type = BrocketType.isValidType(type)? (type) : (BrocketType.random);
			_shadeX = Math.random() * 3;
			this._createBrocket();
		}
		
		private function _createBrocket():void
		{
			switch(this._type)
			{
				// brocket I
				case BrocketType.I: 
				{
					this._createI();
					break;
				}
				// brocket T
				case BrocketType.T:
				{
					this._createT();
					break;
				}
				// brocket L
				case BrocketType.L:
				{
					this._createL();
					break;
				}
				// brocket J
				case BrocketType.J:
				{
					this._createJ();
					break;
				}
				// brocket Z
				case BrocketType.Z:
				{
					this._createZ();
					break;
				}
				// brocket S
				case BrocketType.S:
				{
					this._createS();
					break;
				}
				// brocket O
				case BrocketType.O:
				{
					this._createO();
					break;
				}
				default:
				{
					throw new Error("Invalid Brocket type");
					break;
				}
			}
		}
		// brocket I
		private function _createI():void
		{
			this._brock1 = new Brock(0, 0);
			this._brock2 = new Brock(1, 0);
			this._brock3 = new Brock(2, 0);
			this._brock4 = new Brock(3, 0);
			
			this._brock1.type = this.type;
			this._brock2.type = this.type;
			this._brock3.type = this.type;
			this._brock4.type = this.type;
		}
		// brocket T
		private function _createT():void
		{
			this._brock1 = new Brock(1, 0);
			this._brock2 = new Brock(0, 1);
			this._brock3 = new Brock(1, 1);
			this._brock4 = new Brock(2, 1);
			
			this._brock1.type = this.type;
			this._brock2.type = this.type;
			this._brock3.type = this.type;
			this._brock4.type = this.type;
		}

		// brocket L
		private function _createL():void
		{
			this._brock1 = new Brock(2, 0);
			this._brock2 = new Brock(0, 1);
			this._brock3 = new Brock(1, 1);
			this._brock4 = new Brock(2, 1);
			
			this._brock1.type = this._type;
			this._brock2.type = this._type;
			this._brock3.type = this._type;
			this._brock4.type = this._type;
		}

		// brocket J
		private function _createJ():void
		{
			this._brock1 = new Brock(0, 0);
			this._brock2 = new Brock(0, 1);
			this._brock3 = new Brock(1, 1);
			this._brock4 = new Brock(2, 1);
			
			this._brock1.type = this.type;
			this._brock2.type = this.type;
			this._brock3.type = this.type;
			this._brock4.type = this.type;
		}

		// brocket Z
		private function _createZ():void
		{
			this._brock1 = new Brock(0, 0);
			this._brock2 = new Brock(1, 0);
			this._brock3 = new Brock(1, 1);
			this._brock4 = new Brock(2, 1);
			
			this._brock1.type = this.type;
			this._brock2.type = this.type;
			this._brock3.type = this.type;
			this._brock4.type = this.type;
		}

		// brocket S
		private function _createS():void
		{
			this._brock1 = new Brock(1, 0);
			this._brock2 = new Brock(2, 0);
			this._brock3 = new Brock(1, 1);
			this._brock4 = new Brock(0, 1);
			
			this._brock1.type = this.type;
			this._brock2.type = this.type;
			this._brock3.type = this.type;
			this._brock4.type = this.type;
		}

		// brocket O
		private function _createO():void
		{
			this._brock1 = new Brock(0, 0);
			this._brock2 = new Brock(1, 0);
			this._brock3 = new Brock(0, 1);
			this._brock4 = new Brock(1, 1);
			
			this._brock1.type = this.type;
			this._brock2.type = this.type;
			this._brock3.type = this.type;
			this._brock4.type = this.type;
		}

		// getters
		public function get brock1():Brock
		{
			return this._brock1;
		}

		public function get brock2():Brock
		{
			return this._brock2;
		}

		public function get brock3():Brock
		{
			return this._brock3;
		}

		public function get brock4():Brock
		{
			return this._brock4;
		}
		
		public function get type(): uint
		{
			return this._type;
		}

		public function get color(): uint
		{
			return this._color;
		}
	}
}
