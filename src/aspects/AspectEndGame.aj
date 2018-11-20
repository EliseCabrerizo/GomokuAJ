package aspects;

import ca.uqac.gomoku.core.model.Grid;
import ca.uqac.gomoku.core.model.Spot;

import java.util.ArrayList;
import java.util.List;
import ca.uqac.gomoku.core.Player;
import javafx.scene.paint.Color;

public aspect AspectEndGame {
	
	//Indicateur si la partie est finie
	private static boolean gameIsOver = false;
	private static boolean colorIsChanged = false;
	private static List<Spot> spotsWinLocal = new ArrayList<>(0);
	
	pointcut getWinningStones(List<Spot> spotsWin) : set(List<Spot> Grid.winningStones) && args(spotsWin);
	
	after(List<Spot> spotsWin) : getWinningStones(spotsWin){
		spotsWin.forEach(l -> spotsWinLocal.add(l));
		colorIsChanged = true;
	}
	
	pointcut end(Grid grid) : call(void *.gameOver(Player)) && target(grid) && if(colorIsChanged == true);
	after(Grid grid) : end(grid)
	{
		//
		Player playertemp = new Player("Playertemp", Color.GOLDENROD);
		spotsWinLocal.forEach(l -> grid.placeStone(l.x, l.y, playertemp));
		gameIsOver = true;
	}
	
	pointcut arretDuJeu(): execution(public void placeStone(int, int, Player)) && if(gameIsOver==true);
	void around() : arretDuJeu() {
		//On ne fait rien si la partie est terminee
	}

	/*pointcut changeColor(Grid grid, Player player) : call (void notifyGameOver(Player)) && args (player) && target (grid) && within(Grid);
	after(Grid grid, Player player) : changeColor(grid, player) {		
		//TODO		
	}*/
	
}