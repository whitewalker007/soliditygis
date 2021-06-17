pragma solidity ^0.5.10;


library helper {
    // get maximum of two numbers
    function max(int x, int y) internal returns(int){
        if (x > y){
            return x;
        } else {
            return y;
        }
    }

    // get minimum of two numbers
    function min(int x, int y) internal returns(int){
        if (x < y){
            return x;
        } else {
            return y;
        }
    }

    // Given three colinear points p, q, r, the function checks if
    // point q lies on line segment 'pr'
    function onSegment(int[2] memory pointP, int[2] memory pointQ, int[2] memory pointR) internal returns(bool) {
      if (pointP[0] <= max(pointP[0], pointR[0]) && pointQ[0] >= min(pointP[0], pointR[0]) &&
        pointQ[1] <= max(pointP[1], pointR[1]) && pointQ[1] >= min(pointP[1], pointR[1])) {
            return true;
        } else {
            return false;
        }
  }

    // To find orientation of ordered triplet (p, q, r).
    // The function returns following values
    // 0 --> p, q and r are colinear
    // 1 --> Clockwise
    // 2 --> Counterclockwise
    function orientation(int[2] memory pointP, int[2] memory pointQ, int[2] memory pointR) internal returns(int) {
      int val = (pointQ[1] - pointP[1])*(pointR[0] - pointQ[0]) - (pointQ[0] - pointP[0])*(pointR[1] - pointQ[1]);
    
      if (val == 0) {
          return 0; // colinear
      } else if (val > 0) {
          return 1; // clock wise
      } else {
          return 2; //counterclock wise
      }
    }
}
