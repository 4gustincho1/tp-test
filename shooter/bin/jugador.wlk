import wollok.game.*
import enemigos.*
import objetos.*
import objetosNivel.*
import niveles.*
import hud.*
import menu.*



class Personaje inherits Objeto{
	var property vidas = []
	var property armaSeleccionada = JugadorPistola
    
	const property setArmas = #{JugadorPistola, JugadorRifle, JugadorGranada, JugadorCuchillo, LanzadorTeledirigido}
	
	override method golpeable() = true // si colisiona con balas 
		
	method irA(newposition){
		if(self.direccionValida(newposition)){
		position = newposition
			}
	} 
	
	method direccionValida(newposition){
		if(game.getObjectsIn(newposition).isEmpty()){
			return true
		}
		else{return newposition.allElements().all({objeto => not objeto.solido() and not objeto.esEnemigo()})}
	}

	
	method dispararArma(direc, personaje){
		armaSeleccionada.disparar(direc, personaje)
	}
	
	method cambioArma(arma){
		if(setArmas.contains(arma)){
			armaSeleccionada = arma
		}	
	}
	
	method tieneVida(){
		return self.vidas().size() > 0
	}
	
	method eliminarVida(){ //Se elimina una vida o se ejecuta el método muerto si es que ya no tiene ninguna vida.
		if(self.tieneVida()){
			if(game.hasVisual(self.vidas().get(self.vidas().size() - 1))){
				game.removeVisual(self.vidas().get(self.vidas().size() - 1))
			}
			self.vidas().remove(self.vidas().get(self.vidas().size() - 1))
		}
		else{
			self.muerto()
		}
	}
	
	method muerto(){ //Remueve el visual del personaje
		self.drop()
		game.removeVisual(self)
		game.removeTickEvent(self.identity().toString())
	}
	
	method drop(){}
	
	method definirArmaHud(){
		return armaSeleccionada.imagenHud()
	}
	
}

object jugador inherits Personaje{
	const property inventario = []
	
	method image(){ return "pepita.png" }
	
	override method muerto(){
		game.say(self, 'Perdiste che...')//<--Para implementar el menu de game over comentar esto
		//game.schedule(3000, { => game.stop()})//<--Para implementar el menu de game over comentar esto
		perderLvl1.iniciar()//<-----Para implemantar el menu de game over descomentar esto
	}
	
	method iniciar(pos){
		var i = 1
		
		position = pos
		game.addVisual(self)
		self.limpiar()
		
		
		6.times({i => vidas.add(new Vida())})
		self.vidas().forEach({vida => 
			game.addVisualIn(vida, game.at(i,1))
			i += 1
		})
	}
	
	override method irA(newposition){
		if(game.getObjectsIn(newposition).any({objeto => objeto.abrible()})){game.getObjectsIn(newposition).forEach({objeto => objeto.abrir()})}
		super(newposition)
		if(game.colliders(self).any({objeto => objeto.recogible()})){game.colliders(self).forEach({i => i.pickup()})}
	}
	
	method limpiar(){
		self.vidas().clear()
		self.inventario().clear()
		self.setArmas().clear()
		
		self.setArmas().add(JugadorCuchillo)
		self.setArmas().add(JugadorPistola)
	}
	
	method invCheck(objeto){
		return inventario.contains(objeto)
	}

}

const JugadorPistola = new Pistola()
const JugadorRifle = new Rifle()
const JugadorGranada = new Granada()
const JugadorCuchillo = new Cuchillo()
const LanzadorTeledirigido= new ArmaTeledirigida()


class Pistola{
	var property contador = 7
	var cooldown = 1
	
	method disparar(direc, personaje){
		if(not self.vacio() and cooldown == 1 and personaje.tieneVida()){
			cooldown = 0
			new Bala().disparo(direc, personaje)
			contador = contador - 1
			self._cooldown()
		}
	}
	
	method vacio(){return contador == 0}
	
	method _cooldown(){
		game.schedule(500,{=> cooldown = 1})
	}
	
	method recargar(){contador = contador + 5}
	
	method imagenHud(){return "pistolaHud.png"}
	
}

class Rifle{
	var property contador = 18
	var cooldown = 1
	
	method disparar(direc, personaje){
		if(not self.vacio() and cooldown == 1 and personaje.tieneVida()){
			cooldown = 0
			self.rafaga(direc, personaje)
			game.schedule(100,{
				self.rafaga(direc, personaje)
				game.schedule(100,{
					self.rafaga(direc, personaje)
					self._cooldown()
				})
			})
			
			
		}
	}
	
	method rafaga(direc, personaje){
		new Bala().disparo(direc, personaje)
		contador = contador - 1
	}
	
	method vacio(){return contador == 0}
	
	method _cooldown(){
		game.schedule(600,{=> cooldown = 1})
	}
	
	method recargar(){contador = contador + 12}
	
	method imagenHud(){return "rifleHud.png"}
	
}

class Granada{
	var property contador = 3
	var cooldown = 1
	
	method disparar(direc, personaje){
		if(not self.vacio() and cooldown == 1 and personaje.tieneVida()){
			cooldown = 0
			new Explosivo().disparo(direc, personaje)
			contador = contador - 1
			self._cooldown()
		}
	}
	
	method vacio(){return contador == 0}
	
	method _cooldown(){
		game.schedule(1000,{=> cooldown = 1})
	}
	
