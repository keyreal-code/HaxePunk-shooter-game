package ;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import openfl.text.TextFormatAlign;

/**
 * Game over message.
 * @author Kirill Poletaev
 */
class GameOverScreen extends Entity
{
	private var txt:Text;

	public function new() 
	{
		super();
		layer = -5;
		txt = new Text("Press ENTER to restart", 0, HXP.height / 2 - 50, HXP.width);
		txt.size = 32;
		txt.align = TextFormatAlign.CENTER;
		txt.y = HXP.height / 2 - 50;
		graphic = txt;
	}
	
}