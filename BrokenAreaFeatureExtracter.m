classdef BrokenAreaFeatureExtracter < FeatureExtracter

properties (SetAccess = private)
    sideLen=0;
end

methods
	function this = BrokenAreaFeatureExtracter(sideLen, categNum)
		this.sideLen=sideLen;
		this.categNum=categNum;
	end
	function S = saveobj(this)
		% Save property values in struct
		% Return struct for save function to write to MAT-file
		S.sideLen=this.sideLen;
		S.d = this.d;
		S.categNum = this.categNum;
	end
	function copy(this,S)
		% Method used to assign values from struct to properties
		this.sideLen=S.sideLen;
		this.d = S.d;
		this.categNum = S.categNum;
	end

	function f=extractOne(this,x)
		w=this.sideLen;
		h=this.sideLen;
		x = reshape(x, h, w);
        beg = fix(this.sideLen/2)*(0:2);
        areaSum=zeros(1,4);
        areaInd=1;
        for i = 1 : 2
            for j = 1 : 2
                subArea = x(beg(i)+1:beg(i+1), beg(j)+1:beg(j+1));
                areaSum(areaInd)= sum(sum(subArea));
                areaInd=areaInd+1;
            end
        end

		f = find(areaSum == min(areaSum));
		if size(f, 2) > 1
			f = f(fix(rand*size(f,2)) + 1);
		end
	end
end
end
