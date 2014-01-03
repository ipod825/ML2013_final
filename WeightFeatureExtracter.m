classdef WeightFeatureExtracter < FeatureExtracter

properties (SetAccess = private)
    sideLen=0;
    winLen=0;
    halfWinLen;
    winNum=0; 
    numFeaturePerWin;
end

methods
  function this = WeightFeatureExtracter(sideLen, categNum)
    this.sideLen = sideLen;
%     this.winLen=2*sideLen/8;
    this.winLen=this.sideLen;
    this.halfWinLen=this.winLen/2;
    this.winNum=((this.sideLen-this.halfWinLen)/this.halfWinLen)^2;
    this.numFeaturePerWin=7;
	this.d=this.winNum*this.numFeaturePerWin;
    this.categNum = categNum;
  end
  function S = saveobj(this)
  % Save property values in struct
  % Return struct for save function to write to MAT-file
      S.sideLen=this.sideLen;
      S.winLen=this.winLen;
      S.halfWinLen=this.winLen;
      S.winNum=this.winNum;
      S.d = this.d;
      S.categNum = this.categNum;
  end
  function copy(this,S)
  % Method used to assign values from struct to properties
      this.sideLen=S.sideLen;
      this.winLen=S.winLen;
      this.halfWinLen=S.winLen;
      this.winNum=S.winNum;
      this.d = S.d;
      this.categNum = S.categNum;
  end
  
  
  function f=extractOne(this,x)
    x = reshape(x, this.sideLen, this.sideLen);
%     winBegs=1:this.halfWinLen:this.winLen-this.halfWinLen+1;
%     winInd=1;
%     winScore=zeros(this.numFeaturePerWin,this.winNum);
%     for top=winBegs
%         bottom=top+this.winLen-1;
%         for left=winBegs
%             right=left+this.winLen-1;
%             winScore(:,winInd)=this.calcFeature(x(top:bottom,left:right));
%         end
%     end
%     f=reshape(winScore,1,this.d);
    f=calcFeature(this,x);
  end

  function geoFeature = calcFeature(this,img)

    %total weight of image
    weight = sum(img(:));

    % x projection & y projections
    rvec = sum(img, 1)';
    cvec = sum(img, 2);

    % Find the central moments of the horizontal and vertical projections

    % Find the 0th and 1st moments of H and V projections
    xmoment0 = [ones(1,this.winLen)]*rvec;
    ymoment0 = [ones(1,this.winLen)]*cvec;

    xmoment1 = [1:this.winLen]*rvec;
    ymoment1 = [1:this.winLen]*cvec;

    xcenter = xmoment1 / xmoment0;
    ycenter = ymoment1 / ymoment0;
    if isnan(xcenter)
      xcenter = 0;
    end
    if isnan(ycenter)
      ycenter = 0;
    end

    x_norm = [1:this.winLen]-xcenter;
    ind_x = [x_norm.^2 ; x_norm.^3 ; x_norm.^4];
    y_norm = [1:this.winLen]-ycenter;
    ind_y = [y_norm.^2 ; y_norm.^3 ; y_norm.^4];

    xmoment2 = ind_x(1,:)*rvec;
    ymoment2 = ind_y(1,:)*cvec;
    xmoment3 = ind_x(2,:)*rvec;
    ymoment3 = ind_y(2,:)*cvec;
    xmoment4 = ind_x(3,:)*rvec;
    ymoment4 = ind_y(3,:)*cvec;

    xskewness = xmoment3/(xmoment2^(3/2));
    yskewness = ymoment3/(ymoment2^(3/2));

    xkurtosis = xmoment4/(xmoment2^(2));
    ykurtosis = ymoment4/(ymoment2^(2));
    if isnan(xskewness)
      xskewness = 0;
    end
    if isnan(yskewness)
      yskewness = 0;
    end
    if isnan(xkurtosis)
      xkurtosis = 0;
    end
    if isnan(ykurtosis)
      ykurtosis = 0;
    end
    geoFeature = [weight xcenter ycenter xskewness yskewness xkurtosis ykurtosis];
  end
end % method end

end % class end
