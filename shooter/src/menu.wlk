import niveles.*
import wollok.game.*

//Para implementar el menu, ver el archivos juego.wpgm
class MostrarMenu{
	var property position
	var property image
	
	method mostrar(){
		game.addVisual(self)
	}
	
	method remover(){
		game.removeVisual(self)
	}
}

object menuP inherits MostrarMenu(image = "menuprincipal.png", position = game.origin()){
	
}

object menuIns_1 inherits MostrarMenu(image = "menuinstrucciones_1.png", position = game.origin()){
	
}

object menuIns_2 inherits MostrarMenu(image = "menuinstrucciones_2.png", position = game.origin()){
	
}

object menuInt inherits MostrarMenu(image = "menuintegrantes.png", position = game.origin()){
	
}

object gameover_1 inherits MostrarMenu(image = "gameover_lvl_1.png", position = game.origin()){
	
}

object win_1 inherits MostrarMenu(image = "win_lvl_1.png", position = game.origin()){
	
}


class Menu{

	method agregarConfiguracion()
	
	method iniciar(){
		self.agregarConfiguracion()
	}
}

object menuPrincipal inherits Menu{
	
	override method agregarConfiguracion(){
		menuP.mostrar()
	}
	
	override method iniciar(){
		super()
		keyboard.i().onPressDo({self.irAInstrucciones()})
		keyboard.c().onPressDo({self.irAIntegrantes()})
		keyboard.enter().onPressDo({self.irANivel()})
	}
	
	method irAInstrucciones(){
		menuP.remover()
		menuInstrucciones.iniciar()
	}
	
	method irAIntegrantes(){
		menuP.remover()
		menuIntegrantes.iniciar()
	}
	
	method irANivel(){
		menuP.remover()
		nivel1.iniciar()
	}
}

object menuInstrucciones inherits Menu{
	
	override method agregarConfiguracion(){
		menuIns_1.mostrar()
	}
	
	override method iniciar(){
		super()
		keyboard.enter().onPressDo({self.irASiguienteMenu()})
	}
	
	method irASiguienteMenu(){
		menuIns_1.remover()
		menuIns_2.mostrar()
		keyboard.backspace().onPressDo({self.eliminarImagen()})
	}
	
	method eliminarImagen(){
		menuIns_2.remover()
		menuPrincipal.iniciar()
	}
}

object menuIntegrantes inherits Menu{
	
	override method agregarConfiguracion(){
		menuInt.mostrar()
	}
	
	override method iniciar(){
		super()
		keyboard.backspace().onPressDo({self.eliminarImagen()})
	}
	
	method eliminarImagen(){
		menuInt.remover()
		menuPrincipal.iniciar()
	}
}

//menu de has perdido lvl 1 por ahora
//Para implementarlo ver archivo=jugador.wlk, objeto=jugador y metodo=morir 
object perderLvl1 inherits Menu{
	
	override method agregarConfiguracion(){
		game.clear()//agrego esto para poder reinicar el nivel
		gameover_1.mostrar()
	}
	
	override method iniciar(){
		super()
		keyboard.enter().onPressDo({self.repetirNivel()})
		keyboard.backspace().onPressDo({self.irAmenuPrincipal()})
	}
	
	method repetirNivel(){
		gameover_1.remover()
		nivel1.iniciar()
	}
	
	method irAmenuPrincipal(){
		gameover_1.remover()
		menuPrincipal.iniciar()
	}
}

//menu ganar lvl 1 por ahora 
//Para implementarlo ver archivo=objectos.wlk, objeto=puertaFinal y metodo=finDelJuego 
object ganarLvl1 inherits Menu{
	
	override method agregarConfiguracion(){
		game.clear()//agrego esto para poder ir al siguente nivel
		win_1.mostrar()
	}
	
	override method iniciar(){
		super()
		keyboard.enter().onPressDo({self.siguienteNivel()})
		keyboard.backspace().onPressDo({self.irAmenuPrincipal()})
	}
	
	method siguienteNivel(){
		win_1.remover()
		menuPrincipal.iniciar()//Como no hay otro nivel, vuelve al menu principal
	}
	
	method irAmenuPrincipal(){
		win_1.remover()
		menuPrincipal.iniciar()
	}
	
}
