/**
 * 首页数据
 */
const express = require("express");
const router = express();

const config = require("./config")

const base_url = "http://" + config.IP + ":" + config.PORT + "/images/ad/";

router.post("/", (req, res) => {

    var id = req.query.id;
    console.log('hot_page_content', "req.query.id  ::: ", id);
    var data = {
        "code": 0,
        "message": "success",
        "data": {
            "slides": [
                {
                    "image": base_url + "180.png",
                },
                {
                    "image": base_url + "180.png",
                },
                {
                    "image": base_url + "180.png",
                },
                {
                    "image": base_url + "180.png",
                },
            ],
            'category': [
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "001",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "002",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "003",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "004",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "005",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "006",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "007",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "008",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "009",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "010",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "011",
                },
            ],
            'recommend': [
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
            'floor1': [
                {
                    "image": base_url + "180.png",
                    "goodsId": 001,
                },
                {
                    "image": base_url + "180.png",
                    "goodsId": 002,
                },
                {
                    "image": base_url + "180.png",
                    "goodsId": 003,
                },
                {
                    "image": base_url + "180.png",
                    "goodsId": 004,
                },
                {
                    "image": base_url + "180.png",
                    "goodsId": 005,
                },

            ],
            'floor1Pic': {
                "pic_address": base_url + "180.png",
                "to_place": 4,
            },
            'title': '这是一个首页',
        },
    };

    res.send(data);
});

module.exports = router;