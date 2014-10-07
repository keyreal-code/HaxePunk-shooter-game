package ;
import com.haxepunk.Entity;

/**
 * Bullet entity.s
 * @author Kirill Poletaev
 */
class Bullet extends Entity
{

	public function new(g:Dynamic) 
	{
		super();
		graphic = g;
		type = "bullet";
		setHitbox(14, 24, 0, 0);
	}
	
	override public function update() {
		this.y -= 12;
		if (this.y < -50) {
			scene.remove(this);
		}
	}
	
}