class VagonDePasajeros{
	var property largo=0
	var property ancho=0
	var property tieneBanios
	var property estaOrdenado
	var property cantPasajeros=0
	
	method llevaPasajeros()=true
	
	method cantidadMaximaPasajeros(){
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
	
	method cargaMaxima(){
		var cant=0
		if(tieneBanios){
			cant=300
		}else{
			cant=800
		}
		return cant
	}
	
	method pesoMaximo(){
		return 2000 + 80 * self.cantidadMaximaPasajeros() + self.cargaMaxima()
	}
	
	method recibirMantenimiento(){
		if(!estaOrdenado){
			estaOrdenado=true
		}
	}
	
}


class VagonDeCarga{
	var property cargaMaximaIdeal=0
	var property cantMaderasSueltas=0
	const property tieneBanios=false
	const property cantPasajeros=0
	
	method llevaPasajeros()=false
	
	method cargaMaxima(){
		return cargaMaximaIdeal - 400*cantMaderasSueltas
	}
	
	method pesoMaximo(){
		return 1500 + self.cargaMaxima()
	}
	
	method cantidadMaximaPasajeros(){
		return 0
	}
	
	method recibirMantenimiento(){
		cantMaderasSueltas = (cantMaderasSueltas - 2).max(0)
	}
	
}

class VagonDormitorio{
	var property cantCompartimentos=0
	var property camasPorCompartimento=0
	const property tieneBanios=true
	var property cantPasajeros=0
	
	method llevaPasajeros()=true
	
	method cantidadMaximaPasajeros(){
		return cantCompartimentos*camasPorCompartimento
	}
	
	method cargaMaxima(){
		return 1200
	}
	
	method pesoMaximo(){
		return 4000 + 80 * cantPasajeros + self.cargaMaxima()
	}
	
	method recibirMantenimiento(){
	}
	
	
}

class Formacion{
	const vagones=[]
	
	method vagones(){
		return vagones
	}
	method agregarVagon(unVagon){
		vagones.add(unVagon)
	}
	method eliminarVagon(unVagon){
		vagones.remove(unVagon)
	}
	
	method cantMaximaPasajeros(){
		return vagones.sum({vagon=>vagon.cantidadMaximaPasajeros()})
	}
	
	method cantVagonesPopulares(){
		return vagones.count({vagon=>vagon.cantidadMaximaPasajeros()>50})
	}
	
	method esFormacionCarguera(){
		return vagones.all({vagon=>vagon.cargaMaxima()>=1000})
	}
	
	method pesoMaximoDelVagonMasPesado(){
		return vagones.max({vagon=>vagon.pesoMaximo()}).pesoMaximo()
	}
	
	method pesoMaximoDelVagonMasLiviano(){
		return vagones.min({vagon=>vagon.pesoMaximo()}).pesoMaximo()
	}
	
	method dispersionDePesos(){
		return self.pesoMaximoDelVagonMasPesado() - self.pesoMaximoDelVagonMasLiviano()
	}
	
	method cantidadDeBanios(){
		return vagones.count({vagon=>vagon.tieneBanios()})
	}
	
	method hacerMantenimiento(){
		vagones.forEach({vagon=>vagon.recibirMantenimiento()})
	}
	
	method equilibradoEnPasajeros(){
		const vagonesPasajeros=vagones.filter({vagon=>vagon.llevaPasajeros()})
		const maximoPasajeros=vagonesPasajeros.max({vagon=>vagon.cantPasajeros()}).cantPasajeros()
		const minimoPasajeros=vagonesPasajeros.min({vagon=>vagon.cantPasajeros()}).cantPasajeros()
		
		return maximoPasajeros-minimoPasajeros<20
	}
	
	method estaOrganizada(){
		const vagonesOrdenados=vagones.sortedBy({a,b=>a.tieneBanios()!=b.tieneBanios()})
		
		return vagones.all({vagon=>vagon.llevaPasajeros()}) or 
		!vagones.all({vagon=>vagon.llevaPasajeros()}) or self.vagones()==vagonesOrdenados
	}
}
















