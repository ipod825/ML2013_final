classdef WeightFeatureExtracter < FeatureExtracter

properties (SetAccess = private)
    sideLen=0;
end

methods
  function this = WeightFeatureExtracter(sideLen, categNum)
    this.sideLen = sideLen;
    this.d = 7;
    this.categNum = categNum;
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
      this.d=S.d;
      this.categNum=S.categNum;
  end
  function f=extractOne(this,x)
    global normSideLength
    GLOBALVAR;
    x = reshape(x, normSideLength, normSideLength);
    f=this.calcFeature(x);
  end

  function geoFeature = calcFeature(this,img)
    global normSideLength

    %total weight of image
    weight = sum(img(:));

    % x projection & y projections
    xvec = sum(img, 1)';
    yvec = sum(img, 2);

    % Find the central moments of the horizontal and vertical projections

    % Find the 0th and 1st moments of H and V projections
    xmoment0 = [ones(1,normSideLength)]*xvec;
    ymoment0 = [ones(1,normSideLength)]*yvec;

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
