package org.uqbar.pilax.engine

import com.trolltech.qt.gui.QApplication
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.engine.motor.ActorMotor

import static extension org.uqbar.pilax.engine.PythonUtils.*

class Motor {
	QApplication application
	int anchoOriginal
	int altoOriginal
	String titulo
	@Property Ventana ventana
	@Property int camaraX = 0
	@Property int camaraY = 0
	boolean mostrarVentana
	
	new(/* faltan parametros */) {
		// iniciar audio		
	}
	
	def iniciarAplicacion() {
		val String [] a = #[] 
		QApplication.initialize(a)
		application = QApplication.instance()
		
		// HARDCODEO PARA PROBAR!
//		val hello = new QPushButton("Hello World!")
//		hello.resize(120, 40)
//		hello.clicked.connect(QApplication.instance(), "quit()");
//		hello.setWindowTitle("Hello World")
//		hello.show
	}	
	
	def iniciarVentana(int ancho, int alto, String nombre, GestorEscenas gestor) {
		this.anchoOriginal = ancho
		this.altoOriginal = alto
		
		self.titulo = titulo
		self.ventana = new Ventana(null)
		self.ventana.resize(ancho, alto)
		//TODO: falta !!
		
		this.mostrarVentana = true
		
		self.canvas = CanvasNormalWidget(self, actores.todos, ancho, alto, gestor_escenas, self.permitir_depuracion, rendimiento)
	}
	
	def static void main(String[] args) {
		new Motor().iniciarAplicacion
	}
	
	def obtenerActor(String imagen, int x, int y) {
		new ActorMotor(imagen, x, y)
	}
	
	/** Centro de la ventana para situar el punto (0, 0)*/
	def centroFisico() {
        self.anchoOriginal / 2 -> self.altoOriginal / 2
	}
	
	def getArea() {
		(self.anchoOriginal -> self.altoOriginal)
	}
	
	def ejecutarBuclePrincipal(Mundo mundo) {
		QApplication.exec
	}
	
	def getCentroDeLaCamara() {
		(self.camaraX -> self.camaraY)
	}
	
	def setCentroDeLaCamara(Pair<Integer, Integer> centro) {
		self.camaraX = centro.key
        self.camaraY = centro.value
	}

}