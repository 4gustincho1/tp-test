import jugador.*
import wollok.game.*
import enemigos.*
import objetosNivel.*
import objetos.*
import menu.*
import hud.*

object nivel1 {

	method iniciar() {
		
		const pos = game.at(1,6)
		
		new Hud().draw()
		config.teclas()
		_nivel1.pared()
		_nivel1.enemigo()
		_nivel1.pickups()
		jugador.iniciar(pos)
	}
	
}

object config {
	
	method teclas(){
		keyboard.a().onPressDo({ jugador.irA(jugador.position().left(1)) })
		keyboard.d().onPressDo({ jugador.irA(jugador.position().right(1))})
		keyboard.w().onPressDo({ jugador.irA(jugador.position().up(1))})
		keyboard.s().onPressDo({ jugador.irA(jugador.position().down(1))})
		
		keyboard.left().onPressDo({ jugador.dispararArma(izquierda, jugador)})
		keyboard.right().onPressDo({ jugador.dispararArma(derecha, jugador)})
		keyboard.up().onPressDo({ jugador.dispararArma(arriba, jugador)})
		keyboard.down().onPressDo({ jugador.dispararArma(abajo, jugador)})
		
		keyboard.num1().onPressDo({jugador.cambioArma(JugadorCuchillo)})
		keyboard.num2().onPressDo({jugador.cambioArma(JugadorPistola)})
		keyboard.num3().onPressDo({jugador.cambioArma(JugadorRifle)})
		keyboard.num4().onPressDo({jugador.cambioArma(JugadorGranada)})
		keyboard.num5().onPressDo({jugador.cambioArma(LanzadorTeledirigido)})



	}
}
	
object derecha {
	
	method mover(objeto){return objeto.position().right(1)}	
}

object izquierda {
	
	method mover(objeto){return objeto.position().left(1)}
		
}

object arriba {
	
	method mover(objeto){return objeto.position().up(1)}
		
}

object abajo {
	
	method mover(objeto){return objeto.position().down(1)}
		
}
	
	
	