// gimnasia.wlk
// gimnasia.wlk
////////////////////////RUTINA///////////////////////////////////////////////////////
class Rutina { //template
    method intensidad() //hook

    method descanso(tiempo) //hook

    //helper
    method caloriasQueQuema(tiempo) = 100 * (tiempo - self.descanso(tiempo)) * self.intensidad()
}

class Running inherits Rutina {
    //redefino los hook:

    var property intensidad //setter y getter
    //necesito pasar intensidad por parametro

    override method descanso(tiempo) = if (tiempo > 20) 5 else 2
}

class Maraton inherits Running {
    override method caloriasQueQuema(tiempo) = super(tiempo) * 2
}

class Remo inherits Rutina {
    override method intensidad() = 1.3

    override method descanso(tiempo) = tiempo / 5
}

class RemoDeCompeticion inherits Remo {
    override method intensidad() = 1.7

    override method descanso(tiempo) = 2.max(super(tiempo) - 3)
}


////////////////////////////////PERSONA////////////////////////////////////////////

class Persona{
    var property rutina = null //pueden o no hacer una rutina
    var property peso;

    method tiempoEjercitando() //hook

    method kilosPorCaloria() //hook

    method hacerRutina() {
        peso -= self.pesoPerdidoAlHacerRutina()
    } 

    method pesoPerdidoAlHacerRutina(){
        return self.rutina().caloriasQueQuema(self.tiempoEjercitando()) / self.kilosPorCaloria()
    }
}

class Sedentario inherits Persona{
    override method kilosPorCaloria() = 7000

    var property tiempoEjercitando

    override method rutina() = peso > 50
}

class Atleta inherits Persona{
    override method kilosPorCaloria() = 8000

    override method tiempoEjercitando() = 90

    override method pesoPerdidoAlHacerRutina(){
        return super() - 1
    }

    override method hacerRutina() {
        if ( rutina.caloriasQueQuema(self.tiempoEjercitando()) > 1000) {
            super()
        } else {
            self.error("gastaria muchaszz calorias :C")
        }
    }
}
