import wollok.game.*
import direcciones.*
import nivel1.*

object bubba {
	var property position = game.origin()
	var property image = "mandy.png"	
	var property energia = 30
	var property direccion = izquierda
	
	
	// BUBBA COME
	
	method comerDos(){
		const consumiblesAdireccion = self.objectoEnCeldaA(direccion).filter{ obj => obj.puedeComerse()}
		//const todosLosConsumibles = [consumiblesArriba,consumiblesderecha,consumiblesAbajo,consumiblesizquierda].flatten()
		consumiblesAdireccion.forEach{ obj =>
			energia = energia+obj.aporta()
			obj.serConsumido()
			game.say(self,"Delicioso")
		}
	
	}
	method comer(){
		const consumiblesArriba = self.objectoEnCeldaA(arriba).filter{ obj => obj.puedeComerse()}
		const consumiblesAbajo = self.objectoEnCeldaA(abajo).filter{ obj => obj.puedeComerse()}
		const consumiblesderecha = self.objectoEnCeldaA(derecha).filter{ obj => obj.puedeComerse()}
		const consumiblesizquierda = self.objectoEnCeldaA(izquierda).filter{ obj => obj.puedeComerse()}
		
		const todosLosConsumibles = [consumiblesArriba,consumiblesderecha,consumiblesAbajo,consumiblesizquierda].flatten()
		todosLosConsumibles.forEach{ obj =>
			energia = energia+obj.aporta()
			obj.serConsumido()
			game.say(self,"Delicioso")
		}
	}
	method empujar(elemento){
		try{
			elemento.movete(self.direccion())
		}catch e{
			energia += elemento.afectar(self)
		}
	}
	method objectoEnCeldaA(dir){
		return game.getObjectsIn(dir.moverSiguiente(position,self))
	}


	method retroceder(){
		position = direccion.opuesto().moverSiguiente(position,self)
	}
		
	method sigueVivo() = self.energia() > 0
	method morir(){
		//Falta implementar imagen al morir y implementar el metodo perder en nivel1
		image = "market.png"
		game.schedule(1500,{
			nivelBloques.perder()
				
			}
		)
		
	}
	//MOVIMIENTOS:
	method avanzar(){
		position = direccion.moverSiguiente(position,self)
		energia-=1
		if(energia == 0){
			self.morir()
		}
	}
}