	method recargar(){contador = contador + 1}
	
	method imagenHud(){return "granadaHud.png"}
	
}

class Cuchillo inherits Objeto{
	const property contador = 0
	var cooldown = 1
	var direccion = arriba
	
	method image(){return direccion.toString() + "Cuchillo.png"} // concatena la direccion con el nombre del arma para cambiar de imagen
	method disparar(direc,personaje){
		if(personaje.tieneVida() and cooldown == 1){
			cooldown = 0
			textoCargador.text()
			direccion = direc
			game.addVisual(self)
			game.schedule(200,({game.removeVisual(self) cooldown = 1}))
			position = direc.mover(personaje)
			if(game.colliders(self).any({objeto => objeto.golpeable()})){
				3.times({i=>impacto.impactar(self)})
			}
		}
	}
	
	method imagenHud(){return "cuchilloHud.png"}
	
	method recargar(){}
	
}

class Bala inherits Objeto{
	const evento = self.identity().toString()
	
	
	method image() {return "alpiste.png"}
	
	
	
	method disparo(direc, personaje){
		game.addVisual(self)
		position = direc.mover(personaje)
		self.colisiona(direc)
		if(game.hasVisual(self)){game.onTick(100,evento, {position = direc.mover(self)
			if(game.colliders(self).any({objeto => objeto.golpeable()})){game.removeTickEvent(evento)}
			self.colisiona(direc)
			})}}
		
	method colisiona(direc){
		if(game.colliders(self).any({objeto => objeto.golpeable()})){
			impacto.impactar(self)
			self.explotar(self.position().x(), self.position().y())
			game.removeVisual(self)}
	}
	
	method explotar(positionX,positionY){}	

}

class Explosivo inherits Bala{
	override method image() {return "granada.png"}
			
	override method explotar(positionX, positionY){
		(positionX-2..positionX+2).forEach({n => new Explosion().explotar(n,positionY)})
		(positionX-1..positionX+1).forEach({n => new Explosion().explotar(n,positionY+1)})
		(positionX-1..positionX+1).forEach({n => new Explosion().explotar(n,positionY-1)})
		new Explosion().explotar(positionX, positionY+2)
		new Explosion().explotar(positionX, positionY-2)
		}
	
}

class ArmaTeledirigida{
	
	var property contador = 6
	var cooldown = 1
	
	method disparar(direc, personaje){
		if(not self.vacio() and cooldown == 1 and personaje.tieneVida()){
			cooldown = 0
			new ProyectilTeledirigido().disparo(direc, personaje)
			contador = contador - 1
			self._cooldown()
		}
	}
	
	method vacio(){return contador == 0}
	
	method _cooldown(){
		game.schedule(500,{=> cooldown = 1})
	}
	
	method recargar(){contador = contador + 5}
	
	method imagenHud(){return "teledirigidaHud.png"}
	
	}

class ProyectilTeledirigido inherits Bala {
    
   
    override method image(){return "teledirigido.png"}
   
    
    override method disparo(direc,personaje)	{
	
	game.addVisual(self)
	position = direc.mover(personaje)
	self.seguir(personaje)
	}
	
   method irA(posicion){
		position=posicion
	}
	
	method seguir(personaje){		
		
		game.onTick(100,evento,{self.irA(self.teledirigido(self.seleccionarEnemigo(personaje)))
		
		if(game.colliders(self).any({objeto => objeto.golpeable()and objeto.identity()!=personaje.identity()}))
			{
			impacto.impactar(self)
			game.removeTickEvent(evento)
			game.removeVisual(self)	
		}})
	}
		
	method seleccionarEnemigo(personaje){
		return game.allVisuals().filter({elemento=>elemento.esEnemigo()}).sortedBy(
			   {enemigoA,enemigoB=>personaje.position().distance(enemigoA.position())<personaje.position().distance(enemigoB.position())}).get(0)
			
	}
	
	method teledirigido(personaje){
		
		if(self.distanciaEnEjeY(personaje) or self.distanciaEnEjeX(personaje)){
			
			if(self.distanciaEnEjeY(personaje)){
				return self.direccionX(personaje).mover(self)
			} 	
			else{
				return self.direccionY(personaje).mover(self)}
			}
	   else {
		   if((self.position().x() - personaje.position().x()).abs() >= (self.position().y() - personaje.position().y()).abs()){
				return self.direccionY(personaje).mover(self)
			}
		   else{
		   		return self.direccionX(personaje).mover(self)
		   }
		}
	}
	
   method distanciaEnEjeX(personaje){
   		return self.position().x() - personaje.position().x().abs()==0
   }
   
   method distanciaEnEjeY(personaje){
   	return self.position().y() - personaje.position().y().abs()==0
   }
   
   method direccionX(personaje){
		if(self.position().x() > personaje.position().x()){
			return izquierda}
		else{return derecha}
		}
		
	
	method direccionY(personaje){
		if(self.position().y() > personaje.position().y()){
			return abajo}
		else{return arriba}
	}
}
class Vida inherits Objeto{
	method image() = "lifeBar.png"
}

object impacto{
	method impactar(objeto){
		if(game.colliders(objeto).any({_objeto => not _objeto.solido() and _objeto.golpeable()})){
		game.colliders(objeto).find({_objeto => not _objeto.solido() and _objeto.golpeable()}).eliminarVida()}}	
	
}





