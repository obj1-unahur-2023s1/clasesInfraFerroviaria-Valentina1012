class VagonesDePasajeros{
	var property largo=0
	var property ancho=0
	var property tieneBanios
	var property estaOrdenado
	
	method cantidadDePasajeros(){
		var cant=0
		if(ancho<=3){
			cant=8*largo
		}else{
			cant=10*largo
		}
		
		if(!estaOrdenado){
			cant-=15
		}
		return cant
	}
	
	method cantidadMaximaDeCarga(){
		var cant=0
		if(tieneBanios){
			cant=300
		}else{
			cant=800
		}
		return cant
	}
	
	method pesoMaximo(){
		return 2000 + 80 * self.cantidadDePasajeros() + self.cantidadMaximaDeCarga()
	}
}


class VagonesDeCarga{
	var property cargaMaximaIdeal=0
	var property cantMaderasSueltas=0
	
	method cantidadMaximaDeCarga(){
		return cargaMaximaIdeal - 400*cantMaderasSueltas
	}
	
	method pesoMaximo(){
		return 1500 + self.cantidadMaximaDeCarga()
	}
}


















