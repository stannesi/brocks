package com.yapi.brocks.dynamics
{
	import com.yapi.brocks.data.Brock;
	import com.yapi.brocks.data.Brocket;
	import com.yapi.brocks.data.BrocketType;
	import com.yapi.brocks.data.Grid;

	public class MotionManager
	{
		private var _grid:Grid;
		
		public function MotionManager(grid:Grid)
		{
			this._grid = grid;
			return;
		}

		private function _getOrientation(x1:int, y1:int, x2:int, y2:int):Number
		{
			var x3:int = x2 - x1;
			var y3:int = y2 - y1;
			var rot:Number = 0;
			
			if (x3 < 0 && y3 < 0 || x3 < 0 && y3 > 0)
			{
				rot = 180;
			} else if (x3 > 0 && y3 < 0){
				rot = 360;
			}
			return Math.atan2(y3, x3); 
		}

		private function _getDistance(x1:int, y1:int, x2:int, y2:int):Number
		{
			var x3:int = x2 -x1;
			var y3:int = y2 - y1;
			return Math.sqrt(x3 * x3 + y3 * y3);
		}
		
		// move brocks down
		public function moveDown(brocket:Brocket):Boolean
		{
			var brock1:Brock = brocket.brock1;
			var brock2:Brock = brocket.brock2;
			var brock3:Brock = brocket.brock3;
			var brock4:Brock = brocket.brock4;
			
			// check the ground so it doesn't go past ground-level 
			if (brock1.y < (this._grid.rows - 1) && brock2.y < (this._grid.rows - 1) && brock3.y < (this._grid.rows - 1) && brock4.y < (this._grid.rows - 1))
			{
				// check is there's a brock at that postion, if so land on top
				if (!this._grid.isBrockAt(brock1.x, brock1.y + 1) && !this._grid.isBrockAt(brock2.x, brock2.y + 1) && !this._grid.isBrockAt(brock3.x, brock3.y + 1) && !this._grid.isBrockAt(brock4.x, brock4.y + 1))
				{
					brock1.y += 1;
					brock2.y += 1;
					brock3.y += 1;
					brock4.y += 1;
					return true;
				}
				return false
			} else {
				return false;
			}
		}

		// move brocks left
		public function moveLeft(brocket:Brocket):Boolean
		{
			var brock1:Brock = brocket.brock1;
			var brock2:Brock = brocket.brock2;
			var brock3:Brock = brocket.brock3;
			var brock4:Brock = brocket.brock4;
			
			// check the left wall so it doesn't go through it
			if (brock1.x > 0 && brock2.x > 0 && brock3.x > 0 && brock4.x > 0)
			{
				// check is there's a brock at that left postion, if so stays beside it
				if (!this._grid.isBrockAt(brock1.x - 1, brock1.y) && !this._grid.isBrockAt(brock2.x - 1, brock2.y) && !this._grid.isBrockAt(brock3.x - 1, brock3.y) && !this._grid.isBrockAt(brock4.x - 1, brock4.y))
				{
					brock1.x -= 1;
					brock2.x -= 1;
					brock3.x -= 1;
					brock4.x -= 1;
					return true;
				}
				return false
			} else {
				return false;
			}
		}
		
		// move brocks right
		public function moveRight(brocket:Brocket):Boolean
		{
			var brock1:Brock = brocket.brock1;
			var brock2:Brock = brocket.brock2;
			var brock3:Brock = brocket.brock3;
			var brock4:Brock = brocket.brock4;
			
			// check the right wall so itdoesn't  go through it
			if (brock1.x < (this._grid.cols - 1) && brock2.x < (this._grid.cols - 1) && brock3.x < (this._grid.cols - 1) && brock4.x < (this._grid.cols - 1))
			{
				// check is there's a brock at that left postion, if so stays beside it
				if (!this._grid.isBrockAt(brock1.x + 1, brock1.y) && !this._grid.isBrockAt(brock2.x + 1, brock2.y) && !this._grid.isBrockAt(brock3.x + 1, brock3.y) && !this._grid.isBrockAt(brock4.x + 1, brock4.y))
				{
					brock1.x += 1;
					brock2.x += 1;
					brock3.x += 1;
					brock4.x += 1;
					return true;
				}
				return false;
			} else {
				return false;
			}
		}

		public function rotate(brocket:Brocket, rot:int = 90) : Boolean
		{
			var b1x:int = 0;
			var b1y:int = 0;
			
			var b2x:int = 0;
			var b2y:int = 0;
			
			var b3x:int = 0;
			var b3y:int = 0;
			
			var b4x:int = 0;
			var b4y:int = 0;
			
			var d1:Number = NaN;
			var d2:Number = NaN;
			var d3:Number = NaN;
			
			var o1:Number = NaN;
			var o2:Number = NaN;
			var o3:Number = NaN;
			
			if (brocket.type != BrocketType.O)
			{
				b1x = brocket.brock1.x;
				b1y = brocket.brock1.y;

				b2x = brocket.brock2.x;
				b2y = brocket.brock2.y;

				b3x = brocket.brock3.x;
				b3y = brocket.brock3.y;
								
				b4x = brocket.brock4.x;
				b4y = brocket.brock4.y;
				
				d1 = this._getDistance(b1x, b1y, b3x, b3y);
				d2 = this._getDistance(b2x, b2y, b3x, b3y);
				d3 = this._getDistance(b4x, b4y, b3x, b3y);
				
				o1 = this._getOrientation(b1x, b1y, b3x, b3y);
				o2 = this._getOrientation(b2x, b2y, b3x, b3y);
				o3 = this._getOrientation(b4x, b4y, b3x, b3y);
				
				o1 = o1 - rot * Math.PI / 180;
				o2 = o2 - rot * Math.PI / 180;
				o3 = o3 - rot * Math.PI / 180;
				
				b1x = b3x + Math.round(d1 * Math.cos(o1));
				b1y = b3y + Math.round(d1 * Math.sin(o1));
				
				b2x = b3x + Math.round(d2 * Math.cos(o2));
				b2y = b3y + Math.round(d2 * Math.sin(o2));
				
				b4x = b3x + Math.round(d3 * Math.cos(o3));
				b4y = b3y + Math.round(d3 * Math.sin(o3));
				
				if (!this._grid.isBrockAt(b1x, b1y) && !this._grid.isBrockAt(b2x, b2y) && !this._grid.isBrockAt(b4x, b4y))
				{
					brocket.brock1.x = b1x;
					brocket.brock1.y = b1y;
					
					brocket.brock2.x = b2x;
					brocket.brock2.y = b2y;
					
					brocket.brock4.x = b4x;
					brocket.brock4.y = b4y;
					return true;
				}
				return false;
			}
			else
			{
				return false;
			}
		}
	}
}