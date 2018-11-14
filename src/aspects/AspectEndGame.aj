package aspects;

import ca.uqac.gomoku.core.model.Grid;
import ca.uqac.gomoku.core.model.Spot;

import java.util.ArrayList;
import java.util.List;
import ca.uqac.gomoku.core.Player;

public aspect AspectEndGame {
	
	//Indicateur si la partie est finie
	private static boolean gameIsOver = false;
	private static List<Spot> spotsWin = new ArrayList<>(0);
	
	pointcut end() : call(void *.gameOver(Player));
	after() : end()
	{
		//passage à true de l'indicateur
		gameIsOver = true;
	}
	
	pointcut arretDuJeu(): execution(public void placeStone(int, int, Player)) && if(gameIsOver==true);
	void around() : arretDuJeu() {
		//On ne fait rien si la partie est terminée
	}

	pointcut changeColor(Grid grid, Player player) : call (void notifyGameOver(Player)) && args (player) && args (grid) && within(Grid);
	after(Grid grid, Player player) : changeColor(grid, player) {		
		//TODO		
	}
	
}