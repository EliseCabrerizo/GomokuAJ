package aspects;

import ca.uqac.gomoku.core.model.Grid;

import java.util.List;
import ca.uqac.gomoku.core.GridEventListener;
import ca.uqac.gomoku.core.Player;

public aspect AspectEndGame {

	public List<GridEventListener> Grid.getListeners() {
		return this.listeners;
	}

	pointcut end(Grid grid, Player player) : args(player)&&target(grid)&& call(void *.gameOver(Player));

	after(Grid grid, Player player) : end(grid,player)
	{
	}

}