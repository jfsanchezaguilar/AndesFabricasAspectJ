package aspectos;

import uniandes.cupi2.impuestosCarro.mundo.CalculadorImpuestos;


public aspect AddCars {

	pointcut addCars(CalculadorImpuestos instance, String path): target(instance) && call(public * uniandes.cupi2.impuestosCarro.mundo.CalculadorImpuestos.cargarVehiculos*(String)) && args(path);

	after(CalculadorImpuestos instance, String path) : addCars(instance, path){
		try{
			println("------Add Cars-------");
			CalculadorImpuestos calculador = (CalculadorImpuestos)instance;
			if(path != "data/vehiculosAspecto.txt"){
				println("Loaded New Cars");
				calculador.cargarVehiculos("data/vehiculosAspecto.txt");
				println("Finish Loading");
			}
		}catch(Exception e){
			println("Error Loading new Cars");
			println(e.getMessage());
		}
	}
	
	static final void println(String s) {
		System.out.println(s);
	}

}
