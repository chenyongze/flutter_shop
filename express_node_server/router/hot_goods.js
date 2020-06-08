/**
 * 首页数据
 */
const express = require("express");
const router = express();

const config = require("./config")

const base_url = "http://" + config.IP + ":" + config.PORT + "/images/ad/";

router.post("/", (req, res) => {

    var id = req.query.id;
    console.log('hot_goods', "req.query.id  ::: ", id);
    var data = {
        "code": 0,
        "message": "success",
        "data": [
            {
                "name": "商品001",
                "image": base_url + "180.png",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品002",
                "image": base_url + "180.png",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品003",
                "image": base_url + "180.png",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品004",
                "image": base_url + "180.png",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100.89,
            },
            {
                "name": "商品005",
                "image": base_url + "180.png",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品006",
                "image": base_url + "180.png",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品007",
                "image": base_url + "180.png",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
            {
                "name": "商品008",
                "image": base_url + "180.png",
                "presentPrice": 98.78,
                "goodsId": 001,
                "oriPrice": 100,
            },
        ],
    };

    res.send(data);
});

module.exports = router;