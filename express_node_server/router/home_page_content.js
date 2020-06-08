/**
 * 首页数据
 */
const express = require("express");
const router = express();

const config = require("./config")

const base_url = "http://" + config.IP + ":" + config.PORT + "/images/ad/";
const common_base_url = "http://" + config.IP + ":" + config.PORT + "/images/";

router.post("/", (req, res) => {

    var id = req.query.id;
    console.log('hot_page_content', "req.query.id  ::: ", id);
    var data = {
        "code": 0,
        "message": "success",
        "data": {
            "slides": [
                {
                    "image": common_base_url + "/swiper/001.jpeg",
                },
                {
                    "image": common_base_url + "/swiper/002.jpeg",
                },
                {
                    "image": common_base_url + "/swiper/003.jpeg",
                },
            ],
            'category': [
                {
                    "image": common_base_url + "category/001.jpg",
                    "firstCategoryName": "001",
                },
                {
                    "image": common_base_url + "category/002.jpg",
                    "firstCategoryName": "002",
                },
                {
                    "image": common_base_url + "category/003.jpeg",
                    "firstCategoryName": "003",
                },
                {
                    "image": common_base_url + "category/004.jpg",
                    "firstCategoryName": "004",
                },
                {
                    "image": common_base_url + "category/005.jpg",
                    "firstCategoryName": "005",
                },
                {
                    "image": common_base_url + "category/006.jpg",
                    "firstCategoryName": "006",
                },
                {
                    "image": common_base_url + "category/007.jpg",
                    "firstCategoryName": "007",
                },
                {
                    "image": common_base_url + "category/008.jpeg",
                    "firstCategoryName": "008",
                },
                {
                    "image": common_base_url + "category/009.jpg",
                    "firstCategoryName": "009",
                },
                {
                    "image": common_base_url + "category/010.jpg",
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
            'floor1': [
                {
                    "image": common_base_url + "floor/001.jpeg",
                    "goodsId": 001,
                },
                {
                    "image": common_base_url + "floor/002.jpeg",
                    "goodsId": 002,
                },
                {
                    "image": common_base_url + "floor/003.jpeg",
                    "goodsId": 003,
                },
                {
                    "image": common_base_url + "floor/004.jpeg",
                    "goodsId": 004,
                },
                {
                    "image": common_base_url + "floor/005.jpeg",
                    "goodsId": 005,
                },

            ],
            'floor1Pic': {
                "pic_address": common_base_url + "ad/001.jpeg",
                "to_place": 4,
            },
            'title': '这是一个首页',
        },
    };

    res.send(data);
});

module.exports = router;