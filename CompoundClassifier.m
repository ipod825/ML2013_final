classdef CompoundClassifier < Classifier
properties
    numClassifiers;
    classifiers;
end
methods
    function S = saveobj(this)
    % Save property values in struct
    % Return struct for save function to write to MAT-file
        S.classifiers=cell(1,size(this.classifiers,2));
        for i=1:this.numClassifiers
            S.classifiers{1,i}=this.classifiers{1,i}.saveobj;
        end
    end
    function copy(this,S)
    % Method used to assign values from struct to properties
        for i=1:this.numClassifiers
            this.classifiers{1,i}.copy(S.classifiers{1,i}); 
        end    
    end
    function this=CompoundClassifier(classifiers)
        this.numClassifiers=size(classifiers,2);
        this.classifiers=classifiers;
    end
    function train(this,Y,F)
        for i=1:this.numClassifiers
            this.classifiers{1,i}.train(Y,F);
        end
    end
    function pred=classify(this,F)
        pred=zeros(size(F,1),1);
        cand=zeros(size(F,1),this.numClassifiers);
        for i=1:this.numClassifiers
            cand(:,i)=this.classifiers{1,i}.classify(F);
        end
        for i=1:size(F,1)
            if(cand(i,1)==cand(i,2) || cand(i,1)==cand(i,3))
                pred(i)=cand(i,1);
            elseif (cand(i,2)==cand(i,3))
                pred(i)=cand(i,2);
            else
                pred(i)=cand(i,1);
            end
        end
    end
end
end
