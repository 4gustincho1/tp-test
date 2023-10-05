import wollok.game.*

object jugador{
	var property position = game.origin()
	var property arma = pistola
	
	method image(){ return "pepita.png" }
		
	method irA(newposition){
		position = newposition
	}
	
	method dispararArma(direc){
		arma.disparar(direc)
	}
}

object pistola{
	var property contador = 6
	var property cargador = [p1,p2,p3,p4,p5,p6,p7]
	
	method disparar(direc){
		if(not self.vacio()){
			self.cargador().get(contador)._evento()
			self.cargador().get(contador).disparo(direc)
			contador = contador - 1
			if (self.vacio()){self.recargar()}
		}
	}
	
	method vacio(){return contador == -1}
	
	method recargar(){
		game.schedule(3000,{=> contador = 6 })
	}
}

class Proyectil{
	var property position = game.origin()
	var evento = "" 
	
	method _evento(){evento = (jugador.arma().cargador().get(jugador.arma().contador())).toString()}
	
	method image() {return "alpiste.png"}
	
	method disparo(direc){
		game.addVisual(self)
		position = direc.mover(jugador)
		game.onTick(100,evento, {position = direc.mover(self)})
		game.onCollideDo(self, {event => game.removeVisual(self) game.removeTickEvent(evento)})
	}
}

object p1 inherits Proyectil{}
object p2 inherits Proyectil{}
object p3 inherits Proyectil{}
object p4 inherits Proyectil{}
object p5 inherits Proyectil{}
object p6 inherits Proyectil{}
object p7 inherits Proyectil{}

object teste{
	method image(){return "silvestre.png"}
}