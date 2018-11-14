package aspects;

import ca.uqac.gomoku.core.model.Grid;
import java.util.List;
import ca.uqac.gomoku.core.GridEventListener;
import ca.uqac.gomoku.core.Player;

public aspect AspectEndGame {
	
	//Indicateur si la partie est finie
	private static boolean gameIsOver = false;

	pointcut end() : call(void *.gameOver(Player));
	
	after() : end()
	{
		//passage à true de l'indicateur
		gameIsOver = true;
	}
	
	pointcut stopPlaceStone(): execution(public void placeStone(int, int, Player)) && if(gameIsOver==true);
	void around() : stopPlaceStone() {
		//On ne fait rien si la partie est finie
	}

}