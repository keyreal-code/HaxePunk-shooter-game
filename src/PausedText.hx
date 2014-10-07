package ;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import openfl.text.TextFormatAlign;

/**
 * Paused state indicator.
 * @author Kirill Poletaev
 */
class PausedText extends Entity
{
	private var pausedText:Text;

	public function new() 
	{
		super();
		pausedText = new Text("Paused", 0, HXP.height / 2 - 20, HXP.width);
		pausedText.align = TextFormatAlign.CENTER;
		pausedText.size = 40;
		graphic = pausedText;
		layer = -3;
	}
	
}