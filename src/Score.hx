package ;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Data;
import flash.text.TextFormatAlign;
import com.haxepunk.HXP;

/**
 * Score container and counter.
 * @author Kirill Poletaev
 */
class Score extends Entity
{
	private var score:Text;
	private var points:Int;
	private var highscore:Int;

	public function new() 
	{
		super();
		score = new Text("", 0, 50, HXP.width);
		score.align = TextFormatAlign.CENTER;
		score.size = 24;
		graphic = score;
		layer = -2;
		points = 0;
		
		Data.load("shooterData");
		highscore = Data.read("highscore", 0);
		reset();
	}
	
	public function add(num:Int) {
		points += num;
		if (points > highscore) {
			highscore++;
			Data.write("highscore", highscore);
			Data.save("shooterData");
		}
		score.text = "Score: " + points + "\nHi-score: " + highscore;
	}
	
	public function reset() {
		points = 0;
		score.text = "Score: " + points + "\nHi-score: " + highscore;
	}
	
}