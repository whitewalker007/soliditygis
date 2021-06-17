pragma solidity ^0.5.10;

import "./libs/helper.sol";

contract PointInPolygon {

    // using ArrayStorage32Lib for int32[];

    //Maximum latitude value
    int32 constant public MAX_LATITUDE = 90000000;
    //Minimum latitude value
    int32 constant public MIN_LATITUDE = -90000000;
    //Maximum longitude value
    int32 constant public MAX_LONGITUDE = 180000000;
    //Minimum longitude value
    int32 constant public MIN_LONGITUDE = -180000000;


    function point_in_polygon(int[] memory vertx, int[] memory verty, int testx, int testy) public returns(bool) {

        require(vertx.length > 2, "Number of X vertices should be grater than 2");
        require(verty.length > 2, "Number of Y vertices should be grater than 2");
        require(vertx.length == verty.length, "Number of X and Y vertices should be same");

        // check if the test point geometry lies b/w allowed latitude, longitude values
        require(
            testx <= MAX_LATITUDE && testx >= MIN_LATITUDE, 
            "Test point latitude out of range."
            );
        require(
            testy <= MAX_LONGITUDE && testy >= MIN_LONGITUDE, 
            "Test point longitude out of range."
            );

        // get the number of vertices in the polygon
        uint nvert = vertx.length;

        // check if all x vertex values lies b/w min-max latitude values
        for (uint x=0; x<nvert; x++) {
            require(
            vertx[x] <= MAX_LATITUDE && vertx[x] >= MIN_LATITUDE, 
            "vertx latitude out of range."
            );
        }

        // check if all y vertex values lies b/w min-max longitude values
        for (uint y=0; y<nvert; y++) {
            require(
            verty[y] <= MAX_LONGITUDE && verty[y] >= MIN_LONGITUDE, 
            "verty longitude out of range."
            );
        }

        /* 
        run the pnpoly (Point Inclusion in Polygon Test) algortihm. 
        https://wrf.ecse.rpi.edu/Research/Short_Notes/pnpoly.html
        */

        uint i = 0; 
        uint j = 0; 
        bool c = false;

        for (i = 0; i<nvert; i++) {
            if (i==0) {
                j = nvert-1;
            } else {
                j = i-1;
            }
            if (verty[j] > verty[i]) {  
    if ( ((verty[i]>testy) != (verty[j]>testy)) &&
	 ((testx - vertx[i])*(verty[j]-verty[i]) - ((vertx[j]-vertx[i]) * (testy-verty[i])) < 0) ){
         c = !c;
     }
    }
    else {
        if ( ((verty[i]>testy) != (verty[j]>testy)) &&
	 ((testx - vertx[i])*(verty[j]-verty[i]) - ((vertx[j]-vertx[i]) * (testy-verty[i])) > 0) ){
         c = !c;
     }
    }
    }
        return c;
  }

    function doIntersect(int[2] memory pointP1, int[2] memory pointQ1, int[2] memory pointP2, int[2] memory pointQ2) 
    public returns(bool) {
        // Find the four orientations needed for general and
        // special cases
        int o1 = helper.orientation(pointP1, pointQ1, pointP2);
        int o2 = helper.orientation(pointP1, pointQ1, pointQ2);
        int o3 = helper.orientation(pointP2, pointQ2, pointP1);
        int o4 = helper.orientation(pointP2, pointQ2, pointQ1);
    
        // General case
        if (o1 != o2 && o3 != o4) {
            return true;
        }
            
        // Special Cases
        // p1, q1 and p2 are colinear and p2 lies on segment p1q1
        if (o1 == 0 && helper.onSegment(pointP1, pointP2, pointQ1)) {
            return true;
        }
    
        // p1, q1 and q2 are colinear and q2 lies on segment p1q1
        if (o2 == 0 && helper.onSegment(pointP1, pointQ2, pointQ1)) {
            return true;
        }
    
        // p2, q2 and p1 are colinear and p1 lies on segment p2q2
        if (o3 == 0 && helper.onSegment(pointP2, pointP1, pointQ2)) {
            return true;
        }
    
        // p2, q2 and q1 are colinear and q1 lies on segment p2q2
        if (o4 == 0 && helper.onSegment(pointP2, pointQ1, pointQ2)) {
            return true;
        }

        return false;
    }
}