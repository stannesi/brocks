package com.yapi.brocks.data
{
	public class Grid extends Object
	{
		private var _rows:uint;
		private var _cols:uint;
		
		private var _grid:Array;
		
		public function Grid(rows:uint, cols:uint)
		{
			this._rows = rows;
			this._cols = cols;
			this._createGrid();
			return;
		}
		
		private function _createGrid():void
		{
			this._grid = new Array(this._rows);
			
			for (var i:int = 0; i < this._rows; i++) {
				this._grid[i] = new Array(this._cols);
			}
			return;
		}
		
		public function isBrockAt(x:int, y:int):Boolean
		{
			if (y < 0)
			{
				return false; 
			}	
			if (x >= 0 && x < this._cols && y < this._rows)
			{
				return this._grid[y][x] != null;
			}
			return true;
		}
		
		public function getBrockAt(x:uint, y:uint):Brock
		{
			return _grid[y][x];
		}
		
		public function setBrock(brock:Brock):void
		{
			if (brock.x >= 0 && brock.x < this._cols && brock.y >= 0 && brock.y < this._rows)
			{
				this._grid[brock.y][brock.x] = brock;
			}
			return;
		}

		public function clearLines():void
		{
			for (var i:int = 0; i < this._rows; i++) {
				this._grid[i] = new Array(this._cols);
			}
			return;
		}

		public function clearFullLines():uint
		{
			var lines:uint = 0;
			var isNotEmpty:Boolean = true;
			
			for (var i:int = 0; i < this._rows; i++) {
				for (var j:int = 0; j < this._cols; j++) {
					if (this._grid[i][j] == null)
					{
						isNotEmpty = false;
						break;
					}
				}
				
				if (isNotEmpty == true)
				{
					this._grid.splice(i, 1);
					this._grid.unshift(new Array(this._cols));

					lines++;
				}
				isNotEmpty = true;
			}
			
			this._updateBrocks();
			
			return lines;
		}
		
		private function _updateBrocks():void
		{
			for (var i:int = 0; i < this._rows; i++) {
				for (var j:int = 0; j < this._cols; j++) {
					if (this._grid[i][j] != null)
					{
						Brock(this._grid[i][j]).x = j;
						Brock(this._grid[i][j]).y = i;
					}
				}
			}
			return;
		}

		// getters
		public function get rows():uint
		{
			return this._rows;
		}
		
		public function get cols():uint
		{
			return this._cols;
		}
		
	}
}