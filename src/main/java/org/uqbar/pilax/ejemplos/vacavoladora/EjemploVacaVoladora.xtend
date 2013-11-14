package org.uqbar.pilax.ejemplos.vacavoladora

import java.util.List
import org.uqbar.pilax.actores.ActorPuntaje
import org.uqbar.pilax.actores.ActorTexto
import org.uqbar.pilax.actores.PosicionCentro
import org.uqbar.pilax.actores.animacion.ActorBomba
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Fondo
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.motor.GrillaImagen

import static org.uqbar.pilax.utils.Utils.*

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

class EjemploVacaVoladora {
	static ActorPuntaje puntos
	static Vaca vaca
	static List<Item> items = newArrayList
	static List<Actor> enemigos = newArrayList
	
	def static void main(String[] args) {
		Pilas.iniciar

		val fondo = new Fondo('vaca_voladora/nubes.png')
		puntos = new ActorPuntaje(-290, 210)
		val vaca = new Vaca
		
		Pilas.instance.mundo.agregarTarea(2f, [| crearItem]);
		Pilas.instance.mundo.colisiones.agregar(vaca, items, [v,i| cuantoTocaItem(v, i)]);
		Pilas.instance.mundo.agregarTarea(3.3f, [| crearEnemigo ]);
		Pilas.instance.mundo.colisiones.agregar(vaca, enemigos, [v,e| cuantoTocaEnemigo(v, e)]);

		[|new Nube].nTimes(8)
		Pilas.instance.ejecutar
	}

	def static cuantoTocaItem(Vaca vaca, Item i) {
    	i.eliminar
    	puntos.aumentar(10)
    	puntos.escala = 2.0
    	interpolar(puntos, "escala", #[1], 0.2)
    	puntos.rotacion = randint(30, 60)
    	interpolar(puntos, "rotacion", #[0], 0.2)
	}

	def static cuantoTocaEnemigo(Vaca vaca, Actor enemigo) {
	    vaca.perder
	    enemigo.eliminar
	}
	
	def static crearItem() {
		items.add(new Item)
	    return true
	}
    
	def static crearEnemigo() {
	    enemigos.add(new Enemigo)
	    return true
	}
	
}

class Estado {
	@Property Vaca vaca
    new(Vaca vaca) {
        this.vaca = vaca
        iniciar
	}
	
    def void iniciar() {
    }
    
    def void actualizar() {
    }
}

class Ingresando extends Estado {
	int contador
	
	new(Vaca vaca) {
    	super(vaca)
        vaca.definir_animacion(#[3, 4])
        contador = 0
        vaca.x = -380
		interpolar(vaca, "x", #[-170.0], 0.5) 
	}
	
    override actualizar() {
        contador = contador + 1

        if (contador > 50)
            vaca.estado = new Volando(vaca)
    }
}

class Volando extends Estado {

	new(Vaca vaca) {
		super(vaca)
	}
	
	override iniciar() {
        vaca.definir_animacion(#[3, 4])
	}
	
    override actualizar() {
        val velocidad = 5

        if (pilas.mundo.control.arriba)
            vaca.y = vaca.y + velocidad
        else if (pilas.mundo.control.abajo)
            vaca.y = vaca.y - velocidad

		if (vaca.y > 210) vaca.y = 210
		if (vaca.y < -210) vaca.y = -210
    }
}

class Perdiendo extends Estado {

	new(Vaca vaca) {
		super(vaca)
	}
	
	override iniciar() {
        vaca.definir_animacion(#[0])
        vaca.centroRelativo = PosicionCentro.centrada
	}
    
    override actualizar() {
    	vaca => [
        	rotacion = rotacion + 7
        	escala = escala + 0.01
        	x = x + 1
        	y = y - 1
    	]
    }
}
// ACTORES

class Vaca extends Actor {
	@Property Estado estado
	double contador
	List<Integer> cuadros
	int paso
	
	new() {
        super(new GrillaImagen('vaca_voladora/sprites.png', 5, 1), 0, 0)
        definir_animacion(#[0])
        centro = (140d -> 59d)
        radioDeColision = 40
        x = -170
        estado = new Ingresando(this)
        contador = 0
	}
	
	override GrillaImagen getImagen() {
		super.getImagen() as GrillaImagen
	}
	
    def definir_animacion(List<Integer> cuadros) {
        paso = 0
        self.contador = 0
        this.cuadros = cuadros
    }

    override actualizar() {
        estado.actualizar
        actualizar_animacion
	}
	
    def actualizar_animacion() {
        contador = contador + 0.2

        if (contador > 1) {
            contador = 0
            paso = paso + 1

            if (paso >= len(cuadros))
                paso = 0
		}
		
        imagen.setCuadro(cuadros.get(paso))
    }

    def perder() {
        estado = new Perdiendo(this)
        val t = new ActorTexto("Has perdido ...")
        t.escala = 0.1
        interpolar(t, "escala", #[1], 0.5)
    }
}

class Enemigo extends ActorBomba {

    new() {
        izquierda = 320
        y = randint(-210, 210)
	}
	
    override actualizar() {
        x = x - 5
        super.actualizar()
    }
    
}

class Item extends Actor {

    new() {
        super("estrella.png", 0, 0)
        escala = 0.5
        izquierda = 320
        y = randint(-210, 210)
	}
	
    override actualizar() {
        izquierda = (izquierda - 5).intValue

        if (derecha < -320)
        	eliminar
    }
}

class Nube extends Actor {
	int velocidad

    new() {
        super(choice(#['vaca_voladora/nube1.png', 'vaca_voladora/nube2.png']), 0, 0)
        velocidad = randint(2, 10)
        escala = velocidad / 10.0
        transparencia = velocidad * 6
        z = -1 * (velocidad - 5)
        x = randint(-320, 320)
        y = randint(-210, 210)
	}
	
    override actualizar() {
        x = x - velocidad
        if (derecha < -320)
            reiniciar_posicion
    }

    def reiniciar_posicion() {
        izquierda = 320
        y = randint(-210, 210)
    }
}
