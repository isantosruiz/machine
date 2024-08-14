classdef irisClassifier < handle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        pdf_setosa
        pdf_versicolor
        pdf_virginica
    end

    methods
        function obj = irisClassifier()
            %UNTITLED3 Construct an instance of this class
            %   Detailed explanation goes here
        end

        function obj = train(obj,X,y)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            X_setosa = X(y=="setosa",:);
            mu_setosa = mean(X_setosa);
            Sigma_setosa = cov(X_setosa);
            obj.pdf_setosa = @(X) mvnpdf(X,mu_setosa,Sigma_setosa);

            X_versicolor = X(y=="versicolor",:);
            mu_versicolor = mean(X_versicolor);
            Sigma_versicolor = cov(X_versicolor);
            obj.pdf_versicolor = @(X) mvnpdf(X,mu_versicolor,Sigma_versicolor);

            X_virginica = X(y=="virginica",:);
            mu_virginica = mean(X_virginica);
            Sigma_virginica = cov(X_virginica);
            obj.pdf_virginica = @(X) mvnpdf(X,mu_virginica,Sigma_virginica);
        end

        function clase = predict(obj,X_test)
            p1 = obj.pdf_setosa(X_test);
            p2 = obj.pdf_versicolor(X_test);      
            p3 = obj.pdf_virginica(X_test);
            [~,idx] = max([p1,p2,p3]);
            nombres = ["setosa","versicolor","virginica"];
            clase = nombres(idx);
        end
    end
end