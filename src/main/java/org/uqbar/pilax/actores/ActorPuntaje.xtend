package org.uqbar.pilax.actores

class ActorPuntaje extends ActorTexto {

	  /** Inicializa el Puntaje.

        :param texto: El número inicial del puntaje.
        :param x: Posición horizontal para el puntaje.
        :param y: Posición vertical para el puntaje.
        :param color: Color que tendrá el texto de puntaje.
        */
	
	Integer valor
	
	new(int x, int y) {
		this("0", x, y)
	}
	
	new(String texto, int x, int y) {
		super(texto, x, y)
        this.color = color
        valor = Integer.valueOf(texto)
	}
	
    def definir(int puntaje_variable) {
        /** Cambia el texto que se mostrará cómo puntaje.
        :param puntaje_variable: Texto a definir.
        */
        valor = Integer.valueOf(puntaje_variable)
        texto = valor.toString
	}
	
    def aumentar(int cantidad) {
        /** Incrementa el puntaje.
        :param cantidad: La cantidad de puntaje que se aumentará.
        */
        definir(valor + cantidad)
	}
	
    def obtener() {
        /** Retorna el puntaje en forma de número. */
        valor
	}
	
}