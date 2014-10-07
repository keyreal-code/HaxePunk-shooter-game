package ;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

/**
 * Player life counter.
 * @author Kirill Poletaev
 */
class LifeCounter extends Entity
{
	private var lives:Int;
	private var txt:Text;

	public function new(icon:Dynamic) 
	{
		super();
		lives = 0;
		layer = -4;
		
		txt = new Text("", 30);
		txt.color = 0xff0000;
		txt.size = 24;
		
		addGraphic(icon);
		addGraphic(txt);
		
		updateLives(3);
	}
	
	public function updateLives(num:Int):Void {
		lives += num;
		txt.text = lives + "";
		if (lives == 0) {
			cast(scene, MainScene).gameOver();
		}
	}
	
}