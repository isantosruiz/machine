classdef mascota < handle
    %MASCOTA Clase que representa a una mascota con propiedades como nombre,
    % edad, raza y un número limitado de vidas.
    % 
    %   Esta clase permite crear un objeto mascota, gestionar el número
    %   de vidas y generar un saludo de la mascota utilizando la librería
    %   gTTS (Google Text-to-Speech) a través de Python.
    
    properties
        nombre  % Nombre de la mascota (cadena de texto)
        edad    % Edad de la mascota (número)
        raza    % Raza de la mascota (cadena de texto)
        vidas = 7;  % Número de vidas de la mascota, por defecto 7
    end

    methods
        function obj = mascota(nombre, edad, raza)
            %MASCOTA Constructor de la clase.
            %   Inicializa una instancia de la clase `mascota` con un nombre,
            %   una edad y una raza especificados.
            %
            %   obj = MASCOTA(nombre, edad, raza) crea una mascota con
            %   las propiedades nombre, edad y raza.
            
            obj.nombre = nombre;
            obj.raza = raza;
            obj.edad = edad;
        end

        function obj = morir(obj)
            %MORIR Reduce el número de vidas de la mascota en uno.
            %   Si la mascota aún tiene vidas, se reduce el contador en 1.
            %   Si no tiene vidas restantes, se muestra un mensaje indicando
            %   que la mascota ya no tiene vidas.
            
            if obj.vidas > 0
                obj.vidas = obj.vidas - 1;
            else
                disp("La mascota ya había muerto antes.")
            end
        end

        function saludar(obj, saludo, n)
            %SALUDAR Genera un saludo en formato de audio y lo reproduce.
            %   Utiliza la librería gTTS (Google Text-to-Speech) para generar un
            %   saludo en formato MP3, y luego reproduce el saludo n veces.
            %
            %   SALUDAR(obj, saludo, n) genera el saludo especificado en
            %   la variable `saludo` y lo reproduce `n` veces.
            %
            %   Inputs:
            %   - saludo: Cadena de texto con el mensaje que se desea que la
            %     mascota "diga".
            %   - n: Número de veces que se repetirá el saludo.
            
            out = py.gtts.gTTS(saludo, lang="es");
            out.save("saludo_mascota.mp3");
            [y, Fs] = audioread("saludo_mascota.mp3");
            disp(obj.nombre + ": ")
            for k = 1:n
                sound(y, Fs)
                pause(2)
            end
        end
    end
end