classdef irisClassifier < handle
    % irisClassifier Clasificador de flores Iris basado en distribuciones Gaussianas
    %   Esta clase implementa un clasificador para las especies de flores Iris 
    %   ('setosa', 'versicolor', 'virginica') usando distribuciones 
    %   de probabilidad multivariante (Gaussiana).
    %
    % Propiedades:
    %   pdf_setosa - Función de densidad de probabilidad para la especie Setosa.
    %   pdf_versicolor - Función de densidad de probabilidad para la especie Versicolor.
    %   pdf_virginica - Función de densidad de probabilidad para la especie Virginica.
    %
    % Métodos:
    %   irisClassifier() - Constructor de la clase.
    %   train(X, y) - Entrena el clasificador usando los datos de entrada X y las etiquetas y.
    %   predict(X_test) - Predice la especie de los datos de prueba X_test.
    %
    % Ejemplo de uso:
    %   cls = irisClassifier();
    %   cls.train(X, y);
    %   pred = cls.predict(X_test);

    properties
        pdf_setosa
        pdf_versicolor
        pdf_virginica
    end

    methods
        function obj = irisClassifier()
            % irisClassifier Constructor
            %   Inicializa una instancia de la clase irisClassifier.
        end

        function obj = train(obj, X, y)
            % train Entrena el clasificador con datos etiquetados
            %   train(obj, X, y) calcula las distribuciones Gaussianas 
            %   para cada especie en el conjunto de datos X etiquetado 
            %   con y. X es una matriz de características y y es un 
            %   vector categórico con las especies.
            %
            %   Ejemplo de uso:
            %       cls.train(X, y);
            %
            %   Parámetros:
            %       X - Matriz de tamaño [N x M] donde N es el número 
            %           de muestras y M el número de características.
            %       y - Vector categórico de longitud N con las especies.

            % Filtra los datos por especie y calcula sus parámetros Gaussianos
            X_setosa = X(y == "setosa", :);
            mu_setosa = mean(X_setosa);
            Sigma_setosa = cov(X_setosa);
            obj.pdf_setosa = @(X) mvnpdf(X, mu_setosa, Sigma_setosa);

            X_versicolor = X(y == "versicolor", :);
            mu_versicolor = mean(X_versicolor);
            Sigma_versicolor = cov(X_versicolor);
            obj.pdf_versicolor = @(X) mvnpdf(X, mu_versicolor, Sigma_versicolor);

            X_virginica = X(y == "virginica", :);
            mu_virginica = mean(X_virginica);
            Sigma_virginica = cov(X_virginica);
            obj.pdf_virginica = @(X) mvnpdf(X, mu_virginica, Sigma_virginica);
        end

        function clase = predict(obj, X_test)
            % predict Predice la especie de nuevas muestras
            %   clase = predict(obj, X_test) devuelve las predicciones 
            %   de la especie para las muestras de prueba X_test basándose 
            %   en las distribuciones Gaussianas entrenadas.
            %
            %   Ejemplo de uso:
            %       pred = cls.predict(X_test);
            %
            %   Parámetros:
            %       X_test - Matriz de tamaño [N x M] con los datos de 
            %                prueba.
            %
            %   Salidas:
            %       clase - Vector categórico de tamaño [N x 1] con las 
            %               predicciones de la especie para cada muestra.

            % Calcula la probabilidad de cada muestra bajo cada distribución
            p1 = obj.pdf_setosa(X_test);
            p2 = obj.pdf_versicolor(X_test);      
            p3 = obj.pdf_virginica(X_test);

            % Determina la clase con la mayor probabilidad
            [~, idx] = max([p1, p2, p3], [], 2);
            nombres = ["setosa", "versicolor", "virginica"];
            clase = nombres(idx);
        end
    end
end
