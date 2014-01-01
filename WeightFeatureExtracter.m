classdef WeightFeatureExtracter < FeatureExtracter

properties (SetAccess = private)
    sideLen=0;
    winLen=0;
    winNum=0; 
    numFeaturePerWin;
end

methods
  function this = WeightFeatureExtracter(sideLen, categNum)
    this.sideLen = sideLen;
    this.winLen=2*sideLen/8;
    this.halfWinLen=this.winLen/2;
    this.winNum=((this.sideLen-this.halfWinLen)/this.halfWinLen)^2;
    this.numFeaturePerWin=7;
	this.d=this.winNum*this.numFeaturePerWin;
    this.categNum = categNum;
  end
  function S = saveobj(this)
  % Save property values in struct
  % Return struct for save function to write to MAT-file
      this.sideLen=S.sideLen;
      this.winLen=S.winLen;
      this.halfWinLen=S.winLen;
      this.winNum=S.winNum;
      this.d = S.d;
      this.categNum = S.categNum;
  end
  function copy(this,S)
  % Method used to assign values from struct to properties
      S.sideLen=this.sideLen;
      S.winLen=this.winLen;
      S.halfWinLen=this.winLen;
      S.winNum=this.winNum;
      S.d = this.d;
      S.categNum = this.categNum;
  end
  
  
  function f=extractOne(this,x)
    x = reshape(x, this.sideLen, this.sidLen);
    winBegs=1:this.halfWinLen:this.winLen-this.halfWinLen+1;
    winInd=1;
    winScore=zeros(this.numFeaturePerWin,this.winNum);
    for top=winBegs
        bottom=top+this.winLen-1;
        for left=winBegs
            right=left+this.winLen-1;
            winScore(:,winInd)=this.calcFeature(x(top:bottom,left:right));
        end
    end
    f=reshape(winScore,1,this.d);
  end

  function geoFeature = calcFeature(this,img)

    %total weight of image
    weight = sum(img(:));

    % x projection & y projections
    xvec = sum(img, 1)';
    yvec = sum(img, 2);

    % Find the central moments of the horizontal and vertical projections

    % Find the 0th and 1st moments of H and V projections
    xmoment0 = [ones(1,this.sideLen)]*xvec;
    ymoment0 = [ones(1,this.sideLen)]*yvec;

    xmoment1 = [1:normSideLength]*xvec;
    ymoment1 = [1:normSideLength]*yvec;

    xcenter = xmoment1 / xmoment0;
    ycenter = ymoment1 / ymoment0;

    x_norm = [1:normSideLength]-xcenter;
    ind_x = [x_norm.^2 ; x_norm.^3 ; x_norm.^4];
    y_norm = [1:normSideLength]-ycenter;
    ind_y = [x_norm.^2 ; x_norm.^3 ; x_norm.^4];

    xmoment3 = ind_x(1,:)*xvec;
    ymoment3 = ind_y(1,:)*yvec;
    xmoment4 = ind_x(2,:)*xvec;
    ymoment4 = ind_y(2,:)*yvec;
    xmoment5 = ind_x(3,:)*xvec;
    ymoment5 = ind_y(3,:)*yvec;

    xskewness = xmoment4/(xmoment3^(3/2));
    yskewness = ymoment4/(ymoment3^(3/2));

    xkurtosis = xmoment5/(xmoment3^(2));
    ykurtosis = ymoment5/(ymoment3^(2));
    geoFeature = [weight xcenter ycenter xskewness yskewness xkurtosis ykurtosis];
  end
end % method end

end % class end
