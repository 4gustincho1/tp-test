import wollok.game.*
import jugador.*
import objetos.*
import objetosNivel.*
import niveles.*


class EnemigoBase inherits Personaje{
	
	var property direccion = ""
	var property status = false
	
	method image(){return "silvestre.png"}
	
	override method esEnemigo()=true
	
	method inicializar(){
		8.times({i => vidas.add(new Vida())})
		self.vigilar()
		armaSeleccionada = new Pistola(contador = 50)
		game.addVisual(self)
		}

	method vigilar(){
		game.onTick(300, self.identity().toString(), ({
			if(self.alineado(jugador)){
				self.alertar()
			}
		}))
	}
	
	method alertar(){
		global.enemigos().forEach({n => if(position.distance(n.position()) <= 10 and not n.status()){
			game.removeTickEvent(n.identity().toString())
			n.alertado()
			//n.alertar()
			n.perseguir()
		}}) // alerta a los enemigos adyacentes 
	}
	
	method alertado(){
		status = true
	}
	
	method perseguir(){
		game.onTick(500,self.identity().toString(),({
			if(self.alineado(jugador)){self.dispararArma(self.disparaHaciaJugador(), self
			)}// si se alinea con el jugador, dispara 
			
			else{self.irA(self.haciaJugador())}
		}))}
	
		
	method haciaJugador(){ //busca la manera mas rapida de ponerse en linea con el jugador
		if((self.position().x() - jugador.position().x()).abs() >= (self.position().y() - jugador.position().y()).abs()){
			if(self.direccionValida(self.direccionY().mover(self))){return self.direccionY().mover(self)}
			else{return self.direccionX().mover(self)}
		}
		else{if(self.direccionValida(self.direccionX().mover(self))){return self.direccionX().mover(self)} // para que esquiven paredes
			else{return self.direccionY().mover(self)}}		
	}
	
	
	method disparaHaciaJugador(){ //busca la manera mas rapida de ponerse en linea con el jugador
		if((self.position().x() - jugador.position().x()).abs() == 0){
			return self.direccionY()
		}
		else{return self.direccionX()}		
	}
	
	method direccionX(){
		if(self.position().x() > jugador.position().x()){
			return izquierda}
		else{return derecha}
		}
		
	
	method direccionY(){
		if(self.position().y() > jugador.position().y()){
			return abajo}
		else{return arriba}
	}
	
	
	method alineado(personaje){
		return ((self.position().y() == personaje.position().y() 
			and not self.objetoEnX(personaje) or (self.position().x() == personaje.position().x() 
			and not self.objetoEnY(personaje)))
		)
	}
	
	method objetoEnX(personaje){
		const conjunto = []
		(self.position().x()..personaje.position().x()).forEach({n => conjunto.add(game.getObjectsIn(game.at(n , self.position().y())).any({objeto => not objeto.transparente()}))})
		return conjunto.contains(true)
		
	}
	
	method objetoEnY(personaje){
		const conjunto = []
		(self.position().y()..personaje.position().y()).forEach({n => conjunto.add(game.getObjectsIn(game.at(self.position().x() , n)).any({objeto => not objeto.transparente()}))})
		return conjunto.contains(true)
		
	}
	
	override method drop(){
		game.addVisualIn(new MunicionPistola(), position)
	}
	 
	
}

class EnemigoFuerte inherits EnemigoBase{
	
	override method inicializar(){
		14.times({i => vidas.add(new Vida())})
		self.vigilar()
		armaSeleccionada = new Rifle(contador = 50)
		game.addVisual(self)
		}
		
	override method drop(){
		game.addVisualIn(new MunicionRifle(), position)
	}	
	
}

class EnemigoElite inherits EnemigoBase{
	
	override method inicializar(){
		20.times({i => vidas.add(new Vida())})
		self.vigilar()
		armaSeleccionada = new Granada(contador = 50)
		game.addVisual(self)
		}
		
	override method drop(){
		game.addVisualIn(new MunicionRifle(), position)
	}	
	
}

class Goblin inherits EnemigoBase{
    
	var property attack=false
	
    override method image(){
    	if(attack){
    	return "invisible.png"
    	}
    	else
       {return "Goblin.png"}
    }
    override method inicializar(){
		armaSeleccionada = new CuchilloGoblin()
		2.times({i => vidas.add(new Vida())})
		self.vigilar()
		game.addVisual(self)
	}
	
	override method perseguir(){
		
		game.onTick(400,self.identity().toString(),{
			if(self.position().distance(jugador.position())==1)
				{   
					attack=true
					game.removeVisual(self)
					self.dispararArma(self.disparaHaciaJugador(),self)
					game.schedule(200,{game.addVisual(self)})
					attack=false
					
					
				}
			else{
				self.irA(self.haciaJugador())}
				}
			   )
	}
	
	override method haciaJugador(){ //busca la manera mas rapida de ponerse en linea con el jugador
		if((self.position().x() - jugador.position().x()).abs() <= (self.position().y() - jugador.position().y()).abs()){
			if(self.direccionValida(self.direccionY().mover(self))){
				direccion = self.direccionY()
				return self.direccionY().mover(self)
			}
			else{
				direccion = self.direccionX()
				return self.direccionX().mover(self)
			}
		}
		else{if(self.direccionValida(self.direccionX().mover(self))){
			direccion = self.direccionX()
			return self.direccionX().mover(self)
		} // para que esquiven paredes
			else{
				direccion = self.direccionY()
				return self.direccionY().mover(self)
			}}		
	}
	
 }
 
 class CuchilloGoblin inherits Cuchillo{
 	
 	override method image(){return direccion.toString()+"GoblinCuchillo.png"}
 }
 
 class BarrilExplosivo inherits EnemigoBase{
	override method image(){return "barrilExplosivo.png"}
	override method golpeable() = true
	
	override method inicializar(){
		vidas = []
		game.addVisual(self)
		}
	
	override method muerto(){
		game.removeVisual(self)
		new Explosivo().explotar(self.position().x(), self.position().y())
	}
	
	override method vigilar(){}
}
 


