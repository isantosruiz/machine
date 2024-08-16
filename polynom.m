classdef polynom < handle
    % POLYNOM Clase para el ajuste y evaluación de polinomios.
    %   Esta clase permite ajustar un polinomio a un conjunto de datos
    %   utilizando mínimos cuadrados, predecir valores en nuevas entradas
    %   y mostrar el polinomio en forma simbólica.

    properties
        coeff % Coeficientes del polinomio
    end

    methods
        function obj = fit(obj,x,y,n)
            % FIT Ajusta un polinomio de grado n a los datos (x, y).
            %   obj = FIT(obj, x, y, n) ajusta un polinomio de grado n a los
            %   puntos de datos especificados por x e y, almacenando los
            %   coeficientes en la propiedad coeff.
            %
            %   x - Vector de valores independientes
            %   y - Vector de valores dependientes
            %   n - Grado del polinomio a ajustar
            
            A = zeros(numel(y),n+1);
            for k = 0:n
                A(:,k+1) = x.^k;
            end
            obj.coeff = linsolve(A,y);
        end

        function y = predict(obj,x)
            % PREDICT Predice los valores y para nuevas entradas x.
            %   y = PREDICT(obj, x) devuelve los valores predichos de y
            %   para las entradas especificadas en el vector x, usando
            %   los coeficientes del polinomio ajustado en obj.coeff.
            %
            %   x - Vector de valores independientes
            
            y = zeros(size(x));
            n = numel(obj.coeff) - 1;
            for k = 0:n
                y = y + obj.coeff(k+1) * x.^k;
            end
        end

        function print(obj,x)
            % PRINT Muestra el polinomio en forma simbólica.
            %   PRINT(obj) muestra el polinomio ajustado en la consola en
            %   función de la variable 'x'.
            %
            %   PRINT(obj, x) permite especificar el nombre de la variable
            %   simbólica que se usará al mostrar el polinomio.
            %
            %   x - (Opcional) Nombre de la variable simbólica a usar.
            
            if nargin < 2
                x = 'x';
            end
            disp(poly2str(obj.coeff(end:-1:1)',x))
        end
    end
end
