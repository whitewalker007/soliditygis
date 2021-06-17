pragma solidity ^0.5.10;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/pointPoly.sol";
// import "../../contracts/libs/ArrayStorage32Lib.sol";

contract TestPointInPolygon {


  function testPointInPolygon() public {
    // Get the deployed contract
    PointInPolygon _pip = PointInPolygon(DeployedAddresses.PointInPolygon());

    // Input:- Test point geometry. latitude and longitude should be upto 6 points to decimal. 
    // Inside the polygon
    int testx = 24952242;
    int testy = 60169601;

    // Outside the polygon
    // int testx = 24976567;
    // int testy = 60161250;

     // Input:- Test polygon geometry. Latitudes and longitudes should be upto 6 points to decimal.
    int[4] memory inputX = [int(24950899), int(24953492), int(24953510), int(24950958)];
    int[4] memory inputY = [int(60169158), int(60169158), int(60170104), int(60169990)];

  
    // create a dynamic array with input X and Y coordinates
    int[] memory vertx = new int[](inputX.length);
    int[] memory verty = new int[](inputY.length);

    for (uint x=0; x<inputX.length; x++) {
      vertx[x] = inputX[x];
    }

    for (uint y=0; y<inputY.length; y++) {
      verty[y] = inputY[y];
    }
    
    bool _expectedValue = true;

    Assert.equal(_pip.point_in_polygon(vertx, verty, testx, testy), _expectedValue, "Point not in polygon");
  }

  function testLineIntersection() public {
    // Get the deployed contract
    PointInPolygon _pip = PointInPolygon(DeployedAddresses.PointInPolygon());

    // Input:- Test points geometry. Not intersecting line segments (p1, q1) and (p2, q2)
    // int[2] memory pointP1 = [int(1),int(1)];
    // int[2] memory pointP2 = [int(1),int(2)];
    // int[2] memory pointQ1 = [int(10),int(1)];
    // int[2] memory pointQ2 = [int(10),int(2)];

    // Input:- Test points geometry. Intersecting line segments (p1, q1) and (p2, q2)
    int[2] memory pointP1 = [int(10),int(0)];
    int[2] memory pointP2 = [int(0),int(0)];
    int[2] memory pointQ1 = [int(0),int(10)];
    int[2] memory pointQ2 = [int(10),int(10)];
    
    bool _expectedValue = true;

    Assert.equal(_pip.doIntersect(pointP1, pointQ1, pointP2, pointQ2), _expectedValue, "Lines Doesn't Intersect");
  }
}