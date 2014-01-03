classdef CompoundClassifier < Classifier
properties
    numClassifiers;
    classifiers;
    classifiersFName;
    weight;
end
methods
    function S = saveobj(this)
    % Save property values in struct
    % Return struct for save function to write to MAT-file
        S.numClassifiers=this.numClassifiers;
        S.classifiersFName=this.classifiersFName;
%         S.weight=this.weight;
    end
    function copy(this,S)
    % Method used to assign values from struct to properties
        this.numClassifiers=S.numClassifiers;
%         this.weight=S.weight;
        for i=1:this.numClassifiers
            load(char(this.classifiersFName{1,i}));
            this.classifiers{1,i}.copy(classifier);
        end
    end
    
    function this=CompoundClassifier(classifiers,compoundClassifierFName,weight)
        this.numClassifiers=size(classifiers,2);
        this.classifiers=classifiers;
        this.classifiersFName=compoundClassifierFName;
        this.weight=weight;
    end
    function train(this,Y,F)
%         for i=1:this.numClassifiers
%             this.classifiers{1,i}.train(Y,F);
%         end
    end
    function pred=classify(this,F)
        cand=zeros(size(F,1),this.numClassifiers);
        for i=1:this.numClassifiers
            cand(:,i)=this.classifiers{1,i}.classify(F);
        end
        
        for i=1:size(F,1)
            ballot=zeros(1,12);
            for j=1:this.numClassifiers
                ballot(cand(i,j))=ballot(cand(i,j))+this.weight(j);
            end
            [~, pred(i,1)]=max(ballot);
        end
        
%         for i=1:size(F,1)
%             if(cand(i,1)==cand(i,2) || cand(i,1)==cand(i,3))
%                 pred(i)=cand(i,1);
%             elseif (cand(i,2)==cand(i,3))
%                 pred(i)=cand(i,2);
%             else
%                 pred(i)=cand(i,1);
%             end
%         end
    end
end
end
