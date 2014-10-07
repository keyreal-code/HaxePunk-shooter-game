package ;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.masks.Circle;

/**
 * Power up.
 * @author Kirill Poletaev
 */
class PowerUp extends Entity
{
	private var speed:Int;
	private var lifeCounter:LifeCounter;

	public function new(g:Dynamic, lifeCounter:LifeCounter) 
	{
		super();
		graphic = g;
		speed = 5;
		mask = new Circle(12, 12, 12);
		this.lifeCounter = lifeCounter;
	}
	
	override public function update() {
		this.y += speed;
		if (this.y > HXP.height) {
			scene.remove(this);
		}
		
		var collidedEntity = collide("player", x, y);
		if (collidedEntity != null) {
			lifeCounter.updateLives(1);
			scene.remove(this);
		}
	}
	
}