package org.uqbar.pilax.engine

import com.trolltech.qt.gui.QApplication
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.engine.motor.ActorMotor

import static extension org.uqbar.pilax.engine.PythonUtils.*
import org.uqbar.pilax.engine.motor.ImagenMotor

class Motor {
	QApplication application
	int anchoOriginal
	int altoOriginal
	String titulo
	@Property Ventana ventana
	@Property int camaraX = 0
	@Property int camaraY = 0
	boolean mostrarVentana
	CanvasNormalWidget canvas
	boolean permitirDepuracion = false
	
	new(/* faltan parametros */) {
		// iniciar audio
		self.iniciarAplicacion()
	}
	
	def iniciarAplicacion() {
		QApplication.initialize(newArrayOfSize(0))
		application = QApplication.instance()
		
		// HARDCODEO PARA PROBAR!
//		val hello = new QPushButton("Hello World!")
//		hello.resize(120, 40)
//		hello.clicked.connect(QApplication.instance(), "quit()");
//		hello.setWindowTitle("Hello World")
//		hello.show
	}	
	
	def iniciarVentana(int ancho, int alto, String titulo, boolean pantalla_completa, GestorEscenas gestor, float rendimiento) {
		this.anchoOriginal = ancho
		this.altoOriginal = alto
		
		self.titulo = titulo
		self.ventana = new Ventana(null)
		self.ventana.resize(ancho, alto)
        self.ventana.setWindowTitle(self.titulo)
		
		self.canvas = new CanvasNormalWidget(self, Pilas.instance.todosActores, ancho, alto, gestor, self.permitirDepuracion, rendimiento)
        self.ventana.canvas = self.canvas
        self.canvas.setFocus


        if (true) {
            self.ventana.show()
            self.ventana.raise
        }

        if (pantalla_completa) {
            self.canvas.pantallaCompleta
        }		
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
	
	def cargarImagen(String path) {
		new ImagenMotor(path)
	}

}