const pointInpolygon = artifacts.require("PointInPolygon");

module.exports = (deployer) => {
    deployer.deploy(pointInpolygon);
}