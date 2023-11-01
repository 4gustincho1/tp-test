import jugador.*
import enemigos.*
import objetosNivel.*
import wollok.game.*
import objetos.*

class Hud inherits Objeto{
	const setHud = #{self, armaHud, textoCargador, llaveDoradaHud, llaveAzulHud, llaveVerdeHud, llaveRojaHud, llaveNaranjaHud}
	
	method image(){return "hud.png"}
	method draw(){setHud.forEach({i => game.addVisualIn(i, i.position())})}  
}

object armaHud inherits Hud{
	override method position(){return game.at(49,0)}
	override method image(){return jugador.armaSeleccionada().imagenHud()}
}

object textoCargador inherits Hud{
	override method position() = game.at(56,0)
	method text() = (jugador.armaSeleccionada().contador()).toString()
}

class InventarioHud inherits Hud{
	method obj() = ""
	method imagen() = self.obj().toString() + ".png"	
	override method image(){if(jugador.invCheck(self.obj())){return self.imagen()} else return "invisible.png"}
}

object llaveDoradaHud inherits InventarioHud{
	override method obj() = llaveDorada	
	override method position() = game.at(26,1)
}

object llaveAzulHud inherits InventarioHud{
	override method obj() = llaveAzul
	override method position() = game.at(27,1)
}

object llaveVerdeHud inherits InventarioHud{
	override method obj() = llaveVerde	
	override method position() = game.at(28,1)
}

object llaveRojaHud inherits InventarioHud{
	override method obj() = llaveRoja
	override method position() = game.at(29,1)
}

object llaveNaranjaHud inherits InventarioHud{
	override method obj() = llaveNaranja	
	override method position() = game.at(30,1)
}