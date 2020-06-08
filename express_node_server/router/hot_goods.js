/**
 * 首页数据
 */
const express = require("express");
const router = express();

const config = require("./config")

const common_base_url = "http://" + config.IP + ":" + config.PORT + "/images/";

router.post("/", (req, res) => {

    var id = req.query.id;
    console.log('hot_goods', "req.query.id  ::: ", id);
    var data = {
        "code": 0,
        "message": "success",
        "data": [
            {
                "name": "商品001",
                "image": common_base_url + "/goods/001.jpeg",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品002",
                "image": common_base_url + "/goods/002.jpeg",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品003",
                "image": common_base_url + "/goods/003.jpeg",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品004",
                "image": common_base_url + "/goods/004.jpeg",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100.89,
            },
            {
                "name": "商品005",
                "image": common_base_url + "/goods/005.jpeg",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品006",
                "image": common_base_url + "/goods/006.jpeg",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品007",
                "image": common_base_url + "/goods/007.jpeg",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品008",
                "image": common_base_url + "/goods/008.jpeg",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
        ],
    };

    res.send(data);
});

module.exports = router;