# Manual para la instalación

En la consola de comandos:

Nos paramos en la carpeta donde queremos tener el servidor SAMP

    $ cd /users/santi/desktop/newclan-roleplay-linux
   
   Ahora que estamos en el directorio, iniciaremos un repo de GIT
   

    $ git init
   
   Ahora clonamos el repositorio de New Clan en nuestra carpeta local
   

    $ git clone https://github.com/sdantuoni/newclanrp-vps/
   
   Y con esto ya tendremos el mismo contenido que en el VPS en nuestra carpeta local.

Ahora si por ejemplo modificamos la GM y la queremos subir, simplemente la compilamos en donde esta, por defecto /gamemodes/nombre.amx.

Entonces ahora si abrimos la consola y estando parados en la carpeta donde tenemos el repositorio local, y ponemos 

    $ git status

Podremos ver que se nos pone el o los archivos que acabamos de modificar en color rojo, esto quiere decir que hay un archivo modificado en nuestro repositorio local, lo que debemos hacer ahora es subir estas modificaciones al repositorio en remoto, para ello haremos lo siguiente.

Crear una branch con un nombre descriptivo de los cambios hechos, por ejemplo

    $ git checkout -b agregar-trabajo-camionero

Entonces sabemos que la branch **agregar-trabajo-camionero** contiene las modificaciones a la gm para agregar ese trabajo.

El siguiente paso es añadir los cambios a la branch, haciendo el uso de git add.

> Si solo cambiamos un archivo, como seria el caso del gamemode, lo
> mejor es usar " git add . " lo cual añade a la branch todos los
> archivos modificados. De esta forma nos ahorramos escribir el
> directorio de la gm, ya que si por ejemplo modificamos otro archivo
> pero solo queremos subir la gm tendiramos que usar "git add
> /gamemodes/nombre.amx".

Ahora entonces usaremos el siguiente comando para agregar los archivos cambiados a la branch

    $ git add .

Una vez añadidos los cambios podemos usar el siguiente comando para verificar que se añadieron correctamente, si asi es los archivos añadidos pasaran de estar en color rojo a color verde al ejecutar nuevamente

    $ git status

Ahora el siguiente paso es crear un commit, que es como un comentario mas extenso de lo que hicimos, por ejemplo.

    $ git commit -m "Se agregaron variables nuevas, camiones de diferente modelo al trabajo y nuevos permisos"

Y ya casi esta listo, luego de todo esto nuestro commit esta listo para ser subido a el repositorio remoto, ahora lo que tenemos que hacer es un push

    $ git push origin nombre_branch

Lo unico que debes cambiar en ese comando es nombre_branch por el nombre de la branch que creaste, en este caso "agregar-trabajo-camionero".

Ahora si entras a [https://github.com/sdantuoni/newclanrp-vps/](https://github.com/sdantuoni/newclanrp-vps/) veras un mensaje en amarillo arriba diciendo que la branch  "agregar-trabajo-camionero", esta diferente a la branch MASTER que es digamos la branch original del repositorio, entonces lo que debes hacer es presionar el boton verde, darle luego al otro boton verde que dice crear pull request, y luego al otro boton verde que dice Merge pull request, ATENCION: Al darle en Merge lo que estas haciendo es enviar tus cambios a la bran MASTER, si por ejemplo tenes dudas de que hayan faltas de ortografía o algo que preferis que otro integrante del equipo revise, lo dejas asi, sin darle a Merge pull request, entonces le avisas a tu colega que hay una pull request pendiente, y que el la revise. Entonces tu colega revisara los cambios y si hay alguna falta la podra modificar por ti y luego darle a Merge pull request para que queden los cambios en MASTER.

[www.newclan.com.uy](www.newclan.com.uy)


 
